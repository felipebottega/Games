extends Node

func _input(event: InputEvent):
	# Detecta tecla pressionada.
	if event is InputEventKey and event.pressed:
		print('Tecla pressionada')
	# Detecta tecla liberada.
	elif event is InputEventKey and not event.pressed:
		print('Tecla liberada')
