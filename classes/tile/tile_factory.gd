class_name TileFactory
	
var _tile
var _tileTypes


func _init(origin : Vector2, tileTypes : TileTypes):
	_tile = load("res://classes/tile/tile.gd")
	_tileTypes = tileTypes
	
func create(
		tileType : int,
		tileId : int,
		position : Vector2,
		flipX : bool,
		flipY : bool
	):
	
	var tile = null
	var tileIds = []
	var atlasId = null
#	var tileType = getTypeFromIdAndRotation(id ,flipX, flipY)
	match tileType:
		TileTypes.FLAT:
			tileIds = [
				TileSections.TOP,
				TileSections.BOTTOM,
				TileSections.LEFT,
				TileSections.RIGHT
				]
			atlasId = TileTypes.FLAT
		TileTypes.TOP:
			tileIds = [TileSections.BOTTOM]
			atlasId = TileTypes.TOP
		TileTypes.BOTTOM:
			tileIds = [TileSections.TOP]
			atlasId = TileTypes.TOP
		TileTypes.LEFT:
			tileIds = [TileSections.RIGHT]
			atlasId = TileTypes.RIGHT
		TileTypes.RIGHT:
			tileIds = [TileSections.LEFT]
			atlasId = TileTypes.RIGHT
		TileTypes.TOP_LEFT:
			tileIds = [TileSections.BOTTOM, TileSections.RIGHT]
			atlasId = TileTypes.TOP_LEFT
		TileTypes.TOP_RIGHT:
			tileIds = [TileSections.BOTTOM, TileSections.LEFT]
			atlasId = TileTypes.TOP_LEFT
		TileTypes.BOTTOM_LEFT:
			tileIds = [TileSections.TOP, TileSections.RIGHT]
			atlasId = TileTypes.TOP_LEFT
		TileTypes.BOTTOM_RIGHT:
			tileIds = [TileSections.TOP, TileSections.LEFT]
			atlasId = TileTypes.TOP_LEFT
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
	tile = _tile.new(
		_tileTypes.tileTypeToAtlas(atlasId),
		tileId,
		tileIds,
		position,
		flipX,
		flipY
	)
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
	elif id >= 3 && id <= 3:
		tileId = TileTypes.TOP
		flipX = 0
		flipY = 1
	elif id >= 4 && id <= 4:
		tileId = TileTypes.LEFT
		flipX = 1
		flipY = 0
	elif id >= 2  && id <= 2:
		tileId = TileTypes.TOP_LEFT
		flipX = 2
		flipY = 1
	elif id >= 40 && id <= 49:
		tileId = TileTypes.L_TOP_LEFT
		flipX = 1
		flipY = 2
	return {"flipX" : flipX, "flipY" : flipY, "id" : tileId}
