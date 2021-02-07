class_name TileFactory
	
var _tile
var _sectionsResolver : TileSectionsResolver
var _atlasResolver : AtlasResolver


func _init(
	sectionsResolver : TileSectionsResolver,
	atlasResolver : AtlasResolver
):
	_tile = load("res://classes/tile/tile.gd")
	_sectionsResolver = sectionsResolver
	_atlasResolver = atlasResolver
	
func create(
	tileType : int,
	tileId : int,
	position : Vector2,
	flip : Vector2
) -> Tile:
	var atlasId = _atlasResolver.resolve(tileType)
	var tile = _tile.new(
		tileType,
		atlasId,
		tileId,
		_sectionsResolver.resolve(tileType),
		position,
		flip
	)
	return tile
