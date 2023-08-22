extends State
class_name ChaseEnemyMovement

@export var actor: Enemy
@export var grid_movement: GridMovement
@export var attack_movement: AttackMovement

@export var player_pathfinding: PlayerPathfinding
	
func Physics_update(_delta):
	if TurnBasedMovement.is_enemy_turn() and not grid_movement.is_moving() and not attack_movement.is_attacking:
		var direction = next_move_direction()
		var collider = grid_movement.move(direction)
		
		if collider == null:
			grid_movement.execute_move(direction)
		else:
			if collider is Node:
				var owner = collider.owner
				if owner is Player:
					var damage = BattleHelper.enemy_attack(owner.player_resource, actor.enemy_resource)
					owner.get_damage(damage)
					attack_movement.execute_attack(direction)
	
func next_move_direction() -> Vector2:
	var path_ids = player_pathfinding.get_path_to_player(actor)
	if path_ids.size() == 0:
		push_warning("No path to reach the player!")
		return Vector2.ZERO
	elif path_ids.size() > actor.enemy_resource.range:
		transitioned.emit("RoamingEnemyMovement")
		return Vector2.ZERO
		
	var next_direction = path_ids[1] - path_ids[0]
	return next_direction

func _on_grid_movement_movement_completed():
	TurnBasedMovement.turn_completed(TurnBasedMovement.Turn.ENEMY)

func _on_attack_movement_attack_completed():
	TurnBasedMovement.turn_completed(TurnBasedMovement.Turn.ENEMY)
