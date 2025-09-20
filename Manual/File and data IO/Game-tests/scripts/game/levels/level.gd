extends Node2D

var score = 0
var flag_atlas_coords = Vector2i(14, 8)    # coordenada da bandeira no seu atlas
var elapsed_time = 0.0     # Tempo acumulado desde o início
var num_flags = 35
var t = 0.0
var gravity_no_wind := -1800.0
var gravity_wind := -10000.0
var toggle = false

func _ready():
	start_timer()

	var leaves_cp = get_parent().get_node("Leaves")
	leaves_cp.get_parent().remove_child(Leaves)
	add_child(leaves_cp)  # agora é filho do node que executa o script
	leaves_cp.global_position = Vector2(4000, 800)
	leaves_cp.modulate = Color(1, 1, 1, 1)
	leaves_cp.visible = true
	move_child(Leaves, 4)

func start_timer():
	# Cria um Timer que vai ficar rodando durante todo o jogo, mudando de estado a cada 10 segundos.
	var timer = Timer.new()
	timer.wait_time = 10    # 10 segundos de espera para 'ligar' e 'desligar' o vento
	timer.one_shot = false    # parâmetro que faz com que o Timer reinicie após 10 segundos
	timer.autostart = true    # parâmetro que faz o Timer começar a rodar assim que começa a cena
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	toggle = !toggle
	$Leaves.process_material.gravity.x = gravity_wind if toggle else gravity_no_wind    # aplica força do vento nas folhas
	$Player.wind = gravity_wind/15 if toggle else 0    # aplica força do vento no player

func _process(delta):
	check_item_collection()
	
	if score < num_flags:
		elapsed_time += delta
		$HUD/Timer.text = "TIME = %.1f" % elapsed_time
	else:
		elapsed_time += 0
		vitoria(delta)

func check_item_collection():
	for i in [-1, 0, 1]:
		# Converte a coordenada da posição do player na coordenada correspondente no sistema de 
		# coordenadas do tilemap.
		var player_tile_pos = $Platforms.local_to_map($Player.position)
		player_tile_pos.y -= i
		
		# Retorna a ID do TileSet do tile que está na coordenada player_tile_pos. Caso não tenha
		# nenhum tile, retorna -1. Neste exemplo só temos um TileSet de ID = 0.
		var tile_id = $Platforms.get_cell_source_id(player_tile_pos)

		if tile_id == -1:
			continue  

		# Retorna o objeto TileSet com a ID que foi passada como argumento.
		var tile_data = $Platforms.tile_set.get_source(tile_id)
		if tile_data == null:
			continue

		# Retorna o coordenada do atlas do tile que o player está tocando.
		var atlas_coords = $Platforms.get_cell_atlas_coords(player_tile_pos)
		if atlas_coords != flag_atlas_coords:
			continue
		
		# Se chegou aqui é porque o player tocou no tile da bandeira. Agora podemos fazer o score.
		var tile = tile_data.get_tile_data(atlas_coords, 0)  # retorna o objeto do tile
		var points = tile.get_custom_data("Points")    # acessa o atributo Points (nesse caso é 1)
		score += points    # atualiza a variável global de score
		$HUD/Score.text = "SCORE = " + str(score)    # atualiza a HUD
		$Player/AudioItem.play()    # toca o som de coletar item
		
		# Remove o tile
		$Platforms.set_cell(player_tile_pos, -1, Vector2i(-1, -1))
			
func vitoria(delta):
	$HUD/Vitoria.show()
	$HUD/Restart.show()
	
	# Define o centro como ponto de origem.
	$HUD/Vitoria.pivot_offset = $HUD/Vitoria.size / 2
	
	 # Centraliza o Label.
	$HUD/Vitoria.position = get_viewport().size / 2 + Vector2i(250, 50)
	 
	# Muda o tamanho da mensagem dinamizamente com o tempo.
	t += delta
	$HUD/Vitoria.scale = Vector2(1 + abs(sin(3*t)), 1 + abs(sin(3*t)))
	
	# Pausa a física, animações e o _process e _physics_process de todos os filhos.
	set_physics_process(false)
	$Player/AnimatedSprite2D.pause()
	
	for child in get_children():
		child.set_process(false)
		child.set_physics_process(false)
