extends Button
class_name UsePotionUI

@onready var potion_amount_label = %PotionAmountLabel
@onready var potion_texture = %PotionTexture

var potion_resource: PotionResource:
	set(value):
		potion_texture.self_modulate = value.color_modulate
		potion_resource = value
		
var potion_amount: int:
	set(value):
		potion_amount_label.text = "x%d" % [value]
		potion_amount = value
