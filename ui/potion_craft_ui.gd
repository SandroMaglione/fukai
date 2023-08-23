extends Panel
class_name PotionCraftUI

@onready var potion_quantity = %PotionQuantity

var potion_name: String = ""

var potion_quantity_value: int = 0:
	set(value):
		potion_quantity.text = "x%s" % [value]
		potion_quantity_value = value

