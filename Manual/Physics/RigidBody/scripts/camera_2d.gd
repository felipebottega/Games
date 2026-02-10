extends Camera2D

@export var zoom_step := 0.05
@export var min_zoom := 0.1
@export var max_zoom := 3.0
@export var pan_button := MOUSE_BUTTON_MIDDLE
@export var pan_speed := 1.0

var _dragging := false
var _last_mouse_pos := Vector2.ZERO

func _unhandled_input(event):
	# --- ZOOM COM SCROLL ---
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2.ONE * zoom_step
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2.ONE * zoom_step

		zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

		# --- INÍCIO DO PAN ---
		if event.button_index == pan_button:
			_dragging = true
			_last_mouse_pos = event.position

	elif event is InputEventMouseButton and not event.pressed:
		# --- FIM DO PAN ---
		if event.button_index == pan_button:
			_dragging = false

	elif event is InputEventMouseMotion and _dragging:
		var delta: Vector2 = event.position - _last_mouse_pos
		position -= delta * pan_speed / zoom.x
		_last_mouse_pos = event.position
