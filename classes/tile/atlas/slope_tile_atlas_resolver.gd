class_name SlopeTileAtlasResolver extends AtlasResolver

func resolve(tileType : int) -> Vector2:
	var atlasPosition
	match tileType:
		DiamondPlacement.SURROUNDED:
			atlasPosition = Vector2.ZERO
		DiamondPlacement.TOP_LEFT:
			atlasPosition = Vector2(0, 1)
		DiamondPlacement.TOP:
			atlasPosition = Vector2(0, 2)
		DiamondPlacement.RIGHT:
			atlasPosition = Vector2(0, 3)
	return atlasPosition
