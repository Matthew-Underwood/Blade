class_name Tile

var _tileSetId
var _sections
var _position
var _flipX
var _flipY

func _init(
		tileSetId : int,
		sections : Array,
		position : Vector2,
		flipX : bool,
		flipY : bool
	):
	_tileSetId = tileSetId
	_sections = sections
	_position = position
	_flipX = flipX
	_flipY = flipY
	
func getSections() -> Array:
	return _sections
	
func getTileSetId() -> int:
	return _tileSetId
	
func getWorldPosition() -> Vector2:
	return _position
	
func getFlipX() -> int:
	return _flipX
	
func getFlipY() -> int:
	return _flipY
