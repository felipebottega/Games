extends Node2D


var zoom: float = 2.0
var zoom_speed = 1.2
var center := Vector2(0.0, 0.0)
var dragging := false
var viewport_size

@onready var subv = $SubViewportContainer/SubViewport
@onready var rect = $SubViewportContainer/SubViewport/ColorRect


func _ready() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	subv.size = viewport_size
	rect.size = viewport_size

func _input(event: InputEvent) -> void:
	var mouse = get_viewport().get_mouse_position()
	
	if mouse.x > 0.7 * viewport_size.x and mouse.y < 0.25 * viewport_size.y:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed and zoom > 0.000001:
			var before = get_fractal_pos(mouse)

			zoom /= zoom_speed
			rect.material.set_shader_parameter("zoom", zoom)

			var after = get_fractal_pos(mouse)
			center += before - after

			rect.material.set_shader_parameter("center", center)
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed and zoom < 2:
			var before = get_fractal_pos(mouse)

			zoom *= zoom_speed
			rect.material.set_shader_parameter("zoom", zoom)

			var after = get_fractal_pos(mouse)
			center += before - after

			rect.material.set_shader_parameter("center", center)

	if event is InputEventMouseMotion and dragging:
		var delta = event.relative / viewport_size # Converte movimento de pixels em espaço do fractal.
		
		delta *= 2.0  # Porque UV vai de -1 a 1.
		delta *= zoom
		center -= delta
		rect.material.set_shader_parameter("center", center)

func get_fractal_pos(mouse_pos: Vector2) -> Vector2:
	var uv = mouse_pos / viewport_size
	
	uv = uv * 2.0 - Vector2(1.0, 1.0)
	uv *= zoom
	uv += center
	
	return uv

func _on_colors_value_changed(value: float) -> void:
	rect.material.set_shader_parameter("colors", value)

func _on_maxiter_value_changed(value: float) -> void:
	rect.material.set_shader_parameter("max_iter", value)
	$CanvasLayer/MaxIter/Label.text = str(int(value))
