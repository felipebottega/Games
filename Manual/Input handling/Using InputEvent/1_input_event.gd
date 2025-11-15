extends Node

func _input(event: InputEvent):
	if event is InputEvent:
		if event.is_pressed():
			print("Pressionou algum input")
			
		# Se quiser 'consumir' o evento, isto é, não deixar ele propagar para as camadas seguintes.
		#get_viewport().set_input_as_handled()
