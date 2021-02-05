class_name Tile

var _tileType
var _atlasTile
var _tileId
var _sections
var _position
var _flip

func _init(
	tileType : int,
	atlasTile : Vector2,
	tileId : int,
	sections : Array,
	position : Vector2,
	flip : Vector2
):
	_tileType = tileType
	_atlasTile = atlasTile
	_tileId = tileId
	_sections = sections
	_position = position
	_flip = flip
	
func getSections() -> Array:
	return _sections
	
func getTileId() -> int:
	return _tileId
	
func getTileType() -> int:
	return _tileType
	
func getAtlasTile() -> Vector2:
	return _atlasTile
	
func getWorldPosition() -> Vector2:
	return _position

func getFlip() -> Vector2:
	return _flip
