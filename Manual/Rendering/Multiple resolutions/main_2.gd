extends Node2D


var sprite


func _ready() -> void:
	sprite = $SubViewport/Sprite2D2
	sprite.visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_UP:
			sprite.rotation_degrees += 1
		elif event.keycode == KEY_DOWN:
			sprite.rotation_degrees -= 1
		elif event.keycode == KEY_LEFT:
			sprite.position.x -= .2
		elif event.keycode == KEY_RIGHT:
			sprite.position.x += .2

func _on_stretch_mode_item_selected(index: int) -> void:
	get_tree().root.content_scale_mode = index
	
func _on_scale_mode_item_selected(index: int) -> void:
	get_tree().root.content_scale_stretch = index

func _on_base_resolution_item_selected(index: int) -> void:
	var res = $CanvasLayer/BaseResolution.get_item_text(index)
	var width = int(res.split('x')[0])
	var height = int(res.split('x')[1])
	
	$SubViewport.size = Vector2(width, height)
	#$SubViewport.size_2d_override = Vector2(width, height)
	
	#get_tree().root.content_scale_size = Vector2i(width, height)
	
func _on_screen_resolution_item_selected(index: int) -> void:
	var res = $CanvasLayer/ScreenResolution.get_item_text(index)
	var width = int(res.split('x')[0])
	var height = int(res.split('x')[1])
	DisplayServer.window_set_size(Vector2i(width, height))

func _on_aspect_item_selected(index: int) -> void:
	get_tree().root.content_scale_aspect = index

func _on_window_mode_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(index)

func _on_scale_value_changed(value: float) -> void:
	get_tree().root.content_scale_factor = value
