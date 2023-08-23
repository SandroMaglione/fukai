extends Resource
class_name PotionResource

@export var name: String # unique
@export_range(0, 2) var texture_index: int
@export_range(1, 10) var weight: int
