extends Node2D
class_name TurnActor

var next_turn_counter: int = 0
var can_move: bool = false

signal turn_completed(actor: TurnActor)

