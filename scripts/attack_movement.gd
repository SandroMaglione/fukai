extends Node
class_name AttackMovement

signal attack_completed()

@export var actor: Node2D
@export var speed: float = 0.2

var is_attacking: bool = false

func execute_attack(direction: Vector2, against: Node2D, damage: int) -> void:
	is_attacking = true
	
	var initial_position = actor.global_position
	
	var tween = create_tween()
	tween.tween_property(actor, "position", initial_position + (direction * Constants.TILE_SIZE / 2), speed).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(actor, "position", initial_position, speed).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(
		func():
			if against is Player or against is Enemy:
				against.get_damage(damage)
			
			_attack_completed()
	)

func _attack_completed() -> void:
	is_attacking = false
	attack_completed.emit()
