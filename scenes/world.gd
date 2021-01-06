extends Node

var _tilePicker : TilePicker
var _rootTileMap : TileMap
var _tileTypes : TileTypes
var _map : Map
var _tileId : int
var _tileMaps

func _ready():
	_tileMaps = get_node("Terrian").get_children()

func buildWorld(
	map : Map,
	rootTileMap : Node,
	tileTypes : TileTypes,
	tilePicker : TilePicker
	):
	_tileId = 0
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
				tileData.getTileId(),
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
			var tiles = _tilePicker.get_tiles(tilePosition, Vector2.ONE, _tileId)
			var updatedTiles = _map.updateAndGetData(tiles)
			
			for updatedTile in updatedTiles:
				var tileMaplayer = 1
				for updatedTileLayer in updatedTile:
					if tileMaplayer == 1:
						removeAllTiles(updatedTileLayer.getWorldPosition())	
					var tileMap = get_node("Terrian/Layer" + str(tileMaplayer))
					tileMap.set_cell(
						updatedTileLayer.getWorldPosition().x,
						updatedTileLayer.getWorldPosition().y,
						updatedTileLayer.getTileId(),
						updatedTileLayer.getFlipX(),
						updatedTileLayer.getFlipY(),
						false,
						updatedTileLayer.getSubTile()
					)
					tileMaplayer += 1
				
				

func setTileId(id : int):
	_tileId = id
	
func removeAllTiles(worldPosition : Vector2):
	for tileMap in _tileMaps:
		tileMap.set_cell(worldPosition.x, worldPosition.y, -1)
