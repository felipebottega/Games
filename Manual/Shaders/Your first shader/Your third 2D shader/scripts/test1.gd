extends Node2D

var iter: int = 0
var texture: ImageTexture

@onready var fig1 = $SubViewportContainer/SubViewport
@onready var rect1 = $SubViewportContainer/SubViewport/Sprite2D

func snapshot(vp: SubViewport) -> ImageTexture:
	var img = vp.get_texture().get_image()
	return ImageTexture.create_from_image(img)

func _physics_process(delta: float) -> void:
	if iter == 0:
		await RenderingServer.frame_post_draw
		texture = snapshot(fig1)
	else:
		rect1.material.set_shader_parameter("iter", iter)
		rect1.material.set_shader_parameter("input_texture", texture)
		await RenderingServer.frame_post_draw
		texture = snapshot(fig1)

	iter += 1
	$CanvasLayer/Label.text = str(iter)
