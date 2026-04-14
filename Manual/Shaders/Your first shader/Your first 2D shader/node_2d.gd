@tool
extends Node2D


var t := 0.0
var blue_value = 1.0

@onready var sprite1 := $Sprite2D
@onready var sprite2 := $Sprite2D2

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	t += delta
	#sprite1.material.set_shader_parameter("blue", abs(sin(t)))
	sprite1.material.set_shader_parameter("aa", abs(sin(t)))
	sprite2.material.set_shader_parameter("aa", abs(cos(t)))
	sprite1.material.set_shader_parameter("bb", sin(t))
	sprite2.material.set_shader_parameter("bb", cos(t))
