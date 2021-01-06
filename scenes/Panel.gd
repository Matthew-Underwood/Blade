extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	var tileId = 1
	var tiles = get_node("Tiles").get_children()
	for tile in tiles:
		tiles.setTileId(tileId)
		tileId += 1
