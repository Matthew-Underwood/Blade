class_name MapFactory

var _heightFactory : HeightFactory

func _init(heightFactory : HeightFactory):
	_heightFactory = heightFactory

func create(size : Vector2, origin : Vector2) -> Map:
	var map = load("res://classes/map/map.gd")
	var mapData = []
	for y in range(size.y):
		mapData.append([])
		for x in range(size.x):
			mapData[y].append(_heightFactory.create(Vector2(x, y) + origin))
	
	#TODO move tileLayerFactory dep
	return map.new(mapData, size, origin)
