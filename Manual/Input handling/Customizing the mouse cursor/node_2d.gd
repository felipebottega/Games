extends Node2D

var count = 0
var cursor = load("res://cursor.png")
var cursor2 = load("res://cursor2.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if count % 2 == 0:
			Input.set_custom_mouse_cursor(cursor2)
		else:
			Input.set_custom_mouse_cursor(cursor)
		count += 1
