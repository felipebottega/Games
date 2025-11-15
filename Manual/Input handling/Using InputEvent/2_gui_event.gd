extends Button

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			text = 'Mouse clicado'
		elif not event.pressed:
			text = 'Clique do mouse liberado'

		# Se quiser 'consumir' o evento, isto é, não deixar ele propagar para as camadas seguintes.
		#get_viewport().set_input_as_handled()
