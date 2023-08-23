extends Node

var inventory: Inventory

const initial_inventory = preload("res://scripts/instances/initial_inventory.tres")

func _ready():
	inventory = initial_inventory

func get_crystal_groups() -> Dictionary:
	var crystal_groups: Dictionary = {}
	for crystal in inventory.crystals:
		var key = crystal.name
		if crystal_groups.has(key):
			crystal_groups[crystal.name] += 1
		else:
			crystal_groups[crystal.name] = 1
			
	return crystal_groups
	
func get_potion_groups() -> Dictionary:
	var potion_groups: Dictionary = {}
	for potion in inventory.potions:
		var key = potion.name
		if potion_groups.has(key):
			potion_groups[potion.name] += 1
		else:
			potion_groups[potion.name] = 1
			
	return potion_groups
