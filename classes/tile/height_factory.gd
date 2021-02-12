class_name HeightFactory

var _maxHeight : int
var _layerFactory : LayersFactory

func _init(maxHeight : int, layerFactory : LayersFactory):
	_maxHeight = maxHeight
	_layerFactory = layerFactory
	
func create(tile : Tile, position : Vector2) -> Height:
	var height = load("res://classes/tile/height.gd")
	var heights = []
	heights.append(_layerFactory.create(tile))
	return height.new(heights, _maxHeight, position)
