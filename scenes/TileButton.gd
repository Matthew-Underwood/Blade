extends Button

var _world
var _tileId

func setTileId(id : int, world : Node):
	_tileId = id
	_world = world
	
func updateTileId():
	_world.setTileId(_tileId)
