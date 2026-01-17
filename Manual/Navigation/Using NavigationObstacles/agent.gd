extends CharacterBody2D


var speed: float = 100.0
var dragging = false
var drag_offset = Vector2.ZERO


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
	
func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = global_position - event.position
		else:
			dragging = false
