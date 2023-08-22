extends Resource
class_name Inventory

@export var size: int = 10

@export var collect_items: Array[CollectItemResource] = []
@export var potions: int = 3

# coins have no "weight"
@export var coins: int = 0
