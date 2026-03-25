extends Node2D


var t: float = 0.0
var fading: bool = false
var fade_speed: float = 2.0


func _ready() -> void:
	$SubViewport.size = Vector2(GameState.game_width, GameState.game_height)

func _input(event):
	if event is InputEventMouseButton and event.pressed and not fading:
		fading = true

func _process(delta):
	# Fadeout da tela quando o jogador clica para começar o jogo.
	if fading:
		modulate.r -= fade_speed * delta
		modulate.g -= fade_speed * delta
		modulate.b -= fade_speed * delta
		
		if modulate.r <= 0.0:
			get_tree().change_scene_to_file("res://scenes/game/level.tscn")
			
	# Efeito de pulsar na label 'clique para começar'.
	t += delta
	$Continue.modulate.a = abs(sin(t))
	
