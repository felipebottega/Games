extends Node2D


var n = 150
var AgentScene := preload("res://agent.tscn")
var button_mode = "start"
var agents = []


func _ready() -> void:
	randomize()

	for i in n:
		var agent := AgentScene.instantiate()
		add_child(agent)
		agent.position = Vector2(randf_range(1140, 1150), randf_range(0, 800))
		agents.append(agent)
		
	for i in n:
		var agent := AgentScene.instantiate()
		add_child(agent)
		agent.position = Vector2(randf_range(0, 10), randf_range(0, 800))
		agents.append(agent)

func _on_start_pressed() -> void:
	if button_mode == "start":
		for agent in agents:
			agent.speed = 400
		$HUD/Start.text = "RESTART"
		button_mode = "restart"
	else:
		get_tree().reload_current_scene()

func _on_path_label_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for agent in agents:
			agent.get_node("NavigationAgent2D").debug_enabled = true
	else:
		for agent in agents:
			agent.get_node("NavigationAgent2D").debug_enabled = false

func _on_radius_h_slider_value_changed(value: float) -> void:
	for agent in agents:
		agent.get_node("NavigationAgent2D").radius = value
	$"HUD/RadiusValue".text = str(value)

func _on_neighbor_distance_h_slider_value_changed(value: float) -> void:
	for agent in agents:
		agent.get_node("NavigationAgent2D").neighbor_distance = value
	$"HUD/NeighborDistanceValue".text = str(value)
	
func _on_max_neighbors_h_slider_value_changed(value: float) -> void:
	for agent in agents:
		agent.get_node("NavigationAgent2D").max_neighbors = value
	$"HUD/MaxNeighborValue".text = str(value)

func _on_time_horizon_agents_h_slider_value_changed(value: float) -> void:
	for agent in agents:
		agent.get_node("NavigationAgent2D").time_horizon_agents = value
	$"HUD/TimeHorizonAgentsValue".text = str(value)

func _on_max_speed_h_slider_value_changed(value: float) -> void:
	for agent in agents:
		agent.get_node("NavigationAgent2D").max_speed = value
	$"HUD/MaxSpeedValue".text = str(value)
