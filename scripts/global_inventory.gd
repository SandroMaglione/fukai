extends Node

var inventory: Inventory

const initial_inventory = preload("res://scripts/instances/initial_inventory.tres")

signal updated_inventory()

func _ready():
	inventory = initial_inventory
	
func craft_potion(potion_resource: PotionResource) -> void:
	var requirements = potion_resource.craft_requirements
	
	print("Crafting", requirements)
	for requirement in requirements:
		inventory.crystals[requirement] -= requirements[requirement]
	
	if inventory.potions.has(potion_resource.name):
		inventory.potions[potion_resource.name] += 1
	else:
		inventory.potions[potion_resource.name] = 1
		
	updated_inventory.emit()
	print(inventory.crystals, inventory.potions)
