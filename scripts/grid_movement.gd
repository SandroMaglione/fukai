extends RayCast2D

@export var actor: Node2D
@export var speed: float = 0.25

signal collided(body)

var moving_direction: Vector2 = Vector2.ZERO
var collided_direction: Vector2 = Vector2.ZERO

func _ready():
	# Set movement direction as DOWN by default
	self.target_position = Vector2.DOWN * Constants.TILE_SIZE
 
func move(direction: Vector2) -> void:
	if moving_direction.length() == 0 and direction.length() > 0:
		var movement = Vector2.DOWN
		if direction.y > 0: movement = Vector2.DOWN
		elif direction.y < 0: movement = Vector2.UP
		elif direction.x > 0: movement = Vector2.RIGHT
		elif direction.x < 0: movement = Vector2.LEFT
		
		self.target_position = movement * Constants.TILE_SIZE
		self.force_raycast_update() # Update the `target_position` immediately
		
		# Allow movement only if no collision in next tile
		if !self.is_colliding():
			collided_direction = Vector2.ZERO
			moving_direction = movement
			
			var new_position = actor.global_position + (moving_direction * Constants.TILE_SIZE)
			
			var tween = create_tween()
			tween.tween_property(actor, "position", new_position, speed).set_trans(Tween.TRANS_LINEAR)
			tween.tween_callback(func(): moving_direction = Vector2.ZERO)
		else:
			if collided_direction != direction:
				# Collide and emit signal only once
				collided_direction = direction
				collided.emit(self.get_collider())
