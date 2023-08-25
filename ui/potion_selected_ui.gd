extends NinePatchRect
class_name PotionSelectedUI

@onready var potion_quantity = %PotionQuantity
@onready var potion_texture = %PotionTexture

signal unselected_potion(potion_resource: PotionResource)

var potion_resource: PotionResource:
	set(value):
		potion_texture.self_modulate = value.color_modulate
		potion_resource = value
		
var potion_quantity_value: int = 0:
	set(value):
		potion_quantity.text = "x%s" % [value]
		potion_quantity_value = value
		
func remove_from_list() -> void:
	queue_free()

func _on_unselect_potion_pressed():
	if potion_quantity_value > 0:
		unselected_potion.emit(potion_resource)
