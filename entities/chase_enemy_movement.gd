extends State
class_name ChaseEnemyMovement

@export var actor: Enemy
@export var grid_movement: GridMovement
@export var attack_movement: AttackMovement

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
	var actor_coords = tilemap.local_to_map(actor.global_position)
	var player_coords = tilemap.local_to_map(player.global_position)
	
	var path_ids = astar_grid.get_id_path(actor_coords, player_coords)
	if path_ids.size() == 0:
		push_warning("No path to reach the player!")
		return Vector2.ZERO
		
	# Index 0 is current position, so use index 1
	var next_path_id = path_ids[1]
	var next_direction = next_direction_from_path(actor_coords, next_path_id)
	
	return next_direction

func next_direction_from_path(start: Vector2i, end: Vector2i) -> Vector2:
	return end - start


func _on_grid_movement_movement_completed():
	TurnBasedMovement.turn_completed(TurnBasedMovement.Turn.ENEMY)

func _on_attack_movement_attack_completed():
	TurnBasedMovement.turn_completed(TurnBasedMovement.Turn.ENEMY)
