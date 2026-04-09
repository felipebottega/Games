extends CharacterBody2D


@export var speed = 50
@export var jump_velocity = -100


func _ready():
	pass

func _physics_process(delta):
	# Gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Movimento lateral
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$AnimatedSprite2D.animation = "walk" 
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
	else:
		velocity.x = 0
		$AnimatedSprite2D.animation = "idle" 
		$AnimatedSprite2D.stop()

	# Pulo (impulso vertical)
	if Input.is_action_just_pressed("ui_select") and abs(velocity.y) < 1:
		velocity.y = jump_velocity

	move_and_slide()
