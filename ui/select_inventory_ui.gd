extends Control

@onready var potions_available_list = %PotionsAvailableList
@onready var potions_selected_list = %PotionsSelectedList

const potion_selection_ui = preload("res://ui/potion_selection_ui.tscn")
const potion_selected_ui = preload("res://ui/potion_selected_ui.tscn")

var potions_inventory: Dictionary = {}
var potions_inventory_ui_list: Dictionary = {}

func _ready():
	var potion_groups = GlobalInventory.inventory.potions
	
	for potion in potion_groups:
		var ui_instance = potion_selection_ui.instantiate() as PotionSelectionUI
		potions_available_list.add_child(ui_instance)
		ui_instance.potion_selected.connect(_on_potion_selected)
		
		var potion_resource: PotionResource = GlobalInventory.potions[potion]
		ui_instance.potion_resource = potion_resource

		ui_instance.potion_quantity_value = potion_groups[potion]

func _on_potion_selected(potion_resource: PotionResource) -> void:
	if potions_inventory.has(potion_resource.name):
		potions_inventory[potion_resource.name] += 1
		potions_inventory_ui_list[potion_resource.name].potion_quantity_value += 1
	else:
		potions_inventory[potion_resource.name] = 1
		
		var ui_instance = potion_selected_ui.instantiate() as PotionSelectedUI
		potions_selected_list.add_child(ui_instance)
		
		ui_instance.unselected_potion.connect(_on_potion_unselected)
		
		ui_instance.potion_resource = potion_resource
		ui_instance.potion_quantity_value = 1
		
		potions_inventory_ui_list[potion_resource.name] = ui_instance
		
func _on_potion_unselected(potion_resource: PotionResource) -> void:
	if potions_inventory.has(potion_resource.name):
		var quantity = potions_inventory[potion_resource.name]
		
		if quantity == 1:
			potions_inventory.erase(potion_resource.name)
			potions_inventory_ui_list.erase(potion_resource.name)
			
			var ui_children = potions_selected_list.get_children()
			for child in ui_children:
				if child is PotionSelectedUI:
					if child.potion_resource.name == potion_resource.name:
						child.remove_from_list()
		else:
			potions_inventory[potion_resource.name] -= 1
			potions_inventory_ui_list[potion_resource.name].potion_quantity_value -= 1
			
		for child in potions_available_list.get_children():
			if child is PotionSelectionUI:
				if child.potion_resource.name == potion_resource.name:
					child.potion_quantity_value += 1
	
