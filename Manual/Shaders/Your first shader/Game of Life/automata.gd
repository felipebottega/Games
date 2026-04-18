extends Node2D


var iter: int = 0
var pattern: int = 0
var dims := Vector2i(2048, 2048)
var radius: float = 0.3
var texture: ImageTexture
var timing = 0.0

@onready var subv = $SubViewportContainer/SubViewport
@onready var rect = $SubViewportContainer/SubViewport/ColorRect


func _ready() -> void:
	dims = Manager.dims
	subv.size = dims
	rect.size = dims
	radius = Manager.radius
	pattern = Manager.pattern
	rect.material.set_shader_parameter("radius", radius)
	rect.material.set_shader_parameter("seed", randi() % 100)
	rect.material.set_shader_parameter("dims", dims[0])
	rect.material.set_shader_parameter("pattern", pattern)
	Engine.max_fps = Manager.speed
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func snapshot(vp: SubViewport) -> ImageTexture:
	var img = vp.get_texture().get_image()
	return ImageTexture.create_from_image(img)

func _process(delta: float) -> void:
	if iter == 0:
		await RenderingServer.frame_post_draw
		texture = snapshot(subv)
	else:
		rect.material.set_shader_parameter("iter", iter)
		rect.material.set_shader_parameter("input_texture", texture)
		await RenderingServer.frame_post_draw
		texture = snapshot(subv)

	iter += 1
	timing += delta
	
	if timing > 1.0:
		$CanvasLayer/Label.text = "FPS = " + str(int(Engine.get_frames_per_second()))
		timing = 0.0

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
