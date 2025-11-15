extends Node

func _input(event: InputEvent):
	# Detecta qualquer input pressionado.
	if event.is_pressed():
		print('Input pressionado')
	# Detecta qualquer input liberado.
	elif event.is_released():
		print('Input liberado')
