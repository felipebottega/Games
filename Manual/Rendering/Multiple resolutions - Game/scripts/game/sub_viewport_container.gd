extends SubViewportContainer


var mouse_global : Vector2 = Vector2(0.0, 0.0)


func _process(_delta: float) -> void:
	# Mover o visor.
	global_position = mouse_global - $SubViewport.size * 0.5

	# Mover a câmera.
	$SubViewport/Camera2D.global_position = mouse_global
