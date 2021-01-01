extends Node

var _tilePicker : TilePicker
var _rootTileMap : TileMap
var _tileTypes : TileTypes
var _map : Map

func buildWorld(
	map : Map,
	rootTileMap : Node,
	tileTypes : TileTypes,
	tilePicker : TilePicker
	):
	_tileTypes = tileTypes
	_rootTileMap = rootTileMap
	_map = map
	_tilePicker = tilePicker
	var mapData = map.getData()
	
	for y in range(map.getSize().y):
		for x in range(map.getSize().x):
			var tileData = mapData[y][x][0]
			_rootTileMap.set_cell(
				tileData.getWorldPosition().x,
				tileData.getWorldPosition().y,
				0,
				0,
				0,
				false,
				Vector2(0,0)
			)
	

	
	
func _process(delta):
	if Input.is_action_pressed("test_click"):
		var tilePosition = _rootTileMap.world_to_map(
			get_viewport().get_mouse_position()
		)
		if _map.hasWorldPosition(tilePosition):
			var tiles = _tilePicker.get_tiles(tilePosition, Vector2.ONE)
			var updatedTiles = _map.updateAndGetData(tiles)
			for updatedTile in updatedTiles:
				var tileMaplayer = 1
				for updatedTileLayer in updatedTile:
					var tileMap = get_node("Terrian/Layer" + str(tileMaplayer))
						
					tileMap.set_cell(
						updatedTileLayer.getWorldPosition().x,
						updatedTileLayer.getWorldPosition().y,
						1,
						updatedTileLayer.getFlipX(),
						updatedTileLayer.getFlipY(),
						false,
						updatedTileLayer.getSubTile()
					)
					tileMaplayer += 1
