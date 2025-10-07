extends Node

var music_player: AudioStreamPlayer
var volume_min = -20
var volume_max = -10
var music_path

# Tem 5 estados no jogo e eles servem para determinar em qual momento do jogo
# está o jogador. Isto é utilizado para determinar os checkpoints.
# 0 = acabou de começar; 
# 1 = passou da primeira conversa com o primeiro NPC; 
# 2 = passou da primeira conversa com o segundo NPC;
# 3 = passou da primeira conversa com o terceiro NPC;
# 4 = pegou o cálice (zerou o jogo).
var state = 0     
var state_previous = 0

# Variável usada para travar o personagem nos momentos de diálogo.
var stop_player = true

# Variável para determinar se o jogador está perto de algum NPC e pode conversar.
# 0 = longe de todos os NPCs, i = próximo ao NPC i
var close_to_npc = 0

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_path = "res://assets/music/Kim Lightyear - Walking On Clouds.mp3"
	play_music()

func _process(delta: float) -> void:
	# Música dos créditos.
	if state == 4:
		if "Clouds" in music_path: 
			music_player.stop()
			music_player = AudioStreamPlayer.new()
			add_child(music_player)
			music_path = "res://assets/music/Motion.mp3"
			play_music()
			
	# Volume da música do jogo diminui com a altura.
	if get_tree().root.has_node("Level/Player") and "Clouds" in music_path:
		var player = get_tree().root.get_node("Level/Player")
		music_player.volume_db = player.position.y * (-volume_min + volume_max)/12500 + (volume_max + (-volume_max  + volume_min)/25)

	# Verifica se deve salvar o jogo.
	if state > state_previous and state < 4:
		state_previous = state
		
		# Só salva se o state atual é maior do que o do arquivo de save.
		var node_data = SaveLoad.load_file()
		
		if node_data != null:
			if node_data["state"] < state: 
				SaveLoad.save_game()

func play_music():
	# Aguarda 3 segundos ante de tocar a música.
	await get_tree().create_timer(3.0).timeout
	
	# Carrega a música (substitua pelo caminho correto do seu arquivo .ogg ou .wav)
	var music = load(music_path)
	music_player.stream = music
	music_player.stream_paused = false
	music_player.autoplay = true
	music_player.stream.loop = true
	music_player.volume_db = volume_max

	# Toca a música
	music_player.play()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"index": get_index(),
		"state": state,
	}
	return save_dict
