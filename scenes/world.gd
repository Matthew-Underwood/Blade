extends Node
var _tilePicker : TilePicker
var _map : Map
var _tileId : int
var _tileMaps : Array
var _tileMapOutLine : TileMap
var _heightNodes : Array

func buildWorld(
		map : Map,
		tileMapOutLine : TileMap,
		tilePicker : TilePicker
	):
		
	_map = map
	_tileMapOutLine = tileMapOutLine
	_tilePicker = tilePicker
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
			var tiles = _tilePicker.get_tiles(
				tilePosition,
				Vector2.ONE,
				_tileId
			)
			for tile in tiles:
				var tileWorldPosition = tile.getWorldPosition()
				var height = _map.getDataFromPos(tileWorldPosition)
				var heightLayer = height.getHeight(0)
				heightLayer.updateTerrianTiles(tile)
				removeAllTiles(tileWorldPosition)
				buildTiles(height)


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
		var tileLayer = tileHeights.getHeight(tileHeight)
		if tileLayer != null:
			var tiles = tileLayer.getTerrianTiles()
			for tileIndex in range(tileLayer.getTerrianTilesCount()):
				var tile = tiles[tileIndex]
				var tileMap = tileMapLayer[tileIndex]
				tileMap.set_cell(
					tile.getWorldPosition().x,
					tile.getWorldPosition().y,
					tile.getTileId(),
					tile.getFlipX(),
					tile.getFlipY(),
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
