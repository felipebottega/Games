extends CanvasLayer


signal repeat
signal menu
signal next


func _ready() -> void:
	$AudioStreamPlayer.volume_db = GameState.volume - 10.0
	var viewport_size = get_viewport().get_visible_rect().size
	await get_tree().process_frame
	
	$Label.set_anchors_preset(Control.PRESET_CENTER)
	$Label.position = (viewport_size - $Label.size) / 2
	$Label.position.x -= 0.45 * $Label.position.x
	$Label.position.y -= 0.05 * $Label.position.y
	
	$Board.position = viewport_size / 2
	$Board.position.y += 0.23 * $Board.position.y
	
	$Repeat.position = (viewport_size - $Label.size) / 2
	$Repeat.position.x -= 0.9 * $Repeat.position.x
	$Repeat.position.y -= 0.8 * $Repeat.position.y
	
	$Repeat.position = (viewport_size - $Label.size) / 2
	$Repeat.position.x -= 0.9 * $Repeat.position.x
	$Repeat.position.y -= 0.8 * $Repeat.position.y
	
	$Menu.position = (viewport_size - $Label.size) / 2
	$Menu.position.x += 0.14 * $Menu.position.x
	$Menu.position.y -= 0.8 * $Menu.position.y
	
	$Next.position = (viewport_size - $Label.size) / 2
	$Next.position.x += 0.9 * $Next.position.x
	$Next.position.y -= 0.8 * $Next.position.y

func _on_repeat_pressed() -> void:
	repeat.emit()

func _on_menu_pressed() -> void:
	menu.emit()
	
func _on_next_pressed() -> void:
	next.emit()
