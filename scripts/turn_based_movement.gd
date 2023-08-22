extends Node

enum Turn { PLAYER, ENEMY }

var current_turn: Turn = Turn.PLAYER

func turn_completed(my_turn: Turn) -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.size() == 0:
		current_turn = Turn.PLAYER
	else:
		if my_turn == current_turn:
			var next_turn = Turn.PLAYER if current_turn == Turn.ENEMY else Turn.ENEMY
			current_turn = next_turn

func is_player_turn() -> bool:
	return current_turn == Turn.PLAYER

func is_enemy_turn() -> bool:
	return current_turn == Turn.ENEMY
