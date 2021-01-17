class_name LayersFactory

var _tileFactory : TileFactory

func _init(tileFactory : TileFactory):
	_tileFactory = tileFactory
	
func create(mapPosition : Vector2, subTile : Vector2) -> Layers:
	
	var layers = load("res://classes/tile/layers.gd")
	var terrianTiles = [_tileFactory.create(0, 0, mapPosition, 0, 0)]
	
	var overlaySubTile = determineOverlayTile(subTile)
	var overlayTile = _tileFactory.create(
		overlaySubTile,
		0,
		mapPosition,
		false,
		false
	)
	return layers.new(terrianTiles, overlayTile, mapPosition)
	
func determineOverlayTile(subTile : Vector2) -> int :
	#TODO this will be a switch statement when we have height tiles
	return 0
