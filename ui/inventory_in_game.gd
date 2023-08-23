extends Control
class_name InventoryInGame

@onready var total_weight_label = %TotalWeightLabel

@export var inventory: Inventory
		
func _ready():
	total_weight_label.text = String.num(total_weight())

func on_collect_crystal(crystal: CrystalResource) -> void:
	if inventory.crystals.has(crystal.name):
		inventory.crystals[crystal.name] += 1
	else:
		inventory.crystals[crystal.name] = 1
		
	total_weight_label.text = String.num(total_weight())
	
func on_use_potion() -> void:
	total_weight_label.text = String.num(total_weight())

func total_weight() -> int:
	return 0
