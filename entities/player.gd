extends Node2D
class_name Player
 
func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)
 
func _process(_delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	$GridMovement.move(input_direction)

func _on_grid_movement_collided(body):
	print(body)
	if body is CollectItem:
		body.on_collect_item()
	elif body is Stairs:
		body.complete_tier()
