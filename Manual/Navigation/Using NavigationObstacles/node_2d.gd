extends Node2D


var button_mode = "start"


func _ready() -> void:
	$"AgentMain".speed = 0

func _on_start_pressed() -> void:
	if button_mode == "start":
		$"AgentMain".speed = 100
		$HUD/Start.text = "RESTART"
		button_mode = "restart"
	else:
		get_tree().reload_current_scene()

func _on_radius_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".radius = value
	$"HUD/RadiusValue".text = str(value)

func _on_time_horizon_obstacles_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".time_horizon_obstacles = value
	$"HUD/TimeHorizonObstaclesValue".text = str(value)

func _on_max_speed_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".max_speed = value
	$"HUD/MaxSpeedValue".text = str(value)
