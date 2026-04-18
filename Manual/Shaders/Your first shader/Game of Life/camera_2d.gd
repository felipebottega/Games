extends Camera2D


var dragging := false

@export var zoom_speed := 0.1
@export var min_zoom := 1.0
@export var max_zoom := 10.0


func _ready() -> void:
	position = Manager.dims/2
	zoom = (
		Vector2(1, 1) if Manager.dims[0] == 2048
		else Vector2(2, 2) if Manager.dims[0] == 1024
		else Vector2(4, 4) if Manager.dims[0] == 512
		else Vector2(8, 8)
	) 

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
