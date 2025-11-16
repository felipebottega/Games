extends Node

func _input(event):
	print(event.as_text())
	
	if event.is_action_pressed("ui_left"):
		print("ui_left occurred!")
	elif event.is_action_released("ui_left"):
		print("ui_left released!")
		
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			print("T was pressed")
			
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			if event.shift_pressed:
				print("Shift+T was pressed")
			else:
				print("T was pressed")
				
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Left button was clicked at ", event.position)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			print("Wheel up")
