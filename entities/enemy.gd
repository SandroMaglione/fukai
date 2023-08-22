extends Node2D
class_name Enemy

@export var enemy_resource: EnemyResource

@onready var health: int = enemy_resource.health

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)

func get_damage(damage: int) -> void:
	health -= damage
	
	if health < 0:
		queue_free()
