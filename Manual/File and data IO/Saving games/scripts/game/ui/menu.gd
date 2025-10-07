extends Node2D

var level = preload("res://scenes/game/levels/level.tscn")
var showing_menu = true

func _ready() -> void:
	# Usuário voltou para o menu depois de zerar.
	if Manager.state == 4:
		Manager.music_player.stop()
		Manager.state = 3
		Manager.music_path = "res://assets/music/Kim Lightyear - Walking On Clouds.mp3"
		Manager.play_music()
	# Carrega variáveis do arquivo de load.
	else:
		SaveLoad.load_game()
		SaveLoad.load_game_autoload()
	
	# Visibilidade inicial do menu.
	$StartGame.visible = true
	$LoadGame.visible = true
	$Quit.visible = true 
	$StartGame.disabled = false
	$LoadGame.disabled = false
	$Quit.disabled = false
	
	$LoadGame1.visible = false
	$LoadGame2.visible = false
	$LoadGame3.visible = false
	$LoadGame1/LoadGame1.disabled = true
	$LoadGame2/LoadGame2.disabled = true
	$LoadGame3/LoadGame3.disabled = true
	
	# Sombreamento dos ícones da tela de load para indicar o que tem disponível.
	if Manager.state < 1:
		$LoadGame1.modulate = Color(0.5, 0.5, 0.5, 1) 
		$LoadGame2.modulate = Color(0.5, 0.5, 0.5, 1) 
		$LoadGame3.modulate = Color(0.5, 0.5, 0.5, 1) 
	elif Manager.state == 1:
		$LoadGame1.modulate = Color(1, 1, 1, 1) 
		$LoadGame2.modulate = Color(0.5, 0.5, 0.5, 1) 
		$LoadGame3.modulate = Color(0.5, 0.5, 0.5, 1) 
	elif Manager.state == 2:
		$LoadGame1.modulate = Color(1, 1, 1, 1) 
		$LoadGame2.modulate = Color(1, 1, 1, 1) 
		$LoadGame3.modulate = Color(0.5, 0.5, 0.5, 1)
	else:
		$LoadGame1.modulate = Color(1, 1, 1, 1) 
		$LoadGame2.modulate = Color(1, 1, 1, 1) 
		$LoadGame3.modulate = Color(1, 1, 1, 1)

# O process apenas fica checando se o usuário apertou escape para voltar ao menu.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel"):
		get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

### Funções de start game, load game e quit ###
func start_game():
	get_tree().change_scene_to_packed(level)
	
func load_game():
	# Na tela do menu, usuário clicou para ver a tela de load game.
	if showing_menu:
		$StartGame.visible = false
		$LoadGame.visible = false
		$Quit.visible = false
		$StartGame.disabled = true
		$LoadGame.disabled = true
		$Quit.disabled = true
		
		$LoadGame1.visible = true
		$LoadGame2.visible = true
		$LoadGame3.visible = true
		$LoadGame1/LoadGame1.disabled = false
		$LoadGame2/LoadGame2.disabled = false
		$LoadGame3/LoadGame3.disabled = false
	
		# Depois de alterar a visibilidade também deve alterar a flag.
		showing_menu = false
	else:
		# Usuário chegou aqui com a setinha na tela de load.
		_on_load_game_2_pressed()
	
func quit():
	if showing_menu:
		get_tree().quit()
	else:
		# Usuário chegou aqui com a setinha na tela de load.
		_on_load_game_3_pressed()
		
### Sinais de clicar algum botão do menu ###
func _on_start_game_pressed() -> void:
	Manager.state = 0
	start_game()

func _on_load_game_pressed() -> void:
	load_game()
	
func _on_quit_pressed() -> void:
	quit()
	
### Sinais da setinha do menu ###
func _on_arrow_start_game() -> void:
	if showing_menu:
		Manager.state = 0
		start_game()
	else:
		_on_load_game_1_pressed()

func _on_arrow_load_game() -> void:
	if showing_menu:
		load_game()
	else:
		_on_load_game_2_pressed()
	
func _on_arrow_quit() -> void:
	if showing_menu:
		quit()
	else:
		_on_load_game_3_pressed()
	
### Sinais dos botões de load ###
func _on_load_game_1_pressed() -> void:
	if Manager.state >= 1:
		Manager.state = 1
		start_game()
	
func _on_load_game_2_pressed() -> void:
	if Manager.state >= 2:
		Manager.state = 2
		start_game()
	
func _on_load_game_3_pressed() -> void:
	if Manager.state >= 3:
		Manager.state = 3
		start_game()
