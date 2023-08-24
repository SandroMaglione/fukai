extends Resource
class_name PotionResource

@export var name: String # unique
@export_color_no_alpha var color_modulate: Color
@export_range(1, 10) var weight: int
@export_multiline var description: String 

@export var craft_requirements: Dictionary = {}
