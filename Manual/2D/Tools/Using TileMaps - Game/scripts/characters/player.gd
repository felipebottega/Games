extends CharacterBody2D

const SPEED = 1000.0
const JUMP_VELOCITY = -2800.0
var wind = 0

func _physics_process(delta):
	# ======= MOVIMENTOS =======
	
	# Add the gravity.
	if not is_on_floor():
		velocity += 10 * get_gravity() * delta
		$AudioSteps.stop()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AudioJump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED + wind
		$AnimatedSprite2D.flip_h = direction < 0
		if not $AudioSteps.playing:
			$AudioSteps.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) + wind

	move_and_slide()
	
	# ======= ANIMAÇÕES =======
	
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif direction != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		
	# ===== CAIU NO BURACO =====
	var viewport_rect = get_viewport().get_visible_rect()

	if position.y > viewport_rect.size.y:
		# Volta para o topo, horizontalmente centralizado.
		position = Vector2(viewport_rect.size.x / 2, 0)
	
