extends Node

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		print('Mouse se movendo: _unhandled_input')
			
		# Se quiser 'consumir' o evento, isto é, não deixar ele propagar para as camadas seguintes.
		#get_viewport().set_input_as_handled()
