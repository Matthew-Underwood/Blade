extends Node


func _ready():
	var tile = load("res://classes/tile/tile.gd")
	var tileFactory = load("res://classes/tile/tile_factory.gd")
	var tileSide = 10
	tileFactory = tileFactory.new(tile)
	
	var returnedTile = tileFactory.create(tileSide, Vector2.ZERO, false, false)
	assert(returnedTile.getIds() == [TileSections.TOP_LEFT, TileSections.TOP_RIGHT])
	print("Top tile created correctly")
	
	var returnedTile2 = tileFactory.create(tileSide, Vector2.ZERO, false, true)
	assert(returnedTile2.getIds() == [TileSections.BOTTOM_LEFT, TileSections.BOTTOM_RIGHT])
	print("Bottom tile created correctly")
	
	var returnedTile3 = tileFactory.create(tileSide, Vector2.ZERO, true, false)
	assert(returnedTile3.getIds() == [TileSections.TOP_LEFT, TileSections.BOTTOM_LEFT])
	print("Left tile created correctly")
	
	var returnedTile4 = tileFactory.create(tileSide, Vector2.ZERO, true, true)
	assert(returnedTile4.getIds() == [TileSections.TOP_RIGHT, TileSections.BOTTOM_RIGHT])
	print("Right tile created correctly")
	
