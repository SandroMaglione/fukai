extends CanvasLayer

const use_potion_ui = preload("res://ui/use_potion_ui.tscn")
@onready var use_potions_list = %UsePotionsList

func _ready():
	for potion in GlobalInventory.in_game_potions:
		var potion_resource: PotionResource = GlobalInventory.potions[potion]
		
		var ui_instance = use_potion_ui.instantiate() as UsePotionUI
		use_potions_list.add_child(ui_instance)
		
		ui_instance.pressed.connect(
			func():
				if ui_instance.potion_amount > 0 and PlayerExperience.current_power_up == null:
					ui_instance.potion_amount -= 1
						
					PlayerExperience.on_potion_used(potion_resource)
		)
		
		ui_instance.potion_resource = potion_resource
		ui_instance.potion_amount = GlobalInventory.in_game_potions[potion]

