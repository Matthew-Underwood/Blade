class_name LayersFactory

var _tileFactory : TileFactory
var _layers

func _init(tileFactory : TileFactory):
	_tileFactory = tileFactory
	_layers = load("res://classes/tile/layers.gd")
	
# add array of tiles from existing layer
# needs to go through tile factory to recalculate atlas vector
# need to have two layer factories, one for flat tiles and one for slopes
# figure out more elegant way of passing in array tiles in map creation with defaults

func create(tilesToUpdate : Array) -> Layers:
	var tiles = []
	var worldPosition = null
	for tileToUpdate in tilesToUpdate:
		if worldPosition == null:
			worldPosition = tileToUpdate.getWorldPosition()
		tiles.append(
			_tileFactory.create(
				tileToUpdate.getTileType(),
				tileToUpdate.getTileId(),
				tileToUpdate.getWorldPosition(),
				tileToUpdate.flip()
				)
			)
	
	var firstTile = tiles[0]
	var overlayTile = _tileFactory.create(
		firstTile.getTileType(),
		0,
		firstTile.getWorldPosition(),
		Vector2.ZERO
	)
	return _layers.new(tiles, overlayTile, worldPosition)
