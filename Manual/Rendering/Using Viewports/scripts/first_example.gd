extends Node2D


func _on_capture_button_pressed() -> void:
	# Retrieve the captured Image using get_image().
	var img = $SubViewport.get_viewport().get_texture().get_image()
	
	# Convert Image to ImageTexture.
	var tex = ImageTexture.create_from_image(img)
	
	# Set sprite texture.
	$CaptureButton/Capture.texture = tex
