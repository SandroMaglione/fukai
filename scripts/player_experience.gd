extends Node

var current_level: int = 1
var experience_before_next_level: int = 1000

var available_skill_points: int = 0

func on_enemy_defeated(enemy: Enemy) -> void:
	pass
	
func on_tier_completed() -> void:
	pass
