extends Node2D

var viewport_size
var counter  = 0
var pillar_scene
var pin_scene
var ball_scene
var initial_step = 2
var num_fileiras = 100
@export var step: int = 70

func _ready():
	viewport_size = get_viewport().get_visible_rect().size
	pillar_scene = preload("res://scenes/pillar.tscn") 
	pin_scene = preload("res://scenes/pin.tscn")  
	ball_scene = preload("res://scenes/ball.tscn") 
	$Funnel.hide()
	$Border.hide()
	$HUD/Message.hide()
	$HUD/Quit.hide()
	set_physics_process(false)

func new_game(step_value: float):
	step = step_value
	set_stage()
	$Funnel.show()
	$Border.show()
	$HUD/Message.show()
	$HUD/Quit.show()
	$HUD/StepSlider.hide()
	$HUD/StepSliderInfo.hide()
	set_physics_process(true)
	
func set_stage():
	# Pilares.
	for i in range(initial_step, viewport_size.x + step, step+10):
		# Cria uma nova instância da cena.
		var pillar = pillar_scene.instantiate()
		
		# Define a posição.
		pillar.position = Vector2(i, viewport_size.y - 200)
		
		# Cria o objeto na cena Main.
		add_child(pillar)
		
	# Obstáculos.
	for k in range(num_fileiras):
		var x_shift = step/2.0 if k % 2 == 0 else 0.0
		var y_shift = 0.3 * viewport_size.y + k * step/2.0
		
		if y_shift > 0.68 * viewport_size.y:
			break 
		 
		for i in range(initial_step, viewport_size.x + step, step):    # uma fileira
			# Cria uma nova instância da cena.
			var pin = pin_scene.instantiate()
			
			# Define a posição.
			pin.position = Vector2(i + x_shift, y_shift)
			
			# Cria o objeto na cena Main.
			add_child(pin)
			
func _physics_process(_delta: float) -> void:
	if counter < 10000 and counter % 10 == 0:
		# Cria uma nova instância da cena.
		var ball = ball_scene.instantiate()
		
		# Define a posição.
		ball.position = Vector2(randf_range(0, viewport_size.x), randf_range(-10, -20))
		
		# Cria o objeto na cena Main.
		add_child(ball)
		
		$HUD.update_num_balls(1 + int(counter/10))
		
	counter += 1
