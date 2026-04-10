extends Node2D


func _on_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/challenge_1.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/challenge_2.tscn")
