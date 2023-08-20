extends Area2D
class_name CollectItem

@export var collect_item_resource: CollectItemResource

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)

func on_collect_item() -> void:
	print("Collected", collect_item_resource.name)
