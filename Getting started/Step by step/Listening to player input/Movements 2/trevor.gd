extends RigidBody2D

var speed = 200
var jump_velocity = -400

func _ready():
	print("Iniciando...")

func _physics_process(_delta):
	# Movimento lateral
	if Input.is_action_pressed("walk_left"):
		linear_velocity.x = -speed
	elif Input.is_action_pressed("walk_right"):
		linear_velocity.x = speed
	else:
		linear_velocity.x = 0

	# Pulo (impulso vertical)
	if Input.is_action_just_pressed("jump") and abs(linear_velocity.y) < 30:
		linear_velocity.y = jump_velocity
