class_name DiamondPlacement

const TOP_LEFT = 0
const TOP_RIGHT = 1
const BOTTOM_LEFT = 2
const BOTTOM_RIGHT = 3
const TOP = 4
const BOTTOM = 5
const RIGHT = 6
const LEFT = 7
const SURROUNDED = 8

var _placementSize : Vector2

var _placementTiles = {
		TOP_LEFT : null,
		TOP_RIGHT : null,
		BOTTOM_LEFT : null,
		BOTTOM_RIGHT : null,
		LEFT : [],
		RIGHT : [],
		TOP : [],
		BOTTOM : [],
		SURROUNDED : []
	}

func calculatePositions(clickedPosition : Vector2, placementSize : Vector2) -> Dictionary:
	
	var positions = []
	_placementSize = placementSize
	var difference = Vector2(
		floor(_placementSize.x / 2), 
		floor(_placementSize.y / 2)
	)
	var topLeftPosition = Vector2(
		clickedPosition.x - difference.x,
		clickedPosition.y - difference.y
	)
	
	for y in range(_placementSize.y):
		for x in range(_placementSize.x):
			var placementPosition = Vector2(
				x + topLeftPosition.x,
				y + topLeftPosition.y
			)
			positions.append(placementPosition)
			
	##TODO  addPositions can be done loads easier than this
	return addPositions(positions)

func addPositions(positions : Array) -> Dictionary:
	
	for type in [TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT]:
		var id = calculateCornerIndexOffset(type)
		_placementTiles[type] = positions[id]
		positions[id] = null
	
	for type in [TOP, RIGHT , BOTTOM, LEFT]:
		for i in range(1, _placementSize.x - 1):
			var id = calculateSidesIndexOffset(type, i)
			_placementTiles[type].append(positions[id])
			positions[id] = null
			
	for position in range(positions.size()):
		if positions[position] != null:
			_placementTiles[SURROUNDED].append(positions[position])
			
	return _placementTiles

func calculateCornerIndexOffset(placementType : int) -> int:
	
	var increment = _placementSize.x - 1
	var indexOffset
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
			indexOffset = pow(_placementSize.x, _placementSize.x) - (_placementSize.x - 1)
		LEFT:
			indexOffset = _placementSize.x
		RIGHT:
			indexOffset = _placementSize.x * 2 - 1
	
	return indexOffset
	
func calculateSidesIndexOffset(placementType : int, index : int) -> int:
	var indexOffset
	match placementType:
		TOP:
			indexOffset = index
		BOTTOM:
			indexOffset = _placementSize.x * (_placementSize.x - 1) + index
		LEFT:
			indexOffset = _placementSize.x * index
		RIGHT:
			indexOffset = (_placementSize.x * index) + (_placementSize.x - 1)
			
	return indexOffset
