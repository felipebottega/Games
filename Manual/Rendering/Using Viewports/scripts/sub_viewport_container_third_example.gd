extends SubViewportContainer


func _process(_delta: float) -> void:
	var mouse_global : Vector2 = get_global_mouse_position()

	# Mover o visor.
	global_position = mouse_global - $SubViewport.size * 0.5

	# Mover a câmera.
	$SubViewport/Camera2D.global_position = mouse_global
