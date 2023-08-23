extends Panel
class_name CrystalUI

@onready var crystal_quantity = %CrystalQuantity

var crystal_resource: CrystalResource

var crystal_quantity_value: int = 0:
	set(value):
		crystal_quantity.text = "x%s" % [value]
		crystal_quantity_value = value

