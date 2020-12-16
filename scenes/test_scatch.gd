extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var data = [0,1,2,3,4]
	for item in range(5):
		if item % 2 == 0:
			data.erase(item)
	
