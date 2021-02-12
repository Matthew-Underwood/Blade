class_name SlopeTileAtlasResolver

func resolve(tileType : int) -> Vector2:
	var atlasPosition
	match tileType:
		DiamondPlacement.SURROUNDED:
			atlasPosition = Vector2.ZERO
		DiamondPlacement.TOP:
			atlasPosition = Vector2(0, 4)
		DiamondPlacement.TOP_LEFT:
			atlasPosition = Vector2(0, 1)
		DiamondPlacement.TOP_RIGHT:
			atlasPosition = Vector2(0, 1)
		DiamondPlacement.BOTTOM:
			atlasPosition = Vector2(0, 2)
		DiamondPlacement.BOTTOM_LEFT:
			atlasPosition = Vector2.ZERO
		DiamondPlacement.BOTTOM_RIGHT:
			atlasPosition = Vector2.ZERO
		DiamondPlacement.LEFT:
			atlasPosition = Vector2(0, 3)
		DiamondPlacement.RIGHT:
			atlasPosition = Vector2(0, 3)
	return atlasPosition
