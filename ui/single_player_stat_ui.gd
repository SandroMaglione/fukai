extends Panel
class_name SinglePlayerStatUI

signal selected_assign_stat()

@onready var points_assigned_label = %PointsAssignedLabel

var points_assigned: int = 0:
	set(value):
		points_assigned_label.text = "%s" % [value]
		points_assigned = value

func _on_assign_stat_point_button_pressed():
	selected_assign_stat.emit()
