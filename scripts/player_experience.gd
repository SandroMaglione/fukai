extends Node

class PowerUpUsage:
	var potion_resource: PotionResource
	var turns_left: int = 6
	
	func _init(pr: PotionResource):
		potion_resource = pr

const initial_player_actor_resource = preload("res://entities/instances/initial_player_actor_resource.tres")

var player_stats: ActorResource

var current_level: int = 1
var experience_before_next_level: int = 1000

var available_skill_points: int = 10

var current_power_up: PowerUpUsage

func _ready():
	player_stats = initial_player_actor_resource.duplicate()
	
func player_stats_power_up() -> ActorResource:
	var actor_resource: ActorResource = player_stats.duplicate()
	if current_power_up != null:
		if current_power_up.potion_resource.name == "speed":
			actor_resource.speed += 1
		elif current_power_up.potion_resource.name == "attack":
			actor_resource.attack += 1
		elif current_power_up.potion_resource.name == "defense":
			actor_resource.defense += 1
	return actor_resource
	
func on_potion_used(potion_resource: PotionResource) -> void:
	if current_power_up == null:
		GlobalInventory.on_use_potion(potion_resource)
		if potion_resource.name == "health":
			get_player().health += 3
		else:
			current_power_up = PowerUpUsage.new(potion_resource)

func on_player_turn_completed() -> void:
	if current_power_up != null:
		if current_power_up.turns_left == 1:
			current_power_up = null
		else:
			current_power_up.turns_left -= 1

func on_enemy_defeated(enemy: Enemy) -> void:
	pass
	
func on_tier_completed() -> void:
	pass
	
func get_player() -> Player:
	return get_tree().get_nodes_in_group("player")[0] as Player
