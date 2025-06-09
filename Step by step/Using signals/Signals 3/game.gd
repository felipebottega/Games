extends Node2D

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_win_area_ganhou() -> void:
	$Ganhou.visible = true
