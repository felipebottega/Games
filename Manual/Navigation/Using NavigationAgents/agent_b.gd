extends CharacterBody2D

var speed: float = 100.0

func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = $"../Target".global_position

func _physics_process(_delta):
	$NavigationAgent2D.target_position = $"../Target".global_position
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		
	var desired_velocity = current_agent_position.direction_to(next_path_position) * speed
	$NavigationAgent2D.velocity = desired_velocity    # ativa o sinal

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
