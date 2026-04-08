extends Sprite2D


signal shoot(rock, direction, location)
var rock = preload("res://rock.tscn")


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot.emit(rock, rotation, position)
	elif event is InputEventKey:
		var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		position += 10 * input_direction

func _process(_delta):
	look_at(get_global_mouse_position())
