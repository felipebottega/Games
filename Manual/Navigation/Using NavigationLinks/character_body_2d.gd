extends CharacterBody2D


var speed: float = 500.0
var traversing: bool = false
var link_entry: Vector2 = Vector2.ZERO
var link_exit: Vector2 = Vector2.ZERO


func _ready():
	$NavigationAgent2D.path_desired_distance = 1
	$NavigationAgent2D.target_desired_distance = 0.1
	$NavigationAgent2D.target_position = $"../Target".position

func _physics_process(delta):
	$NavigationAgent2D.target_position = $"../Target".position
	
	# Travessia pelo link.
	if traversing:
		var to_exit = link_exit - global_position
		
		# Chegou ao fim do link.
		if to_exit.length() <= speed * delta:
			traversing = false
		# Está se movendo pelo caminho do link.
		else:
			var dir = to_exit.normalized()
			velocity = dir * speed
			move_and_slide()
		
		return
	
	# Travessia normal pelo caminho.
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()

func _on_navigation_agent_2d_link_reached(details: Dictionary) -> void:
	print('chegou')
	# Obter posições de entrada/saída do link.
	link_entry = details.get("link_entry_position", details.get("position", global_position))
	link_exit  = details.get("link_exit_position",  details.get("position", global_position))
	
	# Atualizar variável de estado do agente.
	traversing = true
