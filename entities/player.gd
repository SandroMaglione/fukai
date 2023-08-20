extends Node2D
class_name Player
 
func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)
#	play("idle_down")
 
func _process(_delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	$GridMovement.move(input_direction)
	
#	moving_animation(input_direction)
			
#func moving_animation(input_direction: Vector2) -> void:
#	var animation_state: StringName = animation
#	var moving_direction: Vector2 = $GridMovement.moving_direction
#	var vectorDirection = vector2Direction(moving_direction)
#
#	if moving_direction.length() > 0:
#		animation_state = "walk_" + vectorDirection
#	else:
#		if input_direction.length() > 0:
#			vectorDirection = vector2Direction(input_direction)
#			animation_state = "idle_" + vectorDirection
#		else:
#			vectorDirection = animation_state.get_slice("_", 1)
#			animation_state = "idle_" + vectorDirection
			
#	play(animation_state)
 
#func vector2Direction(vec: Vector2) -> String:
#	var direction = "down"
#	if vec.y > 0: direction = "down"
#	elif vec.y < 0: direction = "up"
#	elif vec.x > 0:
#		flip_h = false
#		direction = "right"
#	elif vec.x < 0:
#		# Horizontal flip since we have one animation for both left and right walking and idle
#		flip_h = true
#		direction = "right"
#
#	return direction
