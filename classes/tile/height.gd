class_name Height

var _maxHeight : int
var _data : Array

func _init(data : Array):
	_data = data
	_maxHeight = _data.size() - 1
	
func getAll() -> Array:
	return _data
	
func getMaxHeight() -> int:
	return _maxHeight
	
func getHeight(height : int) -> Layers:
	assert(validateHeight(height))
	return _data[height]
	
func getCurrentHeight() -> int:
	var i = 0
	for data in _data:
		if data == null:
			return i
		i = i + 1
	return i

func setHeight(height : int, layer : Layers):
	assert(validateHeight(height))
	_data[height] = layer
	
func validateHeight(height : int) -> bool:
	return height >= 0 && height <= _maxHeight
	
	
