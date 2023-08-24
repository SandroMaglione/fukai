extends Control
class_name CrystalUI

@onready var crystal_quantity = %CrystalQuantity
@onready var crystal_texture = %CrystalTexture

var crystal_resource: CrystalResource:
	set(value):
		crystal_texture.self_modulate = value.color_modulate
		crystal_resource = value

var crystal_quantity_value: int = 0:
	set(value):
		crystal_quantity.text = "x%s" % [value]
		crystal_quantity_value = value

