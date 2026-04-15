extends Camera2D

@export var zoom_factor := 0.9   # quanto menor, mais agressivo
@onready var mat: ShaderMaterial = $"../ColorRect".material

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			apply_zoom(zoom_factor)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			apply_zoom(1.0 / zoom_factor)

func apply_zoom(factor: float):
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_visible_rect().size

	# Coordenada normalizada (-1 → 1)
	var uv = (mouse_pos / screen_size) * 2.0 - Vector2.ONE

	# Corrige aspect ratio (igual no shader)
	uv.x *= screen_size.x / screen_size.y

	# Pega valores atuais do shader
	var current_zoom: float = mat.get_shader_parameter("zoom")
	var center: Vector2 = mat.get_shader_parameter("center")

	# Ajusta centro para manter o ponto fixo
	center += uv * current_zoom * (1.0 - factor)

	# Aplica novo zoom
	current_zoom *= factor

	mat.set_shader_parameter("zoom", current_zoom)
	mat.set_shader_parameter("center", center)
