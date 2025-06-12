extends RigidBody2D

@export var speed = 200
@export var jump_velocity = -400
var screen_size
var is_hurt = false

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(_delta):
	# Se não fizer isso, a animação do hurt será cancelada por uma das 3 abaixo.
	if is_hurt:
		return 
		
	# Movimento lateral
	if Input.is_action_pressed("ui_left"):
		linear_velocity.x = -speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("ui_right"):
		linear_velocity.x = speed
		$AnimatedSprite2D.animation = "walk" 
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
	else:
		linear_velocity.x = 0
		$AnimatedSprite2D.animation = "idle" 
		$AnimatedSprite2D.stop()

	# Pulo (impulso vertical)
	if Input.is_action_just_pressed("ui_select") and abs(linear_velocity.y) < 1:
		linear_velocity.y = jump_velocity

func _on_body_entered(body):
	if body.is_in_group("inimigo"):
		is_hurt = true
		linear_velocity.y = -500
		if position.x < $"../Medusa".position.x:
			linear_velocity.x = -200
		else:
			linear_velocity.x = 200
		$AnimatedSprite2D.animation = "hurt" 
		$AnimatedSprite2D.play()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "hurt":
		is_hurt = false
