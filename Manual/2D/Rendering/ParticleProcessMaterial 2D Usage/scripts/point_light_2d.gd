extends PointLight2D

func _process(delta: float) -> void:
	# Varia a escala da textura.
	texture_scale = texture_scale * randf_range(0.99, 1.01)
	if texture_scale > 2:
		texture_scale = texture_scale * 0.99
	elif texture_scale < 1.2:
		texture_scale = texture_scale * 1.01

	# Varia a posição levemente em torno do ponto original
	position = position + Vector2(randf_range(-0.2, 0.2), randf_range(-0.2, 0.2))
	if position.length() > 5:
		position = position * 0.99
