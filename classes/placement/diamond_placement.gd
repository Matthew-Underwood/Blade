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


func calculatePositions(clickedPosition : Vector2, placementSize : Vector2) -> Dictionary:
	
	var placementTiles = {
		TOP_LEFT : [],
		TOP_RIGHT : [],
		BOTTOM_LEFT : [],
		BOTTOM_RIGHT : [],
		LEFT : [],
		RIGHT : [],
		TOP : [],
		BOTTOM : [],
		SURROUNDED : []
	}
	
	var difference = Vector2(
		floor(placementSize.x / 2), 
		floor(placementSize.y / 2)
	)
	var topLeftPosition = Vector2(
		clickedPosition.x - difference.x,
		clickedPosition.y - difference.y
	)
	
	var sizeX = placementSize.x - 1
	var sizeY = placementSize.y - 1
	
	for y in range(placementSize.y):
		for x in range(placementSize.x):
			var placementPosition = Vector2(
				x + topLeftPosition.x,
				y + topLeftPosition.y
			)
			if y == 0 && x == 0:
				placementTiles[TOP].append(placementPosition)
			elif y == 0 && x == sizeX:
				placementTiles[RIGHT].append(placementPosition)
			elif y == sizeY && x == 0:
				placementTiles[LEFT].append(placementPosition)
			elif y == sizeY && x == sizeX:
				placementTiles[BOTTOM].append(placementPosition)
			elif y == 0:
				placementTiles[TOP_RIGHT].append(placementPosition)
			elif x == 0:
				placementTiles[TOP_LEFT].append(placementPosition)
			elif y == sizeY:
				placementTiles[BOTTOM_LEFT].append(placementPosition)
			elif x == sizeX:
				placementTiles[BOTTOM_RIGHT].append(placementPosition)
			else:
				placementTiles[SURROUNDED].append(placementPosition)
				
	return placementTiles
