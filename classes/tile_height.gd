class_name TileHeight

var _map : Map
var _placement : DiamondPlacement
var _layerFactory : LayersFactory

func _init(
	map : Map,
	placement : DiamondPlacement,
	layerFactory : LayersFactory
):
	_map = map
	_placement = placement
	_layerFactory = layerFactory
	
func create(selectedTilePosition : Vector2, tileArea : Vector2):
	var selectedTile = _map.getDataFromPos(selectedTilePosition)
	var currentHeight = selectedTile.getCurrentHeight()
	
	var selectedTilePositions = _placement.calculatePositions(
		selectedTile,
		 tileArea
		)
		
	for selectedTilePosition in selectedTilePositions:
		if typeof(selectedTilePositions[selectedTilePosition]) != TYPE_ARRAY:
			var updateTiles = [selectedTilePositions[selectedTilePosition]]
		else:
			var updateTiles = selectedTilePositions[selectedTilePosition]
			
		for updateTile in updateTiles:
			var tileToCopy = _map.getDataFromPos(updateTile)
			var tileToCopyHeight = tileToCopy.getCurrentHeight()
			if tileToCopyHeight < currentHeight:
				var createFromTiles = heightData.GetHeight(tileToCopyHeight).getTerrianTiles()
				heightData.setHeight(
					tileToCopyHeight,
					_layerFactory.createFromTiles(createFromTiles)
				)
