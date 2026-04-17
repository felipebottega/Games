extends Node2D

var t = PI/2

@onready var container = $SubViewportContainer


func _process(delta: float) -> void:
	t += delta/8.0
	container.scale = Vector2(abs(sin(t)), abs(sin(t)))
