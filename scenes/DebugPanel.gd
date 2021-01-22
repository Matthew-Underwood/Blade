extends Control

var _tileMapLayers
var _guiWorldXValue
var _guiWorldYValue
var _guiLocalXValue
var _guiLocalYValue
var _map : Map
var _sectionNodes = []
var _tileIdNodes = []
var _tileFlipXNodes = []
var _tileFlipYNodes = []

func _ready():
	var worldCoordinates = get_node("Container/WorldCoordinates")
	var localCoordinates = get_node("Container/LocalCoordinates")
	var layers = get_node("Container/HBoxContainer/LayerData/Layers")
	var tileLayers = get_node("Container/HBoxContainer/TileData/Layers")
	
	_guiWorldXValue = worldCoordinates.get_node("XValue")
	_guiWorldYValue = worldCoordinates.get_node("YValue")
	_guiLocalXValue = localCoordinates.get_node("XValue")
	_guiLocalYValue = localCoordinates.get_node("YValue")
	for layer in range(1, 5):
		var sectionNode = layers.get_node("SectionsContainer"+str(layer)+"/SectionsData")
		var tileIdNode = tileLayers.get_node("TileIdContainer"+str(layer)+"/TileIdData")
		var tileFlipNodeX = tileLayers.get_node("TileFlipContainer"+str(layer)+"/TileFlipData/XFlipData/Value")
		var tileFlipNodeY = tileLayers.get_node("TileFlipContainer"+str(layer)+"/TileFlipData/YFlipData/Value")
		_sectionNodes.append(sectionNode)
		_tileIdNodes.append(tileIdNode)
		_tileFlipXNodes.append(tileFlipNodeX)
		_tileFlipYNodes.append(tileFlipNodeY)
	
func setMap(map : Map):
	_map = map

func setTileMapLayers(tileMapLayers : Array):
	_tileMapLayers = tileMapLayers
	
func _process(delta):
	
	var size = _map.getSize()
	var worldCoordinates = _tileMapLayers[0].world_to_map(
			get_viewport().get_mouse_position()
		)
	var localCoordinates = worldCoordinates - _map.getWorldOrigin()
	_guiWorldXValue.text = str(worldCoordinates.x)
	_guiWorldYValue.text = str(worldCoordinates.y)
	_guiLocalXValue.text = str(localCoordinates.x)
	_guiLocalYValue.text = str(localCoordinates.y)
	
	if (localCoordinates.x >= 0 && localCoordinates.x <= (size.x - 1) &&
		localCoordinates.y >= 0 && localCoordinates.y <= (size.y - 1)):
			
		removeChildren(_sectionNodes)
		removeChildren(_tileIdNodes)
		removeLabelValue(_tileFlipXNodes)
		removeLabelValue(_tileFlipYNodes)
			
		# sections per cell
		var layer = _map.getDataFromPos(worldCoordinates).getHeight(0)
		var sectionLayerNum = 0
		var tileMapLayerNum = 0
		for tile in layer.getTerrianTiles():
			for section in tile.getSections():
				addLabelToNode(_sectionNodes[sectionLayerNum], section)
			sectionLayerNum += 1
			
		for tileMapLayer in _tileMapLayers:
			var tileId = tileMapLayer.get_cellv(worldCoordinates)
			addLabelToNode(_tileIdNodes[tileMapLayerNum], tileId)
			setLabelValue(
				_tileFlipXNodes[tileMapLayerNum],
				 tileMapLayer.is_cell_x_flipped(worldCoordinates.x, worldCoordinates.y)
			)
			setLabelValue(
				_tileFlipYNodes[tileMapLayerNum],
				 tileMapLayer.is_cell_y_flipped(worldCoordinates.x, worldCoordinates.y)
			)
			tileMapLayerNum += 1

func removeChildren(nodes : Array):
	for node in nodes:
		var nodeChildren = node.get_children()
		if nodeChildren.empty() == false:
			for nodeChild in nodeChildren:
				node.remove_child(nodeChild)

func removeLabelValue(nodes : Array):
	for node in nodes:
		node.text = ""

func setLabelValue(node : Node, value):
	node.text = str(value)

func addLabelToNode(node : Node, value):
	var label = Label.new()
	label.text = str(value)
	node.add_child(label)
	
