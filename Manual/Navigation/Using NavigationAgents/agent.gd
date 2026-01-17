extends CharacterBody2D


var speed: float = 0.0


func _ready():
	await get_tree().process_frame
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	
	if global_position.x < 100:
		$NavigationAgent2D.target_position = Vector2(1000, global_position.y)
		modulate = Color(0.1, 0.1, 0.6, 1)
		$NavigationAgent2D.debug_path_custom_color = Color(0.2, 0.2, 0.5, 1)
	else:
		$NavigationAgent2D.target_position = Vector2(150, global_position.y)

func _physics_process(_delta):
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		
	var desired_velocity = current_agent_position.direction_to(next_path_position) * speed
	$NavigationAgent2D.velocity = desired_velocity    # ativa o sinal

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
