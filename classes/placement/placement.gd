class_name Placement

const TOP_LEFT = 0
const TOP_RIGHT = 1
const BOTTOM_LEFT = 2
const BOTTOM_RIGHT = 3
const TOP = 4
const BOTTOM = 5
const RIGHT = 6
const LEFT = 7
const SURROUNDED = 8

var _placementDimension : Vector2
var _placementPositions : Array
var _placementTiles : Dictionary
var _tileFactory : TileFactory

func _init(placementDimension : Vector2, tileFactory : TileFactory):
	_placementDimension = placementDimension
	_tileFactory = tileFactory

func calculate(clickedPosition : Vector2):
	var difference = calculateDifferenceFromClicked()
	var topLeftPosition = clickedPosition - difference
	calculatePlacementPositions(topLeftPosition)

func calculateDifferenceFromClicked() -> Vector2:
	var difference = Vector2.ZERO
	difference.x = floor(_placementDimension.x / 2)
	difference.y = floor(_placementDimension.y / 2)
	return difference
	
func calculatePlacementPositions(topLeftPosition : Vector2):
	
	for y in range(1, _placementDimension.y + 1):
		for x in range(1, _placementDimension.x + 1):
			var placementPosition = Vector2.ZERO
			placementPosition.x = x * topLeftPosition.x
			placementPosition.y = y * topLeftPosition.y
			_placementPositions.append(placementPosition)
	
	
func createPlacementTiles():
	_placementTiles = {
		TOP_LEFT = null,
		TOP_RIGHT = null,
		BOTTOM_LEFT = null,
		BOTTOM_RIGHT = null,
		LEFT = [],
		RIGHT = [],
		TOP = [],
		BOTTOM = [],
		SURROUNDED = []
	}
	
func addTilesToPlacementTiles():
	
	_placementTiles[TOP_LEFT] = _tileFactory.create(
		0,
		0,
		calculateCornerIndexOffset(TOP_LEFT)
	)
	_placementTiles[TOP_RIGHT] = _tileFactory.create(
		0,
		0,
		calculateCornerIndexOffset(TOP_RIGHT)
	)
	_placementTiles[BOTTOM_LEFT] = _tileFactory.create(
		0,
		0,
		calculateCornerIndexOffset(BOTTOM_LEFT)
	)
	
	_placementTiles[BOTTOM_RIGHT] = _tileFactory.create(
		0,
		0,
		calculateCornerIndexOffset(BOTTOM_RIGHT)
	)
	
	for type in [TOP, RIGHT , BOTTOM, LEFT]:
		for i in range(1, _placementDimension - 1):
			_placementTiles[type].append(
				_tileFactory.create(
					0,
					0,
					calculateSidesIndexOffset(type, i)
				)
			)
			
	for position in range(_placementPositions.size()):
		if _placementPositions[position] != null:
			_placementTiles[SURROUNDED].append(
				_tileFactory.create(
					0,
					0,
					_placementPositions[position]
				)
			)
	
func calculateCornerIndexOffset(placementType : int) -> int:
	var increment = _placementDimension.x - 1
	match placementType:
		TOP_LEFT:
			indexOffset = 0
		TOP_RIGHT:
			indexOffset = increment 
		BOTTOM_LEFT:
			indexOffset = increment + pow(increment, increment)
		BOTTOM_RIGHT:
			indexOffset = increment + pow(increment, increment) + increment
		TOP:
			indexOffset = 1
		BOTTOM:
			indexOffset = pow(_placementDimension.x, _placementDimension.x) - (_placementDimension.x - 1)
		LEFT:
			indexOffset = _placementDimension.x
		RIGHT:
			indexOffset = _placementDimension.x * 2 - 1
	
	#TODO see this can be returned rather than create a copy
	return getCopy(indexOffset)
	
func calculateSidesIndexOffset(placementType : int, index : int) -> int:
	match placementType:
		TOP:
			indexOffset = index
		BOTTOM:
			indexOffset = _placementDimension.x * (_placementDimension.x - 1) + index
		LEFT:
			indexOffset = _placementDimension.x * index
		RIGHT:
			indexOffset = (_placementDimension.x * index) + (_placementDimension.x - 1)
	
	#TODO see this can be returned rather than create a copy
	return getCopy(indexOffset)

func getCopy(index : int) -> Vector2:
	var element = _placementPositions[indexOffset]
	_placementPositions[indexOffset] = null
	return element
	
	
	
	
	
	
	
