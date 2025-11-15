extends Node

func _input(event: InputEvent):
	# Detecta eixos do analógico do joystick.
	if event is InputEventJoypadMotion:
		print(event.axis_value)
