extends Node2D


var sprite


#region ready
func _ready() -> void:
	sprite = $Sprite2D
	sprite.visible = true
	hud_adjust()
#endregion 

#region input
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
#endregion

#region signals
func hud_adjust():
	await get_tree().process_frame
	var vsize = get_viewport_rect().size
	var hud_scale = Vector2(0.5, 0.5)
	
	sprite.position = vsize / 2.0
	sprite.position.y -= 40
	
	$CanvasLayer/StretchMode.position = vsize / 2.0
	$CanvasLayer/StretchMode.position.x -= 85
	$CanvasLayer/StretchMode.position.y += 10
	$CanvasLayer/StretchMode.scale = hud_scale
	
	$CanvasLayer/BaseResolution.position = vsize / 2.0
	$CanvasLayer/BaseResolution.position.x += 3
	$CanvasLayer/BaseResolution.position.y += 10
	$CanvasLayer/BaseResolution.scale = hud_scale
	
	$CanvasLayer/ScreenResolution.position = vsize / 2.0
	$CanvasLayer/ScreenResolution.position.x -= 85
	$CanvasLayer/ScreenResolution.position.y += 40
	$CanvasLayer/ScreenResolution.scale = hud_scale
	
	$CanvasLayer/Aspect.position = vsize / 2.0
	$CanvasLayer/Aspect.position.x += 3
	$CanvasLayer/Aspect.position.y += 40
	$CanvasLayer/Aspect.scale = hud_scale
	
	$CanvasLayer/WindowMode.position = vsize / 2.0
	$CanvasLayer/WindowMode.position.x -= 85
	$CanvasLayer/WindowMode.position.y += 70
	$CanvasLayer/WindowMode.scale = hud_scale
	
	$CanvasLayer/ScaleMode.position = vsize / 2.0
	$CanvasLayer/ScaleMode.position.x += 3
	$CanvasLayer/ScaleMode.position.y += 70
	$CanvasLayer/ScaleMode.scale = hud_scale
	
	$CanvasLayer/Button.position = vsize / 2.0
	$CanvasLayer/Button.position.x += 70
	$CanvasLayer/Button.position.y += 15
	$CanvasLayer/Button.scale = hud_scale

func _on_stretch_mode_item_selected(index: int) -> void:
	get_tree().root.content_scale_mode = index
	hud_adjust()
	
func _on_scale_mode_item_selected(index: int) -> void:
	get_tree().root.content_scale_stretch = index
	hud_adjust()

func _on_base_resolution_item_selected(index: int) -> void:
	var res = $CanvasLayer/BaseResolution.get_item_text(index)
	var width = int(res.split('x')[0])
	var height = int(res.split('x')[1])
	get_tree().root.content_scale_size = Vector2i(width, height)	
	hud_adjust()
	
func _on_screen_resolution_item_selected(index: int) -> void:
	var res = $CanvasLayer/ScreenResolution.get_item_text(index)
	var width = int(res.split('x')[0])
	var height = int(res.split('x')[1])
	DisplayServer.window_set_size(Vector2i(width, height))
	hud_adjust()

func _on_aspect_item_selected(index: int) -> void:
	get_tree().root.content_scale_aspect = index
	hud_adjust()

func _on_window_mode_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(index)
	hud_adjust()

func _on_button_pressed() -> void:
	if sprite == $Sprite2D:
		sprite.visible = false
		sprite = $Sprite2D2
		sprite.visible = true
	else:
		sprite.visible = false
		sprite = $Sprite2D
		sprite.visible = true
		
	hud_adjust()
#endregion
