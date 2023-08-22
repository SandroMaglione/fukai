extends Node2D
class_name Enemy

@export var enemy_resource: EnemyResource
@onready var health_bar: HealthBar = $HealthBar

var next_turn_counter: int = 0

@onready var health:
	set(value):
		health_bar.update_health(value)
		health = value

func _ready():
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position -= Vector2.ONE * (Constants.TILE_SIZE / 2)
	
	health = enemy_resource.health
	health_bar.init_health(health)
	
func can_move() -> bool:
	return TurnBasedMovement.is_enemy_turn() and next_turn_counter > TurnBasedMovement.next_turn_counter_total

func get_damage(damage: int) -> void:
	health -= damage
	
	if health <= 0:
		queue_free()
