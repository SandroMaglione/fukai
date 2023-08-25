extends Control

@onready var potions_available_list = %PotionsAvailableList
@onready var potions_selected_list = %PotionsSelectedList
@onready var space_available_label = %SpaceAvailableLabel

const potion_selection_ui = preload("res://ui/potion_selection_ui.tscn")
const potion_selected_ui = preload("res://ui/potion_selected_ui.tscn")

var potions_inventory: Dictionary = {}
var potions_inventory_ui_list: Dictionary = {}

func _ready():
	var potion_groups = GlobalInventory.inventory.potions
	
	if GlobalInventory.in_game_potions.size() > 0:
		for potion in GlobalInventory.in_game_potions:
			var potion_resource: PotionResource = GlobalInventory.potions[potion]
			var quantity = GlobalInventory.in_game_potions[potion]
			
			potions_inventory[potion_resource.name] = quantity
			
			var ui_instance = potion_selected_ui.instantiate() as PotionSelectedUI
			potions_selected_list.add_child(ui_instance)
			
			ui_instance.unselected_potion.connect(_on_potion_unselected)
			
			ui_instance.potion_resource = potion_resource
			ui_instance.potion_quantity_value = quantity
			
			potions_inventory_ui_list[potion_resource.name] = ui_instance
		
		for potion in potion_groups:
			var ui_instance = potion_selection_ui.instantiate() as PotionSelectionUI
			potions_available_list.add_child(ui_instance)
			ui_instance.potion_selected.connect(_on_potion_selected)
			
			var potion_resource: PotionResource = GlobalInventory.potions[potion]
			ui_instance.potion_resource = potion_resource

			var quantity_selected = 0 if not GlobalInventory.in_game_potions.has(potion_resource.name) else GlobalInventory.in_game_potions[potion_resource.name]
			ui_instance.potion_quantity_value = potion_groups[potion] - quantity_selected
	else:
		for potion in potion_groups:
			var ui_instance = potion_selection_ui.instantiate() as PotionSelectionUI
			potions_available_list.add_child(ui_instance)
			ui_instance.potion_selected.connect(_on_potion_selected)
			
			var potion_resource: PotionResource = GlobalInventory.potions[potion]
			ui_instance.potion_resource = potion_resource

			ui_instance.potion_quantity_value = potion_groups[potion]
		
	_update_space_available()

func _on_potion_selected(potion_resource: PotionResource) -> void:
	if _total_space_occupied() + 1 <= GlobalInventory.inventory.size:
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
		
		_update_space_available()
	
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
					
		_update_space_available()
		
func _total_space_occupied() -> int:
	var space: int = 0
	for potion in potions_inventory:
		var potion_resource: PotionResource = GlobalInventory.potions[potion]
		space += potions_inventory[potion]
	return space
	
func _update_space_available() -> void:
	space_available_label.text = "Selected %d out of %d potions" % [_total_space_occupied(), GlobalInventory.inventory.size]

func _on_enter_dungeon_button_pressed():
	GlobalInventory.in_game_potions = potions_inventory
	get_tree().change_scene_to_file("res://scenes/dungeon.tscn")

func _on_craft_potions_button_pressed():
	get_tree().change_scene_to_file("res://ui/craft_potions_ui.tscn")

func _on_player_stats_button_pressed():
	get_tree().change_scene_to_file("res://ui/player_stats_ui.tscn")
