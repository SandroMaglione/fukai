extends State
class_name ChaseEnemyMovement

@export var actor: Node2D
@export var grid_movement: GridMovement

var tilemap: TileMap
var player: Node2D

var astar_grid: AStarGrid2D

func _ready():
	player = get_tree().get_nodes_in_group("player")[0] as Node2D
	tilemap = get_tree().get_nodes_in_group("tilemap")[0] as TileMap
	
	
	astar_grid = AStarGrid2D.new()
	
	astar_grid.region = tilemap.get_used_rect()
	astar_grid.cell_size = Vector2.ONE * Constants.TILE_SIZE
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	
	astar_grid.update()
	
	var walls = tilemap.get_used_cells(Constants.WALLS_LAYER_ID)
	for cell in walls:
		print(cell)
		astar_grid.set_point_solid(cell)
	
func Physics_update(_delta):
	if TurnBasedMovement.is_enemy_turn() and not grid_movement.is_moving():
		var direction = next_move_direction()
		var collider = grid_movement.move(direction)
		
		if collider == null:
			grid_movement.execute_move(direction)
	
func next_move_direction() -> Vector2:
	var actor_coords = tilemap.local_to_map(actor.global_position)
	var player_coords = tilemap.local_to_map(player.global_position)
	
	var path_ids = astar_grid.get_id_path(actor_coords, player_coords)
	print(path_ids)
	
	var next_path_id = path_ids[1]
	print(astar_grid.is_point_solid(next_path_id))
	
	var next_direction = next_direction_from_path(actor_coords, next_path_id)
	
	
	if path_ids.size() == 2:
		_on_grid_movement_movement_completed()
		print("Attack!", next_direction)
		return Vector2.ZERO
	else:
		return next_direction

func next_direction_from_path(start: Vector2i, end: Vector2i) -> Vector2:
	return end - start


func _on_grid_movement_movement_completed():
	TurnBasedMovement.turn_completed(TurnBasedMovement.Turn.ENEMY)
