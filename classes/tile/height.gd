class_name Height

var _maxHeight : int
var _worldPosition : Vector2
var _data : Array

func _init(data : Array, maxHeight : int, worldPosition : Vector2):
	_data = data
	_maxHeight = maxHeight
	_worldPosition = worldPosition
	
func getAll() -> Array:
	return _data
	
func getWorldPosition() -> Vector2:
	return _worldPosition
	
func getMaxHeight() -> int:
	return _maxHeight
	
func getHeight(height : int) -> Layers:
	assert(validateHeight(height))
	return _data[height]

func hasHeight(height : int) -> bool:
	return validateHeight(height)
	
func getCurrentHeight() -> int:
	return _data.size() - 1

func increaseHeight(layer : Layers):
	_data.append(layer)
	
func validateHeight(height : int) -> bool:
	return height >= 0 && height < _data.size()
	
	
