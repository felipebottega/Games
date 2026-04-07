extends Node2D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		modulate = Color(randf(), randf(), randf())
