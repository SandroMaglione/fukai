extends Node2D
class_name Player

@onready var grid_movement: GridMovement = $GridMovement
 
func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)
 
func _process(_delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var collider = grid_movement.move(input_direction)
	
	if collider == null:
		grid_movement.execute_move(input_direction)

func _on_grid_movement_collided(body, movement):
	print(body)
	if body is TileMap:
		var coords = body.local_to_map(global_position + movement * Constants.TILE_SIZE)
		var tile_data = body.get_cell_tile_data(1, coords)
		if tile_data != null:
			var collect_item_resource = tile_data.get_custom_data("collect_item_resource")
			if collect_item_resource is CollectItemResource:
				print(collect_item_resource)
		
	if body is Stairs:
		body.complete_tier()
		grid_movement.execute_move(movement)
	elif body is Coin:
		body.collect_coin()
		grid_movement.execute_move(movement)
