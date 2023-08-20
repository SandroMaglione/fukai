extends Area2D
class_name Stairs

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)

func complete_tier() -> void:
	print("Done")