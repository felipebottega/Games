extends Node2D

func _on_button_pressed(button_id: int) -> void:
	for i in range(1, 6):
		var img = get_node("SubViewportContainer/SubViewport/Img%d" % i)
		
		if i == button_id:
			img.visible = true
		else:
			img.visible = false
			
