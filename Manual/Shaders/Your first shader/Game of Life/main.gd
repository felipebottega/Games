extends Node2D


func _ready() -> void:
	Manager.dims = Vector2i(2048, 2048)
	Manager.radius = 0.3
	Manager.speed = 60
	Manager.pattern = 0

func _on_dimensions_item_selected(index: int) -> void:
	if index == 0:
		Manager.dims = Vector2i(256, 256)
	elif index == 1:
		Manager.dims = Vector2i(512, 512)
	elif index == 2:
		Manager.dims = Vector2i(1024, 1024)
	elif index == 3:
		Manager.dims = Vector2i(2048, 2048)

func _on_radius_item_selected(index: int) -> void:
	if index == 0:
		Manager.radius = 0.1
	elif index == 1:
		Manager.radius = 0.3
	elif index == 2:
		Manager.radius = 0.5
	
func _on_pattern_item_selected(index: int) -> void:
	Manager.pattern = index

func _on_speed_item_selected(index: int) -> void:
	if index == 0:
		Manager.speed = 10
	elif index == 1:
		Manager.speed = 30
	elif index == 2:
		Manager.speed = 60
	elif index == 3:
		Manager.speed = 120
	elif index == 4:
		Manager.speed = 720

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://automata.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
