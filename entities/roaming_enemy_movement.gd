extends State
class_name RoamingEnemyMovement

@export var grid_movement: GridMovement

func Physics_update(_delta):
	if TurnBasedMovement.is_enemy_turn():
		var direction = random_direction()
		var collider = grid_movement.move(direction)
		
		if collider == null:
			grid_movement.execute_move(direction)
			TurnBasedMovement.turn_completed()
		
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
