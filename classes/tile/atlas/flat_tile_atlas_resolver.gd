class_name FlatTileAtlasResolver extends AtlasResolver

func resolve(tileType : int) -> Vector2:
	var atlasPosition
	match tileType:
		TileTypes.FLAT:
			atlasPosition = Vector2(0, 0)
		TileTypes.TOP_LEFT:
			atlasPosition = Vector2(0, 1)
		TileTypes.TOP:
			atlasPosition = Vector2(0, 2)
		TileTypes.RIGHT:
			atlasPosition = Vector2(0, 3)
	return atlasPosition
