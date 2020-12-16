class_name Map

var _data : Array
var _size : Vector2
var _offset : Vector2


func _init(data : Array, size : Vector2, offset : Vector2):
	_data = data
	_size = size
	_offset = offset
	
func getData() -> Array:
	return _data
	
func updateAndGetData(placingTiles : Array) -> Array:
	var returnedData = []
	for placingTile in placingTiles:
		var sections = placingTile.getSections().duplicate(true)
		var localPosition = worldPositionToLocal(placingTile.getWorldPosition())
		var layer = _data[localPosition.y][localPosition.x].size()
		#x 27 y 1
		#x 28 y 0
		while layer > 0:
			layer -= 1
			var storedTile = _data[localPosition.y][localPosition.x][layer]
			var diff = sectionsDiff(
				storedTile.getSections(),
				sections
			)
			if diff.empty() == true:
				_data[localPosition.y][localPosition.x].erase(storedTile)
			else:
				sections = sections + diff
		_data[localPosition.y][localPosition.x].push_back(placingTile)
		returnedData.append(_data[localPosition.y][localPosition.x])
	return returnedData

func sectionsDiff(
		sectionsToCheck : Array,
		sectionsCompareAgasint : Array
	) -> Array:
	var diff = []
	
	for sectionToCheck in sectionsToCheck:
		if (sectionToCheck in sectionsCompareAgasint) == false:
			diff.append(sectionToCheck)
	return diff
	
func getSize() -> Vector2:
	return _size
	
func hasWorldPosition(position : Vector2) -> bool:
	var sizeX = _size.x - 1
	var sizeY = _size.y - 1
	var localPosition = worldPositionToLocal(position)
	if localPosition.y >= 0 && localPosition.y <= sizeY && localPosition.x >= 0 && localPosition.x <= sizeX:
		return true
	return false
	
func worldPositionToLocal(position : Vector2) -> Vector2:
	return position - _offset
