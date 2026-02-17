extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:
	# Gravidade.
	velocity += get_gravity() * delta
	
	# Salto.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Direção esquerda ou direita do input, caso tenha sido pressionado.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Lidando com chão inclinado.
	if is_on_floor() and get_floor_normal() != Vector2(0, -1):
		# Subindo o chão inclinado.
		if get_position_delta().y < 0:
			if direction:
				velocity.x = direction * SPEED
		# Descendo o chão inclinado. 
		else:
			# Só considera input quando é para subir de volta.
			if direction and direction * get_position_delta().x < 0:
				velocity.x = direction * SPEED
		velocity.x += get_floor_normal().x * 50
	# Caminhada normal.
	elif direction:
		velocity.x = direction * SPEED
	# Parando a caminhada.
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Aplicando o movimento,
	move_and_slide()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
