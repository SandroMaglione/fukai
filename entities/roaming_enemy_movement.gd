extends State
class_name RoamingEnemyMovement

@export var actor: Enemy

@export var grid_movement: GridMovement
@export var player_pathfinding: PlayerPathfinding

func Physics_update(_delta):
	if actor.can_move and not grid_movement.is_moving():
		var path = player_pathfinding.get_path_to_player(actor)
		
		if path.size() <= actor.enemy_resource.movement_range:
			transitioned.emit("ChaseEnemyMovement")
		else:
			var direction = random_direction()
			var collider = grid_movement.move(direction)
			
			if collider == null:
				grid_movement.execute_move(direction)
			else:
				actor.turn_completed.emit(actor)		
		
func random_direction() -> Vector2:
	var rand = randi() % 5
	
	if rand == 0:
		return Vector2.UP
	elif rand == 1:
		return Vector2.DOWN
	elif rand == 2:
		return Vector2.LEFT
	elif rand == 3:
		return Vector2.RIGHT
	
	return Vector2.ZERO

func _on_grid_movement_movement_completed():
	actor.turn_completed.emit(actor)
