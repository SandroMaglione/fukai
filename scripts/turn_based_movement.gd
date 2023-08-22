extends Node

enum Turn { PLAYER, ENEMY, NONE }

var current_turn: Turn = Turn.NONE:
	set(value):
		print(value)
		current_turn = value

var next_turn_counter_total: int

func _ready():
	var actors = get_actors()
	for actor in actors:
		if actor is Player:
			next_turn_counter_total += actor.player_resource.speed
		elif actor is Enemy:
			next_turn_counter_total += actor.enemy_resource.speed
	
	choose_next_turn()
	

func turn_completed(my_turn: Turn) -> void:
	var enemies = get_enemies()
	if enemies.size() == 0:
		current_turn = Turn.PLAYER
	elif my_turn == current_turn:
		choose_next_turn()
			
func choose_next_turn() -> void:
	current_turn = Turn.NONE
	
	var actors = get_actors()
	for actor in actors:
		if actor is Player:
			actor.next_turn_counter += actor.player_resource.speed
		elif actor is Enemy:
			actor.next_turn_counter += actor.enemy_resource.speed
	
	var player = get_player()
	if player.next_turn_counter > next_turn_counter_total:
		current_turn = Turn.PLAYER
	else:
		var enemies_to_move = get_enemies()
		var enemies_next_turn = enemies_to_move.filter(func (enemy): return enemy.next_turn_counter > next_turn_counter_total)
		if enemies_next_turn.size() == 0:
			choose_next_turn()
		else:
			current_turn = Turn.ENEMY
	
func is_player_turn() -> bool:
	return current_turn == Turn.PLAYER

func is_enemy_turn() -> bool:
	return current_turn == Turn.ENEMY
	
func get_player() -> Player:
	return get_tree().get_nodes_in_group("player")[0] as Player
	
func get_enemies() -> Array[Enemy]:
	var nodes = get_tree().get_nodes_in_group("enemy")
	var enemies: Array[Enemy] = []
	for node in nodes:
		if node is Enemy:
			enemies.append(node)
	
	return enemies
	
func get_actors() -> Array[Node]:
	var actors = get_tree().get_nodes_in_group("enemy")
	actors.append(get_player())
	return actors
