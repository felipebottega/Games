extends RigidBody2D

var speed = 100

func _ready():
	$ShadowSprite2D.modulate = Color(0.1, 0.1, 0.1, 0.5)

func _process(delta):
	# Processa o movimento.
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		linear_velocity.x = speed
		linear_velocity.y = speed
		$AnimatedSprite2D.animation = "walk-down-right"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		linear_velocity.x = -speed
		linear_velocity.y = speed
		$AnimatedSprite2D.animation = "walk-down-right"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		linear_velocity.x = speed
		linear_velocity.y = -speed
		$AnimatedSprite2D.animation = "walk-up-right"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		linear_velocity.x = -speed
		linear_velocity.y = -speed
		$AnimatedSprite2D.animation = "walk-up-right"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_left"):
		linear_velocity.x = -speed
		linear_velocity.y = 0
		$AnimatedSprite2D.animation = "walk-right"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_right"):
		linear_velocity.x = speed
		linear_velocity.y = 0
		$AnimatedSprite2D.animation = "walk-right" 
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_up"):
		linear_velocity.x = 0
		linear_velocity.y = -speed
		$AnimatedSprite2D.animation = "walk-up" 
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_down"):
		linear_velocity.x = 0
		linear_velocity.y = speed
		$AnimatedSprite2D.animation = "walk-down" 
		$AnimatedSprite2D.play()
	else:
		linear_velocity.x = 0
		linear_velocity.y = 0
		$AnimatedSprite2D.animation = "idle-front" 
		$AnimatedSprite2D.stop()
