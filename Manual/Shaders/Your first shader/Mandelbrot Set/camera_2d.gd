extends Camera2D


var dragging := false

@export var zoom_speed := 0.01
@export var min_zoom := 0.1
@export var max_zoom := 10.0


func _ready() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	position = viewport_size/2
	zoom = Vector2(1, 1)

func _input(event):
	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom *= (1.0 - zoom_speed)

		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom *= (1.0 + zoom_speed)

		# clamp do zoom
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)

		# Drag de botão para mover "arrastar" a textura.
		if event.button_index == MOUSE_BUTTON_MIDDLE or event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

	if event is InputEventMouseMotion and dragging:
		position -= event.relative / zoom
