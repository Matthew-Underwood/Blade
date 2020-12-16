class_name Tile_Factory
	
var _tile


func _init(origin : Vector2):
	_tile = load("res://classes/tile/tile.gd")
	
func create(
		id : int,
		position : Vector2,
		flipX : bool,
		flipY : bool
	):
	
	var tile = null
	var tileIds = []
	var tileType = getTypeFromIdAndRotation(id ,flipX, flipY)
	match tileType:
		TileTypes.FLAT:
			tileIds = [
				TileSections.TOP,
				TileSections.BOTTOM,
				TileSections.LEFT,
				TileSections.RIGHT
				]
		TileTypes.TOP:
			tileIds = [TileSections.BOTTOM]
		TileTypes.BOTTOM:
			tileIds = [TileSections.TOP]
		TileTypes.LEFT:
			tileIds = [TileSections.RIGHT]
		TileTypes.RIGHT:
			tileIds = [TileSections.LEFT]
		TileTypes.TOP_LEFT:
			tileIds = [TileSections.BOTTOM, TileSections.RIGHT]
		TileTypes.TOP_RIGHT:
			tileIds = [TileSections.BOTTOM, TileSections.LEFT]
		TileTypes.BOTTOM_LEFT:
			tileIds = [TileSections.TOP, TileSections.RIGHT]
		TileTypes.BOTTOM_RIGHT:
			tileIds = [TileSections.TOP, TileSections.LEFT]
#		TileTypes.L_TOP_RIGHT:
#			tileIds = [
#				TileSections.TOP_LEFT,
#				TileSections.BOTTOM_LEFT,
#				TileSections.BOTTOM_RIGHT
#				]
#		TileTypes.L_TOP_LEFT:
#			tileIds = [
#				TileSections.TOP_RIGHT,
#				TileSections.BOTTOM_LEFT,
#				TileSections.BOTTOM_RIGHT
#				]
#		TileTypes.L_BOTTOM_RIGHT:
#			tileIds = [
#				TileSections.TOP_LEFT,
#				TileSections.TOP_RIGHT,
#				TileSections.BOTTOM_LEFT,
#				]
#		TileTypes.L_BOTTOM_LEFT:
#			tileIds = [
#				TileSections.TOP_LEFT,
#				TileSections.TOP_RIGHT,
#				TileSections.BOTTOM_RIGHT,
#				]
	# 3 from id
	# tileIds are sections
	tile = _tile.new(id, tileIds, position, flipX, flipY)
	return tile
	
func getTypeFromIdAndRotation(id : int, flipX : bool, flipY : bool) -> int:
	
	var tileId = null
	var tileData = getDataFromId(id)
	# id 5 for top left
	if flipX == false && flipY == true:
		tileId = tileData["id"] + tileData["flipY"]
	elif flipX == true && flipY == false:
		tileId = tileData["id"] + tileData["flipX"]
	elif flipX == true && flipY == true:
		tileId = tileData["id"] + tileData["flipX"] + tileData["flipY"]
	else:
		tileId = tileData["id"]
	return tileId
		
func getDataFromId(id):
	
	var tileId = null
	var flipX = null
	var flipY = null
	if id >= 0 && id <= 1:
		tileId = TileTypes.FLAT
		flipX = 0
		flipY = 0
	elif id >= 4 && id <= 4:
		tileId = TileTypes.TOP
		flipX = 1
		flipY = 0
	elif id >= 5 && id <= 5:
		tileId = TileTypes.LEFT
		flipX = 0
		flipY = 1
	elif id >= 3 && id <= 3:
		tileId = TileTypes.TOP_LEFT
		flipX = 2
		flipY = 1
	elif id >= 40 && id <= 49:
		tileId = TileTypes.L_TOP_LEFT
		flipX = 1
		flipY = 2
	return {"flipX" : flipX, "flipY" : flipY, "id" : tileId}
