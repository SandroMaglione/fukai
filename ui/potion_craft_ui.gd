extends NinePatchRect
class_name PotionCraftUI

@onready var crystal_requirements_list = %CrystalRequirementsList
@onready var potion_texture = %PotionTexture
@onready var potion_quantity_label = %PotionQuantityLabel

const crystal_ui = preload("res://ui/crystal_ui.tscn")

var potion_resource: PotionResource:
	set(value):
		potion_texture.self_modulate = value.color_modulate
		assign_requirements(value.craft_requirements)
		potion_resource = value

var potion_quantity_value: int = 0:
	set(value):
		potion_quantity_label.text = "x%d" % [value]
		potion_quantity_value = value


func assign_requirements(requirements: Dictionary) -> void:
	for requirement in requirements:
		var ui_instance = crystal_ui.instantiate() as CrystalUI
		ui_instance.custom_minimum_size = Vector2.ONE * 10
		crystal_requirements_list.add_child(ui_instance)
		
		ui_instance.crystal_resource = GlobalInventory.crystals[requirement]
		ui_instance.crystal_quantity_value = requirements[requirement]
		
func _on_potion_select_button_pressed():
	var can_craft_potion: bool = true
	
	var requirements = potion_resource.craft_requirements
	var crystal_groups = GlobalInventory.inventory.crystals
	
	for requirement in requirements:
		if not crystal_groups.has(requirement) or crystal_groups[requirement] < requirements[requirement]:
			can_craft_potion = false
			
	if can_craft_potion:
		GlobalInventory.craft_potion(potion_resource)
		_on_updated_inventory()
			
func _on_updated_inventory() -> void:
	var potion_groups = GlobalInventory.inventory.potions
	if potion_groups.has(potion_resource.name):
		potion_quantity_value = potion_groups[potion_resource.name]
	else:
		potion_quantity_value = 0
