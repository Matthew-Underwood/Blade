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

func calculate(clickedPosition : Vector2, placementSize : Vector2):
	var positions = []
	var difference = Vector2(
		floor(placementSize.x / 2), 
		floor(placementSize.x / 2)
	)
	var topLeftPosition = clickedPosition - difference
	
	for y in range(1, placementSize.y + 1):
		for x in range(1, placementSize.x + 1):
			var placementPosition = Vector2.ZERO
			placementPosition.x = x * topLeftPosition.x
			placementPosition.y = y * topLeftPosition.y
			positions.append(placementPosition)
