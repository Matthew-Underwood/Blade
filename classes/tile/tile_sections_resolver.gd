class_name TileSectionsResolver

func resolve(tileType : int) -> Array:
	var tileSections = []
	match tileType:
		DiamondPlacement.SURROUNDED:
			tileSections = [
				TileSections.TOP,
				TileSections.BOTTOM,
				TileSections.LEFT,
				TileSections.RIGHT
				]
		DiamondPlacement.TOP:
			tileSections = [TileSections.BOTTOM]
		DiamondPlacement.BOTTOM:
			tileSections = [TileSections.TOP]
		DiamondPlacement.LEFT:
			tileSections = [TileSections.RIGHT]
		DiamondPlacement.RIGHT:
			tileSections = [TileSections.LEFT]
		DiamondPlacement.TOP_LEFT:
			tileSections = [TileSections.BOTTOM, TileSections.RIGHT]
		DiamondPlacement.TOP_RIGHT:
			tileSections = [TileSections.BOTTOM, TileSections.LEFT]
		DiamondPlacement.BOTTOM_LEFT:
			tileSections = [TileSections.TOP, TileSections.RIGHT]
		DiamondPlacement.BOTTOM_RIGHT:
			tileSections = [TileSections.TOP, TileSections.LEFT]
	return tileSections
