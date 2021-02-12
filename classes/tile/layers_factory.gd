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

func createFromTiles(tilesToUpdate : Array) -> Layers:
	
	if tilesToUpdate.empty():
		assert(false, "No tiles to update")
		
	var tiles = []
	for tileToUpdate in tilesToUpdate:
		tiles.append(
			_tileFactory.create(
				tileToUpdate.getTileType(),
				tileToUpdate.getTileId(),
				tileToUpdate.getWorldPosition(),
				tileToUpdate.getFlip()
				)
			)
	
	var overlayTile = createOverLay(tilesToUpdate[0])
	return _layers.new(tiles, overlayTile)

func create(tile : Tile) -> Layers:
	var tiles = []
	tiles.append(
		_tileFactory.create(
			tile.getTileType(),
			tile.getTileId(),
			tile.getWorldPosition(),
			tile.getFlip()
		)
	)
	var overlayTile = createOverLay(tile)
	return _layers.new(tiles, overlayTile)
	

#TODO need to work on this
func createOverLay(tile : Tile) -> Tile:
	return _tileFactory.create(
		tile.getTileType(),
		0,
		tile.getWorldPosition(),
		Vector2.ZERO
	)
	

