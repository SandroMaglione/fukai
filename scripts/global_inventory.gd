extends Node

var inventory: Inventory

const initial_inventory = preload("res://scripts/instances/initial_inventory.tres")

var potions: Dictionary = {
	"health": load("res://entities/instances/health_potion.tres"),
	"speed": load("res://entities/instances/speed_potion.tres"),
	"attack": load("res://entities/instances/attack_potion.tres"),
	"defense": load("res://entities/instances/defense_potion.tres")
}

var crystals: Dictionary = {
	"red": load("res://entities/instances/red_crystal.tres"),
	"yellow": load("res://entities/instances/yellow_crystal.tres"),
	"brown": load("res://entities/instances/brown_crystal.tres")
}	

signal updated_inventory()

var in_game_potions: Dictionary = {}
var potions_used: Dictionary = {}

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
	
func collect_crystal(crystal_resource: CrystalResource) -> void:
	if inventory.crystals.has(crystal_resource.name):
		inventory.crystals[crystal_resource.name] += 1
	else:
		inventory.crystals[crystal_resource.name] = 1

func on_use_potion(potion: PotionResource) -> void:
	if inventory.potions.has(potion.name):
		if inventory.potions[potion.name] == 1:
			inventory.potions.erase(potion.name)
		else:
			inventory.potions[potion.name] -= 1
	
	if in_game_potions.has(potion.name):
		if in_game_potions[potion.name] == 1:
			in_game_potions.erase(potion.name)
		else:
			in_game_potions[potion.name] -= 1

func get_crystal(name: String) -> CrystalResource:
	return crystals[name]
