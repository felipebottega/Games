extends CharacterBody2D


var speed_variance: float = 0.0
var speed: float = 50.0
var target: Vector2
var traversing: bool = false
var link_entry: Vector2 = Vector2.ZERO
var link_exit: Vector2 = Vector2.ZERO


func _ready():
	# Modo "espelho" (sem lógica).
	if has_meta("target_node"):
		var original = get_meta("target_node")

		# Entra no grupo.
		add_to_group("sheep")

		# Remoção bidirecional.
		if original:
			original.tree_exited.connect(queue_free)
			tree_exited.connect(original.queue_free)

		set_physics_process(false)
		return

	# Lógica normal.
	add_to_group("sheep")
	speed = (speed_variance * randf() + 1) * speed
	$NavigationAgent2D.target_position = target
	await get_tree().create_timer(300.0).timeout
	queue_free()
	
func _process(_delta):
	# Espelho: copia o original.
	if has_meta("target_node"):
		var target_node = get_meta("target_node")
		if target_node == null:
			queue_free()
			return

		# Posição.
		global_position = target_node.global_position

		# Direção (flip).
		var original_visual = target_node.get_node("Node2D")
		var my_visual = $Node2D
		my_visual.scale.x = sign(original_visual.scale.x)

		# Animação.
		if has_node("AnimatedSprite2D") and target_node.has_node("AnimatedSprite2D"):
			var a = target_node.get_node("AnimatedSprite2D")
			var b = $AnimatedSprite2D
			b.animation = a.animation
			b.frame = a.frame

		return

func _physics_process(delta):
	# Espelho não usa física.
	if has_meta("target_node"):
		return
		
	# Travessia pelo link.
	if traversing:
		var to_exit = link_exit - global_position
		
		# Chegou ao fim do link.
		if to_exit.length() <= speed * delta:
			traversing = false
		# Está se movendo pelo caminho do link.
		else:
			var dir = to_exit.normalized()
			velocity = dir * delta
			move_and_slide()
		
		return
		
	# Travessia normal pelo caminho.
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
	var desired_velocity = current_agent_position.direction_to(next_path_position) * speed
	$NavigationAgent2D.velocity = desired_velocity

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()

func _on_navigation_agent_2d_link_reached(details: Dictionary) -> void:
	# Obter posições de entrada/saída do link.
	link_entry = details.get("link_entry_position", details.get("position", global_position))
	link_exit  = details.get("link_exit_position",  details.get("position", global_position))
	
	# Atualizar variável de estado do agente.
	traversing = true
