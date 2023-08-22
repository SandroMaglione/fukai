extends Control
class_name HealthBar

@onready var progress_bar: ProgressBar = %ProgressBar

func init_health(health: int) -> void:
	progress_bar.max_value = health

func update_health(health: int) -> void:
	progress_bar.value = health
