extends Node

var _map : Map
var _tileId : int
var _tileMaps : Array
var _tileMapOutLine : TileMap
var _heightNodes : Array
var _flatTilePlacementResolver : TilePlacementResolver
var _slopeTilePlacementResolver : TilePlacementResolver

func buildWorld(
		map : Map,
		tileMapOutLine : TileMap,
		flatTilePlacementResolver : TilePlacementResolver,
		slopeTilePlacementResolver : TilePlacementResolver
	):
		
	_map = map
	_tileMapOutLine = tileMapOutLine
	_flatTilePlacementResolver = flatTilePlacementResolver
	_slopeTilePlacementResolver = slopeTilePlacementResolver
	
	_tileId = 0
	var mapData = _map.getAll()
	_heightNodes = get_node("Height").get_children()
	
	for y in range(_map.getSize().y):
		for x in range(_map.getSize().x):
			buildTiles(mapData[y][x])
	
func _process(delta):
	if Input.is_action_pressed("test_click"):
		var tilePosition = _heightNodes[0].get_child(0).world_to_map(
			get_viewport().get_mouse_position()
		)
		if _map.hasWorldPosition(tilePosition):
			var placedTiles
			# Very grim, need to work on this
			if _tileId != 3:
				placedTiles = _flatTilePlacementResolver.resolve(
					tilePosition,
					Vector2(3,3),
					_tileId
				)
			else:
				placedTiles = _slopeTilePlacementResolver.resolve(
					tilePosition,
					Vector2(3,3),
					_tileId
				)
			
			for placedTile in placedTiles:
				removeAllTiles(placedTile.getWorldPosition())
				buildTiles(placedTile)


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
					tileHeights.getWorldPosition().x,
					tileHeights.getWorldPosition().y,
					tile.getTileId(),
					flip.x,
					flip.y,
					false,
					tile.getAtlasTile()
				)
						
				_tileMapOutLine.set_cell(
					tileHeights.getWorldPosition().x,
					tileHeights.getWorldPosition().y,
					0,
					false,
					false,
					false,
					tileLayer.getOverlayTile().getAtlasTile()
				)
