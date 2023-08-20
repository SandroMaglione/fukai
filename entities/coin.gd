extends Area2D
class_name Coin

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)

func collect_coin() -> void:
	print("Got it")
	queue_free()
