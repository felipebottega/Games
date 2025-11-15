extends Node

func _input(event: InputEvent):
	# Mostra a posição do ponteiro na tela quando o mouse o move.
	if event is InputEventMouseMotion:
		print(event.position)
