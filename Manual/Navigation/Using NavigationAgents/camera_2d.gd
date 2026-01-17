extends Camera2D

@export var zoom_step := 0.05
@export var min_zoom := 0.1
@export var max_zoom := 3.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom(zoom_step)      # aproxima
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom(-zoom_step)     # afasta

func _zoom(amount: float) -> void:
	var z := zoom - Vector2(amount, amount)
	z.x = clamp(z.x, min_zoom, max_zoom)
	z.y = clamp(z.y, min_zoom, max_zoom)
	zoom = z
