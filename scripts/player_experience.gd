extends Node

const initial_player_actor_resource = preload("res://entities/instances/initial_player_actor_resource.tres")

var player_stats: ActorResource

var current_level: int = 1
var experience_before_next_level: int = 1000

var available_skill_points: int = 0

func _ready():
	player_stats = initial_player_actor_resource

func on_enemy_defeated(enemy: Enemy) -> void:
	pass
	
func on_tier_completed() -> void:
	pass
