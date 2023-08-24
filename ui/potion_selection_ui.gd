extends Panel
class_name PotionSelectionUI

@onready var potion_quantity = %PotionQuantity
@onready var potion_texture = %PotionTexture
@onready var potion_description_label = %PotionDescriptionLabel

signal potion_selected(potion_resource: PotionResource)

var potion_resource: PotionResource:
	set(value):
		potion_texture.self_modulate = value.color_modulate
		potion_description_label.text = value.description
		potion_resource = value
		
var potion_quantity_value: int = 0:
	set(value):
		potion_quantity.text = "x%s" % [value]
		potion_quantity_value = value

func _on_potion_selection_button_pressed():
	if potion_quantity_value > 0:
		potion_quantity_value -= 1
		potion_selected.emit(potion_resource)
