extends Node2D


func _on_example_1_pressed() -> void:
	get_tree().change_scene_to_file("res://example_1.tscn")

func _on_example_2_pressed() -> void:
	get_tree().change_scene_to_file("res://example_2.tscn")
