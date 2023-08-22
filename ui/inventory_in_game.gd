extends Control
class_name InventoryInGame

@onready var coins_label = %CoinsLabel
@onready var total_weight_label = %TotalWeightLabel

@export var inventory: Inventory
		
func _ready():
	coins_label.text = String.num(inventory.coins)
	total_weight_label.text = String.num(total_weight())

func on_collect_item(item: CollectItemResource) -> bool:
	if can_collect(item.weight):
		inventory.collect_items.append(item)
		total_weight_label.text = String.num(total_weight())
		return true
	else:
		return false
	
func on_collect_coin() -> void:
	inventory.coins += 1
	coins_label.text = String.num(inventory.coins)
	
func on_use_potion() -> void:
	inventory.potions -= 1
	total_weight_label.text = String.num(total_weight())

func can_collect(weight: int) -> bool:
	return total_weight() + weight <= inventory.size

func total_weight() -> int:
	var items_weight: int = 0
	for item in inventory.collect_items:
		items_weight += item.weight
		
	return inventory.potions + items_weight
