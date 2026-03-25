extends Node2D


@export var num_sheeps: int = 100

var last_sheep: CharacterBody2D
var waiting_last_sheep: bool = false
var wolves_captured: int = 0
var wolves_escaped: int = 0
var wolves_total: int = 0
var sheep: PackedScene = preload("res://scenes/characters/sheep.tscn")
var wolf: PackedScene = preload("res://scenes/characters/wolf.tscn")
var scores: PackedScene = preload("res://scenes/ui/scores.tscn")

func _ready() -> void:
	$SubViewport/AudioStreamPlayer.volume_db = GameState.volume - 10.0
	$SubViewport/AudioStreamPlayer2.volume_db = GameState.volume
	$SubViewport.size = Vector2(GameState.game_width, GameState.game_height)
	
	_make_day()
	
	# Animação da última fase.
	if GameState.level == 3:
		await _wolf_special_animation()
	
	for i in num_sheeps:
		# Cria a instância da ovelha.
		var instance = _create_sheep(i)
		
		# Cria o "espelho" da ovelha usando a mesma cena.
		_create_mirror_sheep(instance, i)
		
	print('=> ', [wolves_captured, wolves_escaped, wolves_total])
	
func _process(_delta: float) -> void:
	# A posição global do mouse tem que vir do node principal, pois o SubViewportContainer
	# não consegue captar inputs.
	$SubViewport/SubViewportContainer.mouse_global = get_global_mouse_position()
			
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_remove_red_sheep_in_view()
		$SubViewport/SubViewportContainer.modulate = Color(0, 0, 0)
		await get_tree().create_timer(0.1).timeout
		$SubViewport/SubViewportContainer.modulate = Color(1, 1, 1)
		
func _create_sheep(i):
	var instance = sheep.instantiate()
	instance.scale = Vector2(0.27, 0.27)
	instance.speed = 50.0 if (GameState.level == 1 or GameState.level == 2) else 100.0
	instance.speed_variance = 0.0 if GameState.level == 1 else 1.0 if GameState.level == 2 else 1.5
	
	if i % 3 == 0:
		instance.position = Vector2(2500 + 40*i, 600)
		instance.target = Vector2(920, -1000) if randf() > 0.5 else Vector2(1100, 2000)
	elif i % 3 == 1:
		instance.position = Vector2(-500 - 40*i, 200)
		instance.get_node("Node2D").scale.x = -1
		instance.target = Vector2(920, -1000)
	else:
		instance.position = Vector2(-500 - 40*i, 870)
		instance.get_node("Node2D").scale.x = -1
		instance.target = Vector2(1100, 2000)
		
	$SubViewport/Animals.add_child(instance)
	$SubViewport/Animals.move_child(instance, 0)    # as ovelhas aparecem atrás dos outrosa animais
		
	return instance
	
func _create_mirror_sheep(instance, i):
		var mirror = sheep.instantiate()
		mirror.scale = instance.scale
		
		# Desliga lógica do mirror (IMPORTANTE).
		mirror.set_process(false)
		mirror.set_physics_process(false)

		# Guarda referência manual.
		mirror.set_meta("target_node", instance)
		$SubViewport/SubViewportContainer/SubViewport.add_child(mirror)

		# Diferença visual.
		if randf() > 0.8 or i == num_sheeps - 1:
			mirror.modulate = Color(1, 0, 0)
			wolves_total += 1
			
			# Guarda a referência da última ovelha em uma variável.
			if  i == num_sheeps - 1:
				last_sheep = instance

func _remove_red_sheep_in_view():
	var cam = $SubViewport/SubViewportContainer/SubViewport/Camera2D
	var size = cam.get_viewport_rect().size * cam.zoom
	var rect = Rect2(cam.global_position - size * 0.5, size)

	for obj in get_tree().get_nodes_in_group("sheep"):
		if rect.has_point(obj.global_position):
			if obj.modulate.r > 0.8 and obj.modulate.g < 0.2:
				var wolf_pos = obj.global_position
				obj.queue_free()
				_running_wolf(wolf_pos)
				
