extends Control
class_name InventoryInGame

@onready var total_weight_label = %TotalWeightLabel

@export var inventory: Inventory
		
func _ready():
	total_weight_label.text = String.num(total_weight())

func on_collect_crystal(crystal: CrystalResource) -> void:
	inventory.crystals.append(crystal)
	total_weight_label.text = String.num(total_weight())
	
func on_use_potion() -> void:
	inventory.potions -= 1
	total_weight_label.text = String.num(total_weight())

func total_weight() -> int:
	var items_weight: int = 0
	for item in inventory.crystals:
		items_weight += item.weight
		
	return inventory.potions + items_weight
