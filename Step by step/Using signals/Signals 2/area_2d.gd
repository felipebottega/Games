extends Area2D

@export var force: Vector2 = Vector2(0, -100000)

func _ready() -> void:
	if name == "Impulse 3":
		set_physics_process(true)
		$Timer.timeout.connect(_on_timer_timeout)
	else:
		set_physics_process(false)
		$"../../Left Button".modulate = Color.RED
		$"../../Right Button".modulate = Color.RED

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body is RigidBody2D:
			body.apply_force(force * delta)

func _on_left_button_pressed() -> void:
	set_physics_process(not is_physics_processing())
	
	if is_physics_processing():
		$"../../Left Button".modulate = Color.GREEN
	else:
		$"../../Left Button".modulate = Color.RED

func _on_right_button_pressed() -> void:
	set_physics_process(not is_physics_processing())
	
	if is_physics_processing():
		$"../../Right Button".modulate = Color.GREEN
	else:
		$"../../Right Button".modulate = Color.RED
		
func _on_timer_timeout():
	$CollisionShape2D.disabled = not $CollisionShape2D.disabled
