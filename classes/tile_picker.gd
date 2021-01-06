class_name TilePicker

var _tile
var _tileFactory
var _topCorner
var _leftCorner
var _bottomCorner
var _rightCorner
var _topLeftSide
var _topRightSide
var _lowerLeftSide
var _lowerRightSide
var _map

func _init(tileFactory, map):
	_tileFactory = tileFactory
	_map = map
	
func get_tiles(position: Vector2, area : Vector2, tileId : int) -> Array:
	
	var tiles = []
	_topCorner = position - area	
	_leftCorner = Vector2(position.x - area.x, position.y + area.y)
	_bottomCorner = position + area	
	_rightCorner = Vector2(position.x + area.x, position.y - area.y)
	_topLeftSide = Vector2(position.x - area.x, position.y)
	_topRightSide = Vector2(position.x, position.y - area.y)
	_lowerLeftSide = Vector2(position.x, position.y + area.y)
	_lowerRightSide = Vector2(position.x + area.x, position.y)
		
	var minTile = position - area
	var maxTile = position + area
	for y in range(minTile.y, maxTile.y + 1):
		for x in range(minTile.x, maxTile.x + 1):
			if _map.hasWorldPosition(Vector2(x, y)):
				tiles.append(determine_tile(Vector2(x, y), tileId))
	return tiles
	
func determine_tile(position: Vector2, tileId : int):
	var tile
	match position:
		_topCorner:
			tile = _tileFactory.create(TileTypes.TOP, tileId, position, 0, 0)
		_leftCorner:
			tile = _tileFactory.create(TileTypes.LEFT, tileId, position, 1, 0)
		_rightCorner:
			tile = _tileFactory.create(TileTypes.RIGHT, tileId, position, 0, 0)
		_bottomCorner:
			tile = _tileFactory.create(TileTypes.BOTTOM, tileId, position, 0, 1)
		_topLeftSide:
			tile = _tileFactory.create(TileTypes.TOP_LEFT, tileId, position, 0, 0)
		_topRightSide:
			tile = _tileFactory.create(TileTypes.TOP_RIGHT, tileId, position, 1, 0)
		_lowerLeftSide:
			tile = _tileFactory.create(TileTypes.BOTTOM_LEFT, tileId, position, 0, 1)
		_lowerRightSide:
			tile = _tileFactory.create(TileTypes.BOTTOM_RIGHT, tileId, position, 1, 1)
		_:
			tile = _tileFactory.create(
				TileTypes.FLAT,
				tileId,
				position,
				randi() % 2,
				randi() % 2
			)
	return tile
