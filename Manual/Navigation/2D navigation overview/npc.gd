extends CharacterBody2D

var speed: float = 100.0

func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = $"../Target".position

func _physics_process(_delta):
	$NavigationAgent2D.target_position = $"../Target".position
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()
