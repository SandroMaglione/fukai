extends Node
class_name PlayerPathfinding

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
	var stairs = tilemap.get_used_cells(Constants.STAIRS_LAYER_ID)
	walls.append_array(stairs)
	
	for cell in walls:
		astar_grid.set_point_solid(cell)
		
func get_path_to_player(actor: Enemy) -> Array[Vector2i]:
	var actor_coords = tilemap.local_to_map(actor.global_position)
	var player_coords = tilemap.local_to_map(player.global_position)
	return astar_grid.get_id_path(actor_coords, player_coords)
