class_name SlopeTileAction

var _layersFactory

func _init(layersFactory : LayersFactory):
	_layersFactory = layersFactory
	

func process(data : Height, tile : Tile, originData : Height) -> void:
	
	var height = data.getCurrentHeight()
	if height == originData.getCurrentHeight():
		var tiles = data.getHeight(height).getTerrianTiles()
		data.increaseHeight(_layersFactory.createFromTiles(tiles))
