extends TurnActor
class_name Player

@export var player_resource: PlayerResource

@export var inventory_in_game: InventoryInGame

@onready var grid_movement: GridMovement = $GridMovement
@onready var attack_movement: AttackMovement = $AttackMovement
@onready var health_bar: HealthBar = $HealthBar

var health: int:
	set(value):
		health_bar.update_health(value)
		health = value

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)
	
	health = player_resource.health
	health_bar.init_health(health)
 
func _process(_delta):
	if can_move and not grid_movement.is_moving() and not attack_movement.is_attacking:
		if Input.is_action_just_pressed("use_potion"):
			if inventory_in_game.inventory.potions > 0 and health < player_resource.health:
				health += 3
				inventory_in_game.on_use_potion()
		else:
			var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			
			if input_direction.length() != 0:
				var collider = grid_movement.move(input_direction)
				
				if collider == null:
					grid_movement.execute_move(input_direction)
				else:
					if collider is Node:
						var node_owner = collider.owner
						if node_owner is Enemy:
							var damage = BattleHelper.player_attack(player_resource, node_owner.enemy_resource)
							node_owner.get_damage(damage)
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
		inventory_in_game.on_collect_coin()
		
		body.set_cell(Constants.COINS_LAYER_ID, coords, -1)

func collect_item(body: TileMap, coords: Vector2i) -> void:
	var tile_data = body.get_cell_tile_data(Constants.COLLECT_ITEM_LAYER_ID, coords)
	if tile_data != null:
		var collect_item_resource = tile_data.get_custom_data("collect_item_resource")
		
		if collect_item_resource is CollectItemResource:
			var can_collect = inventory_in_game.on_collect_item(collect_item_resource)
			if can_collect:
				body.set_cell(Constants.COLLECT_ITEM_LAYER_ID, coords, -1)

func get_damage(damage: int) -> void:
	health -= damage
	
	if health <= 0:
		print("Done")

func _on_grid_movement_movement_completed():
	turn_completed.emit(self)

func _on_attack_movement_attack_completed():
	turn_completed.emit(self)
