extends Node2D

var zeros = []

func set_zeros(data):
	zeros = data
	queue_redraw()

func _draw():
	var center = Vector2(500, 350)
	var scale = 200

	for raiz_set in zeros:
		for z in raiz_set:
			var x = center.x + z.re * scale
			var y = center.y - z.im * scale
			draw_circle(Vector2(x, y), 1, Color(1, 0.2, 0.5))
