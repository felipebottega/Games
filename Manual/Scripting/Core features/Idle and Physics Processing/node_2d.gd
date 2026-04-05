extends Node2D



var timing: float = 0.0

@export var cell_size := 120
@export var grid_color := Color(1, 1, 1, 0.2)

@onready var label := $Label


func _process(delta):
	timing += delta
	label.text = "%.1f seconds" % timing

func _draw():
	var screen_size = get_viewport_rect().size
	
	for x in range(0, int(screen_size.x), cell_size):
		draw_line(Vector2(x, 0), Vector2(x, screen_size.y), grid_color)
	
