class_name MapFactory

var _tileFactory

func _init(tileFactory):
	_tileFactory = tileFactory

func create(size : Vector2, origin : Vector2):
	
	var map = load("res://classes/map/map.gd")
	
	var mapData = []
	for y in range(size.y):
		mapData.append([])
		for x in range(size.x):
			mapData[y].append([
				_tileFactory.create(
					0,
					Vector2(x,y) + origin,
					0,
					0
				)])
	
	return map.new(mapData, size, origin)
