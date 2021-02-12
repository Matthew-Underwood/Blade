class_name Layers

var _terrianTiles : Array
var _overlayTile : Tile

func _init(terrianTiles : Array, overlayTile : Tile):
	_terrianTiles = terrianTiles
	_overlayTile = overlayTile

func updateTerrianTiles(tile : Tile):
	var sections = tile.getSections().duplicate(true)
	var tiles = _terrianTiles.size()
	while tiles > 0:
		tiles -= 1
		var storedTile = _terrianTiles[tiles]
		var diff = sectionsDiff(
			storedTile.getSections(),
			sections
		)
		if diff.empty() == true:
			_terrianTiles.erase(storedTile)
		else:
			sections = sections + diff
	_terrianTiles.push_back(tile)
	
func sectionsDiff(
		sectionsToCheck : Array,
		sectionsCompareAgasint : Array
	) -> Array:
	var diff = []
	
	for sectionToCheck in sectionsToCheck:
		if (sectionToCheck in sectionsCompareAgasint) == false:
			diff.append(sectionToCheck)
	return diff

func getTerrianTiles() -> Array:
	return _terrianTiles
	
func getTerrianTilesCount() -> int:
	return _terrianTiles.size()
	
func hasTerrianTiles() -> bool:
	return !_terrianTiles.empty()
	
func getOverlayTile() -> Tile:
	return _overlayTile
