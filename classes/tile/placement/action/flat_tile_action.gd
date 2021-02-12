class_name FlatTileAction

func process(data : Height, tile : Tile, originData : Height) -> Height:
	
	var layer = data.getHeight(0)
	layer.updateTerrianTiles(tile)
	return data
