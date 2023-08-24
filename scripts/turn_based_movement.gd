extends Node
class_name TurnBasedMovement

var next_turn_counter_total: int
var enemies_in_movement: int = 0

func _ready():
	var actors = get_actors()
	for actor in actors:
		if actor is Player:
			next_turn_counter_total += PlayerExperience.player_stats.speed
		elif actor is Enemy:
			next_turn_counter_total += actor.enemy_resource.speed
			
		actor.turn_completed.connect(_on_turn_completed)
		
		if actor is Player:
			actor.can_move = true
			
func choose_next_turn() -> void:
	var actors = get_actors()
	for actor in actors:
		if actor is Player:
			actor.next_turn_counter += PlayerExperience.player_stats_power_up().speed
		elif actor is Enemy:
			actor.next_turn_counter += actor.enemy_resource.speed
	
	var player = get_player()
	var enemies = get_enemies()
	var all_defeated = enemies.all(func(enemy): return enemy.health <= 0)
	if enemies.size() == 0 or all_defeated or player.next_turn_counter > next_turn_counter_total:
		player.can_move = true
	else:
		var enemies_to_move = get_enemies()
		var enemies_next_turn = enemies_to_move.filter(func (enemy): return enemy.next_turn_counter > next_turn_counter_total)
		
		if enemies_next_turn.size() == 0:
			choose_next_turn()
		else:
			enemies_in_movement = enemies_next_turn.size()
			for enemy in enemies_next_turn:
				enemy.can_move = true
			
func _on_turn_completed(actor: TurnActor) -> void:
	actor.next_turn_counter = 0
	actor.can_move = false
	
	if actor is Enemy:
		enemies_in_movement -= 1
		
		if enemies_in_movement == 0:
			choose_next_turn()
			
	elif actor is Player:
		PlayerExperience.on_player_turn_completed()
		choose_next_turn()
			
func get_player() -> Player:
	return get_tree().get_nodes_in_group("player")[0] as Player
	
func get_enemies() -> Array[Enemy]:
	var actors = get_actors()
	var enemies: Array[Enemy] = []
	for actor in actors:
		if actor is Enemy:
			enemies.append(actor)
	return enemies
	
func get_actors() -> Array[TurnActor]:
	var actors = get_tree().get_nodes_in_group("turn_moving")
	var turn_actors: Array[TurnActor] = []
	for actor in actors:
		if actor is TurnActor:
			turn_actors.append(actor)
	return turn_actors
