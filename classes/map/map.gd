class_name Map

var _data : Array
var _size : Vector2
var _offset : Vector2

func _init(data : Array, size : Vector2, offset : Vector2):
	_data = data
	_size = size
	_offset = offset
	
func getAll() -> Array:
	return _data
	
func getDataFromPos(worldPos : Vector2) -> Array:
	var localPos = worldPositionToLocal(worldPos)
	return _data[localPos.y][localPos.x]

func getSize() -> Vector2:
	return _size

func getWorldOrigin() -> Vector2:
	return _offset
	
func hasWorldPosition(position : Vector2) -> bool:
	var sizeX = _size.x - 1
	var sizeY = _size.y - 1
	var localPosition = worldPositionToLocal(position)
	if localPosition.y >= 0 && localPosition.y <= sizeY && localPosition.x >= 0 && localPosition.x <= sizeX:
		return true
	return false
	
func worldPositionToLocal(position : Vector2) -> Vector2:
	return position - _offset
