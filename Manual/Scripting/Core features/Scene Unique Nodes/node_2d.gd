extends Node2D


func _ready() -> void:
	var label = $CanvasLayer/%Label # unique name
	
	label.text = "123456789!"
