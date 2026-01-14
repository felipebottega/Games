extends CharacterBody2D

var speed: float = 20.0
var count = 0
var path = [Vector2.ZERO, Vector2.ZERO]

func _ready():
	#$NavigationAgent2D.path_desired_distance = 4.0
	#$NavigationAgent2D.target_desired_distance = 4.0
	#$NavigationAgent2D.target_position = $"../Target".global_position
	#$NavigationAgent2D.velocity_computed.connect(_on_velocity_computed)
	pass

func _physics_process(delta):
	#$NavigationAgent2D.target_position = $"../Target".global_position
	
	var current_agent_position: Vector2 = global_position
	#var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
	
	#velocity = current_agent_position.direction_to(next_path_position) * speed
	
	#var desired_velocity = current_agent_position.direction_to(next_path_position) * speed
	#$NavigationAgent2D.set_velocity(desired_velocity)
	
	#move_and_slide()
	
func _on_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	#move_and_slide()
