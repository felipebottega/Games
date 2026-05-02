extends CharacterBody2D

var speed = 400
var rotation_speed = 5
var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = get_global_transform().x * Input.get_axis("ui_down", "ui_up") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
