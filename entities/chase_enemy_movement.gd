extends State
class_name ChaseEnemyMovement

@export var actor: Enemy
@export var grid_movement: GridMovement
@export var attack_movement: AttackMovement

@export var player_pathfinding: PlayerPathfinding
	
func Physics_update(_delta):
	if actor.can_move and not grid_movement.is_moving() and not attack_movement.is_attacking:
		var direction = next_move_direction()
		var collider = grid_movement.move(direction)
		
		if collider == null:
			grid_movement.execute_move(direction)
			return
		else:
			if collider is Node:
				var node_owner = collider.owner
				if node_owner is Player:
					var damage = BattleHelper.enemy_attack(actor.enemy_resource)
					attack_movement.execute_attack(direction, node_owner, damage)
					return
		
		# Otherwise no movement
		actor.turn_completed.emit(actor)
	
func next_move_direction() -> Vector2:
	var path_ids = player_pathfinding.get_path_to_player(actor)
	if path_ids.size() == 0:
		push_warning("No path to reach the player!")
		return Vector2.ZERO
	elif path_ids.size() > actor.enemy_resource.movement_range:
		transitioned.emit("RoamingEnemyMovement")
		return Vector2.ZERO
		
	# TODO: Potential bug, check length!
	var next_direction = path_ids[1] - path_ids[0]
	return next_direction

func _on_grid_movement_movement_completed():
	actor.turn_completed.emit(actor)

func _on_attack_movement_attack_completed():
	actor.turn_completed.emit(actor)
