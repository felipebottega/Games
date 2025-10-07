extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1400.0
signal dead
var last_notnull_direction = 1

func _process(delta: float) -> void:
	# O escape volta para o menu imediatamente.
	if Input.is_action_just_pressed("cancel"):
		Manager.stop_player = true
		get_tree().change_scene_to_file("res://scenes/ui/menu.tscn") 

func _physics_process(delta: float) -> void:
	# Determina direção esquerda ou direita (-1 ou 1).
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		last_notnull_direction = direction
		
	# Gravidade e colisão.
	if not is_on_floor():
		if velocity.y < 0:    # subindo
			velocity += get_gravity() * delta
		else:    # caindo
			velocity += 4 * get_gravity() * delta
		$CollisionShape2D.scale = Vector2(0.2, 0.2)
	else:
		$CollisionShape2D.scale = Vector2(1.0, 1.0)

	# Movimentação.
	if Manager.stop_player:
		direction = 0.0
		velocity.x = 0.0
	else:
		if Input.is_action_just_pressed("accept") and is_on_floor():
			$JumpSound.play()
			$JumpSound.seek(0.1)  # pula o início do som
			velocity.y = JUMP_VELOCITY
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Quedas 
	if position.x > 650 and position.y > -750:
		if not $DeathSound.playing:
			$DeathSound.play()
			
		position.y = -750
		velocity.y = 0
		dead.emit()

	# Animação.
	if not is_on_floor():
		$AnimationTree.set("parameters/StateMachine/BlendSpace2D/blend_position", Vector2(last_notnull_direction, 1))
	else:
		if direction:
			$AnimationTree.set("parameters/StateMachine/BlendSpace2D/blend_position", Vector2(direction, 0))
		else:
			$AnimationTree.set("parameters/StateMachine/BlendSpace2D/blend_position", Vector2(last_notnull_direction/10, 0))

	move_and_slide()
