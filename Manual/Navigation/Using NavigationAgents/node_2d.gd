extends Node2D


func _on_radius_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".radius = value
	$"HUD/RadiusValue".text = str(value)

func _on_neighbor_distance_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".neighbor_distance = value
	$"HUD/NeighborDistanceValue".text = str(value)
	
func _on_max_neighbors_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".max_neighbors = value
	$"HUD/MaxNeighborValue".text = str(value)

func _on_time_horizon_agents_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".time_horizon_agents = value
	$"HUD/TimeHorizonAgentsValue".text = str(value)

func _on_max_speed_h_slider_value_changed(value: float) -> void:
	$"AgentMain/NavigationAgent2D".max_speed = value
	$"HUD/MaxSpeedValue".text = str(value)
