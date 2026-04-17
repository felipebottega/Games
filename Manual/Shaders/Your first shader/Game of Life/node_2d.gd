extends Node2D

var iter: int = 0
var texture: ImageTexture

@onready var subv = $SubViewportContainer/SubViewport
@onready var rect = $SubViewportContainer/SubViewport/ColorRect

func snapshot(vp: SubViewport) -> ImageTexture:
	var img = vp.get_texture().get_image()
	return ImageTexture.create_from_image(img)

func _physics_process(delta: float) -> void:
	if iter == 0:
		await RenderingServer.frame_post_draw
		texture = snapshot(subv)
	else:
		rect.material.set_shader_parameter("iter", iter)
		rect.material.set_shader_parameter("input_texture", texture)
		await RenderingServer.frame_post_draw
		texture = snapshot(subv)

	iter += 1
