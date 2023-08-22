extends Control
class_name InventoryInGame

@onready var coins_label = %CoinsLabel

var inventory: Inventory
		
func _ready():
	# TODO: Load inventory from assigned player selection
	inventory = preload("res://scripts/instances/intial_inventory.tres")

func on_collect_item(item: CollectItemResource) -> void:
	inventory.collect_items.append(item)
	
func on_collect_coin() -> void:
	inventory.coins += 1
	coins_label.text = String.num(inventory.coins)
