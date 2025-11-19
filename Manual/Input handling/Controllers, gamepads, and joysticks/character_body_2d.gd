extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var strength  = Input.get_action_strength("accelerate")
	velocity = velocity * SPEED * strength 
	move_and_slide()
