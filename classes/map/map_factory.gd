class_name MapFactory

var _heightFactory : HeightFactory
var _tileFactory : TileFactory
var _origin : Vector2

func _init(
	heightFactory : HeightFactory,
	tileFactory : TileFactory,
	origin: Vector2
):
	_heightFactory = heightFactory
	_tileFactory = tileFactory
	_origin = origin

func create(size : Vector2, tile : Tile) -> Map:
	var map = load("res://classes/map/map.gd")
	var mapData = []
	for y in range(size.y):
		mapData.append([])
		for x in range(size.x):
			mapData[y].append(
				_heightFactory.create(
					_tileFactory.create(
						tile.getTileType(),
						tile.getTileId(),
						Vector2(x,y) + _origin,
						tile.getFlip()
					)
				)
			)
	return map.new(mapData, size, _origin)
