class_name TileSectionsResolver

func resolve(tileType : int) -> Array:
	var tileSections = []
	match tileType:
		TileTypes.FLAT:
			tileSections = [
				TileSections.TOP,
				TileSections.BOTTOM,
				TileSections.LEFT,
				TileSections.RIGHT
				]
		TileTypes.TOP:
			tileSections = [TileSections.BOTTOM]
		TileTypes.BOTTOM:
			tileSections = [TileSections.TOP]
		TileTypes.LEFT:
			tileSections = [TileSections.RIGHT]
		TileTypes.RIGHT:
			tileSections = [TileSections.LEFT]
		TileTypes.TOP_LEFT:
			tileSections = [TileSections.BOTTOM, TileSections.RIGHT]
		TileTypes.TOP_RIGHT:
			tileSections = [TileSections.BOTTOM, TileSections.LEFT]
		TileTypes.BOTTOM_LEFT:
			tileSections = [TileSections.TOP, TileSections.RIGHT]
		TileTypes.BOTTOM_RIGHT:
			tileSections = [TileSections.TOP, TileSections.LEFT]
	return tileSections
