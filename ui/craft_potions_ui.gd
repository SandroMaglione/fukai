extends Control

@onready var potions_grid = %PotionsGrid
@onready var crystal_list = %CrystalList

const crystal_ui = preload("res://ui/crystal_ui.tscn")
const potion_craft_ui = preload("res://ui/potion_craft_ui.tscn")

const potions: Dictionary = {
	"health": preload("res://entities/instances/health_potion.tres"),
	"speed": preload("res://entities/instances/speed_potion.tres")
}

const crystals: Dictionary = {
	"red": preload("res://entities/instances/red_crystal.tres"),
	"yellow": preload("res://entities/instances/yellow_crystal.tres"),
	"brown": preload("res://entities/instances/brown_crystal.tres")
}	

var inventory_crystals: Array[CrystalUI]

func _ready():
	_init_crystals()
	_init_potions()
	
	GlobalInventory.updated_inventory.connect(_on_update_inventory)
		
func _init_potions() -> void:
	var potion_groups = GlobalInventory.inventory.potions
	
	for potion in potions:
		var ui_instance = potion_craft_ui.instantiate() as PotionCraftUI
		potions_grid.add_child(ui_instance)
		
		var potion_resource: PotionResource = potions[potion]
		ui_instance.potion_resource = potion_resource

		if potion_groups.has(potion):
			ui_instance.potion_quantity_value = potion_groups[potion]
		else:
			ui_instance.potion_quantity_value = 0
		
func _init_crystals() -> void:
	var crystal_groups = GlobalInventory.inventory.crystals
	
	for crystal in crystals:
		var ui_instance = crystal_ui.instantiate() as CrystalUI
		crystal_list.add_child(ui_instance)
		inventory_crystals.append(ui_instance)
		
		var crystal_resource: CrystalResource = crystals[crystal]
		ui_instance.crystal_resource = crystal_resource
		
		if crystal_groups.has(crystal):
			ui_instance.crystal_quantity_value = crystal_groups[crystal]
		else:
			ui_instance.crystal_quantity_value = 0
	
func _on_update_inventory() -> void:
	var crystal_groups = GlobalInventory.inventory.crystals
	
	for ui_crystal in inventory_crystals:
		if crystal_groups.has(ui_crystal.crystal_resource.name):
			ui_crystal.crystal_quantity_value = crystal_groups[ui_crystal.crystal_resource.name]