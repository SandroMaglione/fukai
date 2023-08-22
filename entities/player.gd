extends Node2D
class_name Player

@export var player_resource: PlayerResource

@onready var grid_movement: GridMovement = $GridMovement
@onready var attack_movement: AttackMovement = $AttackMovement

@onready var health: int = player_resource.health

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)
 
func _process(_delta):
	if TurnBasedMovement.is_player_turn() and not grid_movement.is_moving() and not attack_movement.is_attacking:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		if input_direction.length() != 0:
			var collider = grid_movement.move(input_direction)
			
			if collider == null:
				grid_movement.execute_move(input_direction)
			else:
				if collider is Node:
					var owner = collider.owner
					if owner is Enemy:
						var damage = BattleHelper.player_attack(player_resource, owner.enemy_resource)
						owner.get_damage(damage)
						attack_movement.execute_attack(input_direction)

func _on_grid_movement_collided(body, movement):
	if body is TileMap:
		var coords = body.local_to_map(global_position + movement * Constants.TILE_SIZE)
		
		collect_item(body, coords)
		step_on_stairs(body, coords)
		collect_coin(body, coords)
		
func step_on_stairs(body: TileMap, coords: Vector2i) -> void:
	var source_id = body.get_cell_source_id(Constants.STAIRS_LAYER_ID, coords)
	if source_id != -1:
		print("Stairs")
		
func collect_coin(body: TileMap, coords: Vector2i) -> void:
	var source_id = body.get_cell_source_id(Constants.COINS_LAYER_ID, coords)
	if source_id != -1:
		print("Coin")
		body.set_cell(Constants.COINS_LAYER_ID, coords, -1)

func collect_item(body: TileMap, coords: Vector2i) -> void:
	var tile_data = body.get_cell_tile_data(Constants.COLLECT_ITEM_LAYER_ID, coords)
	if tile_data != null:
		var collect_item_resource = tile_data.get_custom_data("collect_item_resource")
		
		if collect_item_resource is CollectItemResource:
			print(collect_item_resource.name)
			body.set_cell(Constants.COLLECT_ITEM_LAYER_ID, coords, -1)

func get_damage(damage: int) -> void:
	health -= damage
	
	if health < 0:
		print("Done")

func _on_grid_movement_movement_completed():
	TurnBasedMovement.turn_completed(TurnBasedMovement.Turn.PLAYER)

func _on_attack_movement_attack_completed():
	TurnBasedMovement.turn_completed(TurnBasedMovement.Turn.PLAYER)
