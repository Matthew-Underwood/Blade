class_name TilePlacementResolver

var _diamondPlacement : DiamondPlacement
var _tileFactory : TileFactory
var _tileAction
var _map : Map

func _init(
	diamondPlacement : DiamondPlacement,
	tileFactory : TileFactory,
	tileAction,
	map : Map
):
		
	_diamondPlacement = diamondPlacement
	_tileFactory = tileFactory
	_tileAction = tileAction
	_map = map
	

func resolve(origin : Vector2, size : Vector2, id : int) -> Array:
	var tiles = []
	var positions = _diamondPlacement.calculatePositions(origin, size)
	var originData = _map.getDataFromPos(origin)
	
	for type in positions:
		for position in positions[type]:
			if _map.hasWorldPosition(position):
				var data = _map.getDataFromPos(position)
				var tile = determineTile(position, type, id)
				tiles.append(_tileAction.process(data, tile, originData))
			
	return tiles
			

func determineTile(position: Vector2, type : int, id : int) -> Tile:
	var tile
	match type:
		DiamondPlacement.TOP:
			tile = _tileFactory.create(DiamondPlacement.TOP, id, position, Vector2.ZERO)
		DiamondPlacement.LEFT:
			tile = _tileFactory.create(DiamondPlacement.LEFT, id, position, Vector2(1,0))
		DiamondPlacement.RIGHT:
			tile = _tileFactory.create(DiamondPlacement.RIGHT, id, position, Vector2.ZERO)
		DiamondPlacement.BOTTOM:
			tile = _tileFactory.create(DiamondPlacement.BOTTOM, id, position, Vector2(0,1))
		DiamondPlacement.TOP_LEFT:
			tile = _tileFactory.create(DiamondPlacement.TOP_LEFT, id, position,Vector2.ZERO)
		DiamondPlacement.TOP_RIGHT:
			tile = _tileFactory.create(DiamondPlacement.TOP_RIGHT, id, position, Vector2(1,0))
		DiamondPlacement.BOTTOM_LEFT:
			tile = _tileFactory.create(DiamondPlacement.BOTTOM_LEFT, id, position, Vector2(0,1))
		DiamondPlacement.BOTTOM_RIGHT:
			tile = _tileFactory.create(DiamondPlacement.BOTTOM_RIGHT, id, position, Vector2(1,1))
		_:
			var flip = Vector2(randi() % 2, randi() % 2)
			tile = _tileFactory.create(
				DiamondPlacement.SURROUNDED,
				id,
				position,
				flip
			)
	return tile
