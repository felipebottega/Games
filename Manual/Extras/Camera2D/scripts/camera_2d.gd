extends Camera2D

# Fator de zoom (quanto mais perto de 1, mais suave o zoom)
const ZOOM_STEP := 0.1
const MIN_ZOOM := 1.2    # zoom out
const MAX_ZOOM := 10.0    # zoom in

func _ready() -> void:
	zoom = Vector2(4, 4)    # zoom inicial do jogo

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Zoom in
			zoom /= 1.0 + ZOOM_STEP
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# Zoom out
			zoom *= 1.0 + ZOOM_STEP

		# Limita o zoom entre mínimo e máximo
		zoom.x = clamp(zoom.x, MIN_ZOOM, MAX_ZOOM)
		zoom.y = clamp(zoom.y, MIN_ZOOM, MAX_ZOOM) 
