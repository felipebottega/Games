extends CharacterBody2D


@export var speed = 100
@export var jump_velocity = -400

@export var stats: Stats


func _ready():
	print("My health = ", stats.health)
	print("My strings = ", stats.strings)
	
	var sprite = Sprite2D.new()
	sprite.texture = stats.sub_resource
	sprite.position = Vector2(0, -30)
	sprite.scale = Vector2(0.1, 0.1)
	add_child(sprite)
	
	var subresource = load("res://sprites/medusa.png") 
	var stats2 = Stats.new(15, subresource, ["a", "b", "c"])
	print()
	print("My health (2) = ", stats2.health)
	print("My sub_resource (2) = ", stats2.sub_resource)
	print("My strings (2) = ", stats2.strings)

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
