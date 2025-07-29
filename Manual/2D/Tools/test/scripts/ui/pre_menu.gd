extends Node2D

var pulse_amplitude: float = 0.5
var pulse_speed: float = 3.0
var time_passed: float = 0.0
var base_color: Color

func _ready():
	var cached_scene = load("res://scenes/game/levels/level.tscn")
	base_color = $Label.modulate

func _input(event: InputEvent):
	# Detecta qualquer tecla pressionada.
	if event is InputEventKey and event.pressed:
		get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
		
	# Detecta qualquer clique do mouse pressionado.
	elif event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
		
# Detecta qualquer botão do controle pressionado.
	elif event is InputEventJoypadButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

func _process(delta):
	time_passed += delta/5
	var pulse = (sin(time_passed * pulse_speed * PI * 2) + 1) / 2  # valor entre 0 e 1
	var brightness_factor = 1.0 - pulse_amplitude * pulse
	$Label.modulate = base_color * brightness_factor
