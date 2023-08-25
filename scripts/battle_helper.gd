extends Node

func player_attack(enemy_resource: EnemyResource) -> int:
	var damage = PlayerExperience.player_stats_power_up().attack - enemy_resource.defense
	return max(1, damage)
	
func enemy_attack(enemy_resource: EnemyResource) -> int:
	var damage = enemy_resource.attack - PlayerExperience.player_stats_power_up().defense
	return max(1, damage) 
