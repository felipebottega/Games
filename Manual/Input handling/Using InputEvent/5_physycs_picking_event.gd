extends RigidBody2D

func _ready():
	input_pickable = true  # garante que o clique é registrado no picking

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print('Clicou para aplicar força: _input_event')
		
		# Posição do clique no mundo
		var click_global = event.global_position

		# Vetor direção do corpo até o clique
		var direction = (click_global - global_position).normalized()

		# Intensidade da força
		var force = 700.0  # ajuste conforme necessário

		# Aplicar força na direção contrária ao clique
		apply_impulse(-direction * force)
