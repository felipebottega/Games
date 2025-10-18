extends Node2D

var fadeout = false
var fadein = false
var color = 0
var credits = false
var alive = false

func _ready() -> void:
	modulate = Color(0, 0, 0, 1)
	_on_player_dead()
	_player_position_after_death()
	Manager.close_to_npc = max(0, Manager.state - 1)
	pass

func _process(_delta: float) -> void:
	# Verifica se o jogador está próximo de algum NPC.
	if $Player.global_position.distance_to($NPC.global_position) < 200:
		Manager.close_to_npc = 1
	elif $Player.global_position.distance_to($NPC2.global_position) < 130:
		Manager.close_to_npc = 2
	elif $Player.global_position.distance_to($NPC3.global_position) < 130:
		Manager.close_to_npc = 3
	else:
		Manager.close_to_npc = 0
		
func _physics_process(delta: float) -> void:
	# Efeito fadeout fadein.
	if fadeout:
		color = color - delta
		if color > 0:
			modulate = Color(color, color, color, 1)
		else:
			modulate = Color(0, 0, 0, 1)
			fadein = true
			fadeout = false
			
	if fadein:
		color = color + delta
		_player_position_after_death()
		if color < 1:
			modulate = Color(color, color, color, 1)
		else:
			modulate = Color(1, 1, 1, 1)
			fadein = false
			fadeout = false
			
	# Verifica se o jogador tocou no cálice.
	if $Player.global_position.distance_to(Vector2(6508, -12384)) < 30 and not credits:
		$WinSound.play()
		credits = true
		Manager.state = 4
		win()
			
func _on_sky_area() -> void:
	$Player.velocity.y = -2800 

func _on_player_dead() -> void:
	fadeout = true
	alive = false
	
func _player_position_after_death():
	if not alive:
		if Manager.state <= 1:
			$Player.position = Vector2(180, 500)
		elif Manager.state == 2:
			$Player.position = Vector2(2360, -4730)
		elif Manager.state >= 3:
			$Player.position = Vector2(8300, -6986)
		alive = true
		
func win():
	$Player.set_physics_process(false) 
	$Player/AnimationTree.active = false 
	$CreditsAnimation.play("credits")
