extends Node

var tilePicker : TilePicker
var tileMap : TileMap

func _ready():
	var tp = load("res://classes/tile_picker.gd")
	tilePicker = tp.new()
	tileMap = get_node("Terrian/Layer1")

func _process(delta):
	var tilePosition = tileMap.world_to_map(get_viewport().get_mouse_position())
	if Input.is_action_pressed("test_click"):
		var tiles = tilePicker.get_tiles(tilePosition,Vector2.ONE)
		for tile in tiles:
			tileMap.set_cell(tile.x,tile.y,0)	
