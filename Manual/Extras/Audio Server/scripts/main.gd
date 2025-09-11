extends Node2D

var room_scene
var rooms_dict := {}
var text = "Schubert - Allegro Scherzando Impromptu Op. 142, 2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room_scene = preload("res://scenes/scenario.tscn")
	$AnimationPlayer.play("fadein")
	
	for i in range(10):
		var room = room_scene.instantiate()
		room.position.x = 700 * i
		room.room_change.connect(_on_scenario_room_change)
		add_child(room)
		
		# Guarda no dicionário com a chave que você quiser
		# pode ser o índice, ou um nome único
		rooms_dict[700 * i] = room

	var player_scene = preload("res://scenes/player.tscn")
	var player = player_scene.instantiate()
	player.position = Vector2(30, 200)
	add_child(player)
	
	# A classe AudioServer é a principal para manipular os canais de áudio.
	# Número de canais de áudio.
	print("Número de canais de áudio = ", AudioServer.bus_count)
	
	# Velocidade da execução do áudio (default=1).
	print("Velocidade da reprodução do áudio = ", AudioServer.playback_speed_scale)
	
	# Retorna o índice do canal de áudio de nome {bus_name}. Se não existir, retorna -1.
	var bus_name = "Master"
	print("Índice do canal 'Master' = ", AudioServer.get_bus_index(bus_name))
	print("Índice do canal 'Blob' = ", AudioServer.get_bus_index("Blob"), " (-1 significa que não existe)")

	# Retorna o nome do canal, dado o seu índice. Se não existir, retorna string vazia.
	var bus_idx = 0
	print('Nome do canal de índice 0 = ', AudioServer.get_bus_name(bus_idx))
	print('Nome do canal de índice 1 = ', AudioServer.get_bus_name(1))
	
	# Retorna o volume do canal, em dB.
	print('Volume do canal ', AudioServer.get_bus_name(bus_idx), ' = ', AudioServer.get_bus_volume_db(bus_idx), ' dB')
	
	# Retorna o número de efeitos em um canal.
	print('Número de efeitos no canal ', AudioServer.get_bus_name(bus_idx), ' = ', AudioServer.get_bus_effect_count(bus_idx))

	# Retorna o efeito de áudio (objeto) numa posição de um canal de áudio. Se não existir, retorna nulo.
	var effect_idx = 0
	print('Primeiro efeito do canal ', AudioServer.get_bus_name(bus_idx), ' = ', AudioServer.get_bus_effect(bus_idx, effect_idx))
	print('Segundo efeito do canal ', AudioServer.get_bus_name(bus_idx), ' = ', AudioServer.get_bus_effect(bus_idx, effect_idx+1))

func _on_scenario_room_change(pos_x):
	var bus_master_idx = 0    # audio bus master
	var num_effects = AudioServer.get_bus_effect_count(bus_master_idx)    # número de efeitos no canal master
	var effect_idx = 0   # índice de posição do novo efeito que vai entrar
	
	for key in rooms_dict:
		if pos_x <= key and key < pos_x + 700:
			# Remove todos os efeitos do canal master.
			while num_effects > 0:
				print('Removendo um filtro de ', num_effects)
				AudioServer.remove_bus_effect(bus_master_idx, 0)
				num_effects = AudioServer.get_bus_effect_count(bus_master_idx)
			
			# Aplica efeito de acordo com a sala que o player está no momento.
			print('Aplicando filtro -> ', pos_x, ' ', key)
			
			if key < 700:
				# Inicializa uma instância de um objeto de um efeito de áudio para entrar.
				var audio_effect = AudioEffectStereoEnhance.new()
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Schubert - Allegro Scherzando Impromptu Op. 142, 2"
			
			elif key == 700:
				var audio_effect = AudioEffectBandPassFilter.new()
				audio_effect.cutoff_hz = 4000
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Band Pass Filter"
				
			elif key == 1400:
				var audio_effect = AudioEffectChorus.new()
				audio_effect.dry = 0.5
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Chorus"
			
			elif key == 2100:
				var audio_effect = AudioEffectPhaser.new()
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Phaser"
			
			elif key == 2800:
				var audio_effect = AudioEffectPitchShift.new()
				audio_effect.pitch_scale = 0.4
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Pitch Shift 0.4"
			
			elif key == 3500:
				var audio_effect = AudioEffectPitchShift.new()
				audio_effect.pitch_scale = 1.2
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Pitch Shift 1.2"
			
			elif key == 4200:
				var audio_effect = AudioEffectPitchShift.new()
				audio_effect.pitch_scale = 2.0
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Pitch Shift 2.0"
			
			elif key == 4900:
				var audio_effect = AudioEffectDelay.new()
				audio_effect.tap1_level_db = -3
				audio_effect.tap1_pan = 0.3
				audio_effect.tap2_level_db = -6
				audio_effect.tap2_pan = -0.5
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Delay"
			
			elif key == 5600:
				var audio_effect = AudioEffectReverb.new()
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				text = "Reverb"
			
			elif key == 6300:
				var audio_effect = AudioEffectDistortion.new()
				audio_effect.mode = AudioEffectDistortion.MODE_LOFI 
				AudioServer.add_bus_effect(bus_master_idx, audio_effect, effect_idx)
				
				var audio_effect2 = AudioEffectPhaser.new()
				audio_effect2.rate_hz = 2.7
				AudioServer.add_bus_effect(bus_master_idx, audio_effect2, effect_idx+1)
				text = "Distortion LOFI + Phaser"
			
			# Mostra a legenda.
			change_text(text)
			break
			
func change_text(text):
	$AnimationPlayer.stop()
	var anim = $AnimationPlayer.get_animation("fadein")
	var track_idx = 0
	var keyframe = 0
	
	# track_set_key_value(track_idx: int, key: int, value: Variant)
	anim.track_set_key_value(track_idx, keyframe, text)
	$AnimationPlayer.play()
