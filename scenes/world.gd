extends Node

var _tilePicker : TilePicker
var _tileMap1 : TileMap
var _map

func _ready():
	var tileFactory = load("res://classes/tile/tile_factory.gd")
	var mapFactory = load("res://classes/map/map_factory.gd")
	var tilePicker = load("res://classes/tile_picker.gd")
	var origin = Vector2(27,0)
	var size = Vector2(10,10)
	tileFactory = tileFactory.new(origin)
	mapFactory = mapFactory.new(tileFactory)
	_map = mapFactory.create(size, origin)
	_tilePicker = tilePicker.new(tileFactory, _map)
	var mapData = _map.getData()
	_tileMap1 = get_node("Terrian/Layer1")
	
	for y in range(_map.getSize().y):
		for x in range(_map.getSize().x):
			var tileData = mapData[y][x][0]
			_tileMap1.set_cell(
				tileData.getWorldPosition().x,
				tileData.getWorldPosition().y,
				tileData.getTileSetId(),
				tileData.getFlipX(),
				tileData.getFlipY()
			)

func _process(delta):
	if Input.is_action_pressed("test_click"):
		var tilePosition = _tileMap1.world_to_map(
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
						updatedTileLayer.getTileSetId(),
						updatedTileLayer.getFlipX(),
						updatedTileLayer.getFlipY()
					)
					tileMaplayer += 1
