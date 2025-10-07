extends Sprite2D

var selection = 1    # 1 = start game, 2 = load game, 3 = quit
var space = 150
signal start_game
signal load_game
signal quit

func _ready() -> void:
	position = Vector2(47, 155)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("down"):
		if selection < 3:
			$"../Select".play()
			position.y += space
			selection += 1
	elif Input.is_action_just_pressed("up"):
		if selection > 1:
			$"../Select".play()
			position.y -= space
			selection -= 1
	elif Input.is_action_just_pressed("accept"):
		$"../Confirm".play()
		await $"../Confirm".finished  # espera o som terminar
		
		if selection == 1:
			start_game.emit()
		elif selection == 2:
			load_game.emit()
		elif selection == 3:
			quit.emit()
	
