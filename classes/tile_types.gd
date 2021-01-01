class_name TileTypes

const FLAT = 0
const TOP = 1
const BOTTOM = 2
const LEFT = 3
const RIGHT = 4
const TOP_LEFT = 5
const BOTTOM_LEFT = 6
const TOP_RIGHT = 7
const BOTTOM_RIGHT = 8
#const L_TOP_RIGHT = 9
#const L_TOP_LEFT = 10
#const L_BOTTOM_RIGHT = 11
#const L_BOTTOM_LEFT = 12

func tileTypeToAtlas(type : int) -> Vector2:
	var atlasPosition
	match type:
		FLAT:
			atlasPosition = Vector2(0, 0)
		TOP_LEFT:
			atlasPosition = Vector2(0, 1)
		TOP:
			atlasPosition = Vector2(0, 2)
		RIGHT:
			atlasPosition = Vector2(0, 3)
	return atlasPosition
	
