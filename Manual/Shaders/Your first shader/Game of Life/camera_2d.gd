extends Camera2D

# ============================================================
# CONFIGURAÇÃO
# ============================================================
@export var zoom_speed := 0.1
@export var min_zoom := 0.001
@export var max_zoom := 100.0
@export var drag_speed := 0.1

# ============================================================
# ESTADO
# ============================================================
var dragging := false


# ============================================================
# INPUT
# ============================================================
func _input(event):

	# --------------------------------------------------------
	# ZOOM COM SCROLL
	# --------------------------------------------------------
	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom *= (1.0 - zoom_speed)

		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom *= (1.0 + zoom_speed)

		# clamp do zoom
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)

		# ----------------------------------------------------
		# DRAG COM BOTÃO DO MEIO (SCROLL CLICK)
		# ----------------------------------------------------
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			dragging = event.pressed


	# --------------------------------------------------------
	# MOVIMENTO AO ARRASTAR
	# --------------------------------------------------------
	if event is InputEventMouseMotion and dragging:

		# move a câmera na direção oposta do mouse
		position -= event.relative * zoom * drag_speed
