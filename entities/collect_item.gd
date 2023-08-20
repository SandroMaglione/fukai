extends Area2D
class_name CollectItem

@export var collect_item_resource: CollectItemResource

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)
	$Sprite2D.frame = collect_item_resource.texture_index

func on_collect_item() -> void:
	# TODO: Tell the (global) inventory to collect
	print("Collected", collect_item_resource.name)
	queue_free()
