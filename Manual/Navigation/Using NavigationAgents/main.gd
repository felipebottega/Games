extends Node2D

var button_mode = "start"

func _ready() -> void:
	$"Node2D/AgentMain".speed = 0
	$"Node2D2/AgentMain".speed = 0

func _on_start_pressed() -> void:
	if button_mode == "start":
		$"Node2D/AgentMain".speed = 100
		$"Node2D2/AgentMain".speed = 100
		$Start.text = "RESTART"
		button_mode = "restart"
	else:
		get_tree().reload_current_scene()
