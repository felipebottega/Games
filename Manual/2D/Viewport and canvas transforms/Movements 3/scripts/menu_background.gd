extends Sprite2D

var start_pos
var time = 0
var t = 0

func _ready():
	$"../HelpFigure".hide()
	$"../Back".hide()
	start_pos = $"../Start".position

func _process(delta):
	position = start_pos + 100 * Vector2(cos(t), sin(t))
	scale = (1 - t/(5*PI)) * Vector2.ONE
	
	t = (sin(time) + 1.0) * PI    # varia de 0 a 2*PI e depois volta a zero e repete
	time += delta/10

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/rotations_composition.tscn")

func _on_help_pressed():
	modulate = Color(0.3, 0.3, 0.3)
	$"../Start".hide()
	$"../Help".hide()
	$"../HelpFigure".show()
	$"../Back".show()

func _on_back_pressed() -> void:
	modulate = Color(1, 1, 1)
	$"../Start".show()
	$"../Help".show()
	$"../HelpFigure".hide()
	$"../Back".hide()
