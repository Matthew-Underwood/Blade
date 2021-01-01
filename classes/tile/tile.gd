class_name Tile

var _subTile
var _sections
var _position
var _flipX
var _flipY

func _init(
		subTile : Vector2,
		sections : Array,
		position : Vector2,
		flipX : bool,
		flipY : bool
	):
	_subTile = subTile
	_sections = sections
	_position = position
	_flipX = flipX
	_flipY = flipY
	
func getSections() -> Array:
	return _sections
	
func getSubTile() -> Vector2:
	return _subTile
	
func getWorldPosition() -> Vector2:
	return _position

func getFlipX() -> int:
	return _flipX
	
func getFlipY() -> int:
	return _flipY
