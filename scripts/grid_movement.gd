extends Node

@export var actor: Node2D
@export var speed: float = 0.25

var moving_direction: Vector2 = Vector2.ZERO
 
func move(direction: Vector2) -> void:
	if moving_direction.length() == 0 && direction.length() > 0:
		var movement = Vector2.DOWN
		if direction.y > 0: movement = Vector2.DOWN
		elif direction.y < 0: movement = Vector2.UP
		elif direction.x > 0: movement = Vector2.RIGHT
		elif direction.x < 0: movement = Vector2.LEFT
		
		moving_direction = movement
		
		var new_position = actor.global_position + (moving_direction * Constants.TILE_SIZE)
		
		var tween = create_tween()
		tween.tween_property(actor, "position", new_position, speed).set_trans(Tween.TRANS_LINEAR)
		tween.tween_callback(func(): moving_direction = Vector2.ZERO)
