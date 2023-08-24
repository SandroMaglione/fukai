extends TextureButton
class_name UsePotionUI

@onready var potion_amount_label = %PotionAmountLabel

var potion_resource: PotionResource
var potion_amount: int:
	set(value):
		potion_amount_label.text = "x%d" % [value]
		potion_amount = value
