extends Node

func _input(event: InputEvent):
	# Detecta botão do joystick pressionado.
	if event is InputEventJoypadButton and event.pressed:
		print('Botão pressionado')
	# Detecta botão do joystick liberado.
	elif event is InputEventJoypadButton and not event.pressed:
		print('Botão liberado')
