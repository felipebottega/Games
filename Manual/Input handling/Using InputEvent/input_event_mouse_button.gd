extends Node

func _input(event: InputEvent):
	# Detecta clique do mouse.
	if event is InputEventMouseButton and event.pressed:
		print('Mouse clicado')
	# Detecta quando liberou o clique do mouse.
	elif event is InputEventMouseButton and not event.pressed:
		print('Clique do mouse liberado')
