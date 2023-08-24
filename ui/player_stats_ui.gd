extends Control
class_name PLayerStatsUI

@onready var health_stat: SinglePlayerStatUI = %HealthStat
@onready var speed_stat: SinglePlayerStatUI = %SpeedStat
@onready var attack_stat: SinglePlayerStatUI = %AttackStat
@onready var defense_stat: SinglePlayerStatUI = %DefenseStat

@onready var points_to_assign_label = %PointsToAssignLabel

func _ready():
	_update_points_assigned()

func _update_points_assigned() -> void:
	health_stat.points_assigned = PlayerExperience.player_stats.health
	speed_stat.points_assigned = PlayerExperience.player_stats.speed
	attack_stat.points_assigned = PlayerExperience.player_stats.attack
	defense_stat.points_assigned = PlayerExperience.player_stats.defense
	
	points_to_assign_label.text = "Points to assign: %d" % [PlayerExperience.available_skill_points]

func _on_health_stat_selected_assign_stat():
	if PlayerExperience.available_skill_points > 0:
		PlayerExperience.player_stats.health += 1
		PlayerExperience.available_skill_points -= 1
		_update_points_assigned()

func _on_speed_stat_selected_assign_stat():
	if PlayerExperience.available_skill_points > 0:
		PlayerExperience.player_stats.speed += 1
		PlayerExperience.available_skill_points -= 1
		_update_points_assigned()

func _on_attack_stat_selected_assign_stat():
	if PlayerExperience.available_skill_points > 0:
		PlayerExperience.player_stats.attack += 1
		PlayerExperience.available_skill_points -= 1
		_update_points_assigned()

func _on_defense_stat_selected_assign_stat():
	if PlayerExperience.available_skill_points > 0:
		PlayerExperience.player_stats.defense += 1
		PlayerExperience.available_skill_points -= 1
		_update_points_assigned()


func _on_come_back_button_pressed():
	get_tree().change_scene_to_file("res://ui/select_inventory_ui.tscn")
