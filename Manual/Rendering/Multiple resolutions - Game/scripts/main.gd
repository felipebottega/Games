extends Node2D


func _ready() -> void:
	$HUD/VolumeHSlider.visible = false
	$HUD/BaseResolution.visible = false
	$HUD/WindowMode.visible = false
	$HUD/Back.visible = false
	$HUD/Credits/Label.visible = false
	$SubViewport.size = Vector2(GameState.game_width, GameState.game_height)
	$HUD/BaseResolution.selected = GameState.base_resolution_selected
	$HUD/WindowMode.selected = GameState.window_mode_selected

func _process(_delta: float) -> void:
	$AudioStreamPlayer.volume_db = GameState.volume

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/tutorial.tscn")

func _on_volume_h_slider_value_changed(value: float) -> void:
	GameState.volume = value

func _on_configuration_pressed() -> void:
	$HUD/Start.visible = false
	$HUD/Configuration.visible = false
	$HUD/Quit.visible = false
	$HUD/VolumeHSlider.visible = true
	$HUD/BaseResolution.visible = true
	$HUD/WindowMode.visible = true
	$HUD/Back.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	$HUD/Start.visible = true
	$HUD/Configuration.visible = true
	$HUD/Quit.visible = true
	$HUD/VolumeHSlider.visible = false
	$HUD/BaseResolution.visible = false
	$HUD/WindowMode.visible = false
	$HUD/Back.visible = false

func _on_base_resolution_item_selected(index: int) -> void:
	GameState.base_resolution_selected = index
	var res = $HUD/BaseResolution.get_item_text(index)
	GameState.game_width = int(res.split('x')[0])
	GameState.game_height = int(res.split('x')[1])
	$SubViewport.size = Vector2(GameState.game_width, GameState.game_height)

func _on_window_mode_item_selected(index: int) -> void:
	GameState.window_mode_selected = index
	var id = $HUD/WindowMode.get_item_id(index)
	DisplayServer.window_set_mode(id)

func _on_credits_pressed() -> void:
	if $HUD/Credits/Label.visible:
		$HUD/Credits/Label.visible = false
		modulate = Color(1, 1, 1, 1)
	else:
		$HUD/Credits/Label.visible = true
		modulate = Color(0.2, 0.2, 0.2, 0.2)
