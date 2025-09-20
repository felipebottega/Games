extends Node2D

var status
var status_arr = []

func _ready():
	# Esconde alguns botões na tela inicial do manu.
	$ControlsImage.hide()
	$CreditsText.hide()
	$Back.hide()
	
	# Cria uma instância da animação de caminhar do player e dá play.
	var sprite = $Player/AnimatedSprite2D.duplicate()
	sprite.position = $Player.global_position
	sprite.scale = $Player.scale
	add_child(sprite)     
	$Player/AnimatedSprite2D.hide()    # tem que esconder pois o original possui física e vai cair
	sprite.play("walk")
	
	ResourceLoader.load_threaded_request("res://scenes/game/levels/level.tscn")
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/game/levels/level.tscn")
		
	status = ResourceLoader.load_threaded_get_status("res://scenes/game/levels/level.tscn", status_arr)
	$Label.text = "G " + str(status) + ' ' + str(status_arr)

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game/levels/level.tscn")

func _on_controls_pressed():
	$"Clouds-1".modulate = Color(.4, .4, .4)
	$"Clouds-2".modulate = Color(.4, .4, .4)
	$"Clouds-3".modulate = Color(.4, .4, .4)
	$StartGame.hide()
	$Controls.hide()
	$Credits.hide()
	$ControlsImage.show()
	$CreditsText.hide()
	$Back.show()

func _on_credits_pressed():
	$"Clouds-1".modulate = Color(.4, .4, .4)
	$"Clouds-2".modulate = Color(.4, .4, .4)
	$"Clouds-3".modulate = Color(.4, .4, .4)
	$StartGame.hide()
	$Controls.hide()
	$Credits.hide()
	$ControlsImage.hide()
	$CreditsText.show()
	$Back.show()

func _on_back_pressed():
	$"Clouds-1".modulate = Color(1, 1, 1)
	$"Clouds-2".modulate = Color(1, 1, 1)
	$"Clouds-3".modulate = Color(1, 1, 1)
	$StartGame.show()
	$Controls.show()
	$Credits.show()
	$ControlsImage.hide()
	$CreditsText.hide()
	$Back.hide()
