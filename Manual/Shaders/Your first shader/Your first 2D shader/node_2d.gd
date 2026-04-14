@tool
extends Node2D


var blue_value: float = 1.0


func _process(delta: float) -> void:
	blue_value += delta
	$Sprite2D.material.set_shader_parameter("blue", abs(cos(blue_value)))
