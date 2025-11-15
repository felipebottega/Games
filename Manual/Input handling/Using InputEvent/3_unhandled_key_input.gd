extends Node

func _unhandled_key_input(event: InputEvent):
	if event is InputEventKey: 
		if event.pressed:
			print('Tecla pressionada: _unhandled_key_input')
		elif not event.pressed:
			print('Tecla liberada: _unhandled_key_input')
		
		# Se quiser 'consumir' o evento, isto é, não deixar ele propagar para as camadas seguintes.
		#get_viewport().set_input_as_handled()
