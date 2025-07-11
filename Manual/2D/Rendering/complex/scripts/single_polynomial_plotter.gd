extends Node2D

var zeros = []

func set_zeros(data):
	zeros = data
	queue_redraw()

func _draw():
	var center = Vector2(500, 350)
	var point_scale = 200
	
	# Eixo X
	draw_line(Vector2(center.x-500, center.y), Vector2(center.x+500, center.y), Color(0.4, 0.4, 0.4), 1)
	
	# Eixo Y
	draw_line(Vector2(center.x, center.y-500), Vector2(center.x, center.y+500), Color(0.4, 0.4, 0.4), 1)

	for raiz_set in zeros:
		for z in raiz_set:
			var x = center.x + z.re * point_scale
			var y = center.y - z.im * point_scale
			draw_circle(Vector2(x, y), 5, Color(0.1, 0.8, 1))
			
