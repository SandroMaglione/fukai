extends TileMap

var aStar: AStar2D

func _ready():
	var size = self.get_used_rect().size
	
	aStar = AStar2D.new()
	aStar.reserve_space(size.x * size.y)
