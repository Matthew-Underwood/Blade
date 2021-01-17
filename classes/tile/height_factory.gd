class_name HeightFactory

var _maxHeight : int
var _layerFactory : LayersFactory

func _init(maxHeight : int, layerFactory : LayersFactory):
	_maxHeight = maxHeight
	_layerFactory = layerFactory
	
func create(mapPosition : Vector2) -> Height:
	var height = load("res://classes/tile/height.gd")
	var heights = []
	var initialCreated = false
	#TODO possible bug setting all heights to default tile
	for currentHeight in range(_maxHeight):
		if !initialCreated:
			heights.append(_layerFactory.create(mapPosition, Vector2.ZERO))
			initialCreated = true
			continue
		heights.append(null)
			
	return height.new(heights)
