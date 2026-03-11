extends Node2D


var width = 1.0
var height = 1.0
var subv_size


func _ready():
	$Sprite2D2.texture = $SubViewport.get_texture()
	subv_size = $SubViewport.size

func _process(delta: float) -> void:
	$SubViewport.set_size_2d_override(Vector2i(width * subv_size.x, height * subv_size.y)) # Custom size for 2D.
	#$SubViewport.set_size_2d_override_stretch(true) # Enable stretch for custom size.

	width += delta
	height += delta
	print([$SubViewport.size, width, height])
