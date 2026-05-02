extends CharacterBody2D

var speed = 400

func get_input():
	look_at(get_global_mouse_position())
	velocity = get_global_transform().x * Input.get_axis("ui_down", "ui_up") * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
