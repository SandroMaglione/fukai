extends Control

@onready var potions_grid = %PotionsGrid
@onready var crystal_list = %CrystalList

const crystal_ui = preload("res://ui/crystal_ui.tscn")
const potion_craft_ui = preload("res://ui/potion_craft_ui.tscn")

func _ready():
	_init_crystals()
	_init_potions()
		
func _init_potions() -> void:
	var potion_groups = GlobalInventory.get_potion_groups()
	for potion in potion_groups:
		var ui_instance = potion_craft_ui.instantiate() as PotionCraftUI
		potions_grid.add_child(ui_instance)
		
		ui_instance.potion_quantity_value = potion_groups[potion]
		
func _init_crystals() -> void:
	var crystal_groups = GlobalInventory.get_crystal_groups()
	for crystal in crystal_groups:
		var ui_instance = crystal_ui.instantiate() as CrystalUI
		crystal_list.add_child(ui_instance)
		
		ui_instance.crystal_quantity_value = crystal_groups[crystal]
	
