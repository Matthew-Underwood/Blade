extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var world = get_node("WorldRoot")
	var gui = get_node("Root/DebugPanel")
	var tilesGui = get_node("Root/TilesPanel/Tiles")
	world.set_process(false)
	gui.set_process(false)
	
	var tileId = 0
	var tiles = tilesGui.get_children()
	for tile in tiles:
		tile.setTileId(tileId, world)
		tileId += 1
	
	var origin = Vector2(27, 0)
	var size = Vector2(10, 10)
	var heightFactory = load("res://classes/tile/height_factory.gd")
	var tileFactory = load("res://classes/tile/tile_factory.gd")
	var layerFactory = load("res://classes/tile/layers_factory.gd")
	var mapFactory = load("res://classes/map/map_factory.gd")
	var tilePicker = load("res://classes/tile_picker.gd")
	var tileTypes = load("res://classes/tile_types.gd")
	var tileMapLayers = world.get_node("Height/0/").get_children()
	var tileMapOutline = world.get_node("OutLine/Layer1")
	
	tileTypes = tileTypes.new()
	tileFactory = tileFactory.new(origin, tileTypes)
	layerFactory = layerFactory.new(tileFactory)
	
	heightFactory = heightFactory.new(3, layerFactory)
	mapFactory = mapFactory.new(heightFactory)
	var map = mapFactory.create(size, origin)
	tilePicker = tilePicker.new(tileFactory, map)
	
	#TODO fix gui debugging
	gui.setMap(map)
	gui.setTileMapLayers(tileMapLayers)
	world.buildWorld(map, tileTypes, tileMapOutline, tilePicker)
	
	world.set_process(true)
	gui.set_process(true)
