extends Node2D


func _ready() -> void:
	var sprite2d = Sprite2D.new() 
	sprite2d.name = "SpriteNovo"
	add_child(sprite2d)
	
	print([Sprite2D, type_string(typeof(Sprite2D))])
	print()
	
	print([sprite2d, type_string(typeof(sprite2d))])
	print()
	
