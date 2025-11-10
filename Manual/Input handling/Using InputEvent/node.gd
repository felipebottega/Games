extends Node


func _input(event: InputEvent):
	# Detecta qualquer tecla pressionada.
	if event.is_pressed():
		print('Apertou a tecla')
	# Detecta qualquer tecla liberada.
	elif event.is_released():
		print('Soltou a tecla')
