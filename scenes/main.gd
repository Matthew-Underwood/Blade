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
	
	var tilePlacementResolver = load("res://classes/tile/placement/tile_placement_resolver.gd")
	
	var sectionsResolver = load("res://classes/tile/tile_sections_resolver.gd")
	var flatTileAtlasResolver = load("res://classes/tile/atlas/flat_tile_atlas_resolver.gd")
	var slopeTileAtlasResolver = load("res://classes/tile/atlas/slope_tile_atlas_resolver.gd")
	
	var placement = load("res://classes/placement/diamond_placement.gd")
	var tileFactory = load("res://classes/tile/tile_factory.gd")
	var flatTileAction = load("res://classes/tile/placement/action/flat_tile_action.gd")
	var slopeTileAction = load("res://classes/tile/placement/action/slope_tile_action.gd")
	var layerFactory = load("res://classes/tile/layers_factory.gd")
	var heightFactory = load("res://classes/tile/height_factory.gd")
	var mapFactory = load("res://classes/map/map_factory.gd")
	
	flatTileAtlasResolver = flatTileAtlasResolver.new()
	slopeTileAtlasResolver = slopeTileAtlasResolver.new()
	#TODO may need to rename this to reflect flat tiles
	
	sectionsResolver = sectionsResolver.new()
	placement = placement.new()
	
	var flatTileFactory = tileFactory.new(sectionsResolver, flatTileAtlasResolver)
	var flatLayerFactory = layerFactory.new(flatTileFactory)
	
	var slopeTileFactory = tileFactory.new(sectionsResolver, slopeTileAtlasResolver)
	var slopeLayerFactory = layerFactory.new(slopeTileFactory)
	
	flatTileAction = flatTileAction.new()
	slopeTileAction = slopeTileAction.new(slopeLayerFactory)
	
	var tile = flatTileFactory.create(
		DiamondPlacement.SURROUNDED,
		0,
		Vector2.ZERO,
		Vector2.ZERO
	)
	heightFactory = heightFactory.new(3, flatLayerFactory)
	
	mapFactory = mapFactory.new(heightFactory, flatTileFactory, origin)
	
	var map = mapFactory.create(size, tile)
	
	var flatTilePlacementResolver = tilePlacementResolver.new(
		placement,
		flatTileFactory,
		flatTileAction,
		map
	)
	
	var slopeTilePlacementResolver = tilePlacementResolver.new(
		placement,
		slopeTileFactory,
		slopeTileAction,
		map
	)
	
	var tileMapLayers = world.get_node("Height/0/").get_children()
	var tileMapOutline = world.get_node("OutLine/Layer1")



	#TODO fix gui debugging
	gui.setMap(map)
	gui.setTileMapLayers(tileMapLayers)
	world.buildWorld(
		map,
		tileMapOutline,
		flatTilePlacementResolver,
		slopeTilePlacementResolver
	)

	world.set_process(true)
	gui.set_process(true)
