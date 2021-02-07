extends Node

var _diamondPlacement : DiamondPlacement
var _tileFactory : TileFactory
var _map : Map
var _tileId : int
var _tileMaps : Array
var _tileMapOutLine : TileMap
var _heightNodes : Array

func buildWorld(
		map : Map,
		tileMapOutLine : TileMap,
		diamondPlacement : DiamondPlacement,
		tileFactory : TileFactory
	):
		
	_map = map
	_tileMapOutLine = tileMapOutLine
	_diamondPlacement = diamondPlacement
	_tileFactory = tileFactory
	
	_tileId = 0
	var mapData = map.getAll()
	_heightNodes = get_node("Height").get_children()
	
	for y in range(map.getSize().y):
		for x in range(map.getSize().x):
			buildTiles(mapData[y][x])
	
func _process(delta):
	if Input.is_action_pressed("test_click"):
		var tilePosition = _heightNodes[0].get_child(0).world_to_map(
			get_viewport().get_mouse_position()
		)
		if _map.hasWorldPosition(tilePosition):
			var selectedTilePositions = _diamondPlacement.calculatePositions(
					tilePosition,
					Vector2(3,3)
				)
			
			for selectedTilePosition in selectedTilePositions:
				var updateTiles = []
				if typeof(selectedTilePositions[selectedTilePosition]) != TYPE_ARRAY:
					updateTiles = [selectedTilePositions[selectedTilePosition]]
				else:
					updateTiles = selectedTilePositions[selectedTilePosition]
				
				for updateTile in updateTiles:
					var tile = determine_tile(updateTile, selectedTilePosition)
					if _map.hasWorldPosition(updateTile):
						var height = _map.getDataFromPos(updateTile)
						var heightLayer = height.getHeight(0)
						heightLayer.updateTerrianTiles(tile)
						removeAllTiles(updateTile)
						buildTiles(height)


func determine_tile(position: Vector2, type : int):
	var tile
	match type:
		DiamondPlacement.TOP:
			tile = _tileFactory.create(DiamondPlacement.TOP, _tileId, position, Vector2.ZERO)
		DiamondPlacement.LEFT:
			tile = _tileFactory.create(DiamondPlacement.LEFT, _tileId, position, Vector2(1,0))
		DiamondPlacement.RIGHT:
			tile = _tileFactory.create(DiamondPlacement.RIGHT, _tileId, position, Vector2.ZERO)
		DiamondPlacement.BOTTOM:
			tile = _tileFactory.create(DiamondPlacement.BOTTOM, _tileId, position, Vector2(0,1))
		DiamondPlacement.TOP_LEFT:
			tile = _tileFactory.create(DiamondPlacement.TOP_LEFT, _tileId, position,Vector2.ZERO)
		DiamondPlacement.TOP_RIGHT:
			tile = _tileFactory.create(DiamondPlacement.TOP_RIGHT, _tileId, position, Vector2(1,0))
		DiamondPlacement.BOTTOM_LEFT:
			tile = _tileFactory.create(DiamondPlacement.BOTTOM_LEFT, _tileId, position, Vector2(0,1))
		DiamondPlacement.BOTTOM_RIGHT:
			tile = _tileFactory.create(DiamondPlacement.BOTTOM_RIGHT, _tileId, position, Vector2(1,1))
		_:
			var flip = Vector2(randi() % 2, randi() % 2)
			tile = _tileFactory.create(
				DiamondPlacement.SURROUNDED,
				_tileId,
				position,
				flip
			)
	return tile
	

func setTileId(id : int):
	_tileId = id

	
func removeAllTiles(worldPosition : Vector2):
	for heightNode in _heightNodes:
		var layerNodes = heightNode.get_children()
		for layerNode in layerNodes:
			layerNode.set_cell(worldPosition.x, worldPosition.y, -1)


func buildTiles(tileHeights : Height):
	
	for tileHeight in range(tileHeights.getMaxHeight()):
		var tileMapLayer = _heightNodes[tileHeight].get_children()
		if tileHeights.hasHeight(tileHeight):
			var tileLayer = tileHeights.getHeight(tileHeight)
			var tiles = tileLayer.getTerrianTiles()
			for tileIndex in range(tileLayer.getTerrianTilesCount()):
				var tile = tiles[tileIndex]
				var flip = tile.getFlip()
				var tileMap = tileMapLayer[tileIndex]
				tileMap.set_cell(
					tile.getWorldPosition().x,
					tile.getWorldPosition().y,
					tile.getTileId(),
					flip.x,
					flip.y,
					false,
					tile.getAtlasTile()
				)
						
				_tileMapOutLine.set_cell(
					tileLayer.getWorldPosition().x,
					tileLayer.getWorldPosition().y,
					0,
					false,
					false,
					false,
					tileLayer.getOverlayTile().getAtlasTile()
				)
