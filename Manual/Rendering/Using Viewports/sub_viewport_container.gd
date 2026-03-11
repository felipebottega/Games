extends SubViewportContainer

@onready var subv : SubViewport = $SubViewport
@onready var second_camera : Camera2D = $SubViewport/SecondScene/Camera2D

func _ready() -> void:
	second_camera.make_current()

func _process(delta: float) -> void:
	var mouse_global : Vector2 = get_global_mouse_position()

	# mover o visor
	global_position = mouse_global - subv.size * 0.5

	# mover a câmera da segunda cena
	second_camera.global_position = mouse_global
