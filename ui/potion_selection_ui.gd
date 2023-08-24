extends Panel
class_name PotionSelectionUI

@onready var potion_quantity = %PotionQuantity

signal potion_selected(potion_resource: PotionResource)

var potion_resource: PotionResource
var potion_quantity_value: int = 0:
	set(value):
		potion_quantity.text = "x%s" % [value]
		potion_quantity_value = value

func _on_potion_selection_button_pressed():
	if potion_quantity_value > 0:
		potion_quantity_value -= 1
		potion_selected.emit(potion_resource)