func _running_wolf(wolf_pos):
	var instance = wolf.instantiate()
	instance.position = wolf_pos
	instance.scale = Vector2(0.3, 0.3)
	instance.get_node("AnimatedSprite2D").play("walk")
	instance.get_node("AudioStreamPlayer").call_deferred("play")
	$SubViewport/Animals.add_child(instance)
	wolves_captured += 1
	print([wolves_captured, wolves_escaped, wolves_total])
	
func _wolf_special_animation():
	var instance = wolf.instantiate()
	instance.scale = Vector2(0.3, 0.3)
	$SubViewport/Animals.add_child(instance)

	var anim = instance.get_node("AnimationPlayer")
	anim.play("special")
	await anim.animation_finished
	instance.queue_free()

func _show_scores():
	# Esconde o subviewport temporariamente.
	$SubViewport/SubViewportContainer.visible = false
	
	# Cria instância dos scores e botões.
	var instance = scores.instantiate()
	add_child(instance)
	await get_tree().process_frame
	instance.repeat.connect(_on_ui_repeat)
	instance.menu.connect(_on_ui_menu)
	instance.next.connect(_on_ui_next)

	# Escreve mensagens dos scores.
	wolves_escaped = wolves_total - wolves_captured
	instance.get_node("Label").text = "Capturados:\n"
	
	if wolves_captured < wolves_escaped:
		instance.get_node("Next").modulate.a = 0.3
	if GameState.level == 3:
		instance.get_node("Next").modulate.a = 0.0
	
	for i in wolves_captured:
		if i > 1 and i % 12 == 0:
			instance.get_node("Label").text += "\n"
		instance.get_node("Label").text += "🐺"
		play_sound("res://assets/audio/sfx/sfx100v2_footstep_wood_03.mp3")
		await get_tree().create_timer(0.1).timeout
		
	instance.get_node("Label").text += "\nForagidos:\n"
	
	for i in wolves_escaped:
		if i > 1 and i % 12 == 0:
			instance.get_node("Label").text += "\n"
		instance.get_node("Label").text += "🐺"
		play_sound("res://assets/audio/sfx/sfx100v2_footstep_wood_03.mp3")
		await get_tree().create_timer(0.1).timeout
		
	if GameState.level == 3:
		if wolves_captured < wolves_escaped:
			instance.get_node("AnimationPlayer").play("failed")
		else:
			instance.get_node("AnimationPlayer").play("approved")
		
func _on_ui_repeat():
	get_tree().change_scene_to_file("res://scenes/game/level.tscn")

func _on_ui_menu():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_ui_next():
	if $Scores/Next.modulate.a == 1.0:
		GameState.level += 1
		get_tree().change_scene_to_file("res://scenes/game/level.tscn")

func _make_night():
	$SubViewport/AnimationPlayer.speed_scale = 1
	$SubViewport/AnimationPlayer.play("night")
	await $SubViewport/AnimationPlayer.animation_finished
	$SubViewport/AudioStreamPlayer2.play()
	
func _make_day():
	$SubViewport/AnimationPlayer.play("night")
	$SubViewport/AnimationPlayer.seek(3, true)
	$SubViewport/AnimationPlayer.speed_scale = -1
	
func play_sound(path: String):
	var player = AudioStreamPlayer.new()
	player.stream = load(path)
	player.volume_db = -15.0
	
	add_child(player)
	player.play()
	
	await player.finished
	player.queue_free()

func _on_area_2d_body_entered(body) -> void:
	if body == last_sheep:
		waiting_last_sheep = true

func _on_area_2d_body_exited(body) -> void:
	if body == last_sheep and waiting_last_sheep:
		# Se o jogador capturou todos s lobos, pode encerrar mais rápido. Caso
		# Contrário, deixa ele tentar mais um pouco.
		if  wolves_total == wolves_captured:
			await get_tree().create_timer(5).timeout
		else:
			await get_tree().create_timer(15).timeout
			
		_show_scores()
		_make_night()
