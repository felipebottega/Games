extends Node2D


func _on_line_edit_text_submitted(new_text: String) -> void:
	if not new_text.is_valid_int():
		return

	var num := new_text.to_int()

	if num < 1 or num > 14:
		return

	var scene_path := "res://scenes/test" + str(num) + ".tscn"

	if not ResourceLoader.exists(scene_path):
		return

	get_tree().change_scene_to_file(scene_path)
