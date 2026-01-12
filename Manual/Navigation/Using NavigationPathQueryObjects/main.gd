extends Node2D


func _on_simplify_path_pressed():
	$NPC.simplify_path = not $NPC.simplify_path 
	$HUD/SimplifyPath.text = "Simplify Path: %s" % $NPC.simplify_path

func _on_postprocessing_mode_item_selected(index: int) -> void:
	$NPC.path_postprocessing = index

func _on_navigation_layers_slider_value_changed(value: float) -> void:
	$NPC.navigation_layers = $HUD/NavigationLayersSlider.value
	$HUD/NavigationLayersLabel.text = "Navigation Layers: %s" % int($HUD/NavigationLayersSlider.value)

func _on_simplify_epsilon_slider_value_changed(value: float) -> void:
	$NPC.simplify_epsilon = $HUD/SimplifyEpsilonSlider.value
	$HUD/SimplifyEpsilonLabel.text = "Simplify Epsilon: %s" % $HUD/SimplifyEpsilonSlider.value

func _on_max_length_slider_value_changed(value: float) -> void:
	$NPC.path_return_max_length = $HUD/MaxLengthSlider.value
	$HUD/MaxLengthLabel.text = "Max Length: %s" % int($HUD/MaxLengthSlider.value)

func _on_max_radius_slider_value_changed(value: float) -> void:
	$NPC.path_return_max_radius = $HUD/MaxRadiusSlider.value
	$HUD/MaxRadiusLabel.text = "Max Radius: %s" % int($HUD/MaxRadiusSlider.value)

func _on_max_distance_slider_value_changed(value: float) -> void:
	$NPC.path_search_max_distance = $HUD/MaxDistanceSlider.value
	$HUD/MaxDistanceLabel.text = "Max Distance: %s" % int($HUD/MaxDistanceSlider.value)
	
func _on_max_polygons_slider_value_changed(value: float) -> void:
	$NPC.path_search_max_polygons = $HUD/MaxPolygonsSlider.value
	$HUD/MaxPolygonsLabel.text = "Max Polygons: %s" % int($HUD/MaxPolygonsSlider.value)

func _on_meta_data_item_selected(index: int) -> void:
	$NPC.metadata_flags = $HUD/MetaData.get_item_id(index)

func _physics_process(_delta: float) -> void:
	if $NPC.query_result != null:
		$"HUD/LegendLabel".text = "METADATA\n"
		
		if $NPC.metadata_flags == NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_NONE:
			$"HUD/LegendLabel".text += "NONE"
		if $NPC.metadata_flags == NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_TYPES:
			$"HUD/LegendLabel".text += "TYPES: " + str($NPC.query_result.path_types) + "\n"
		if $NPC.metadata_flags == NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_RIDS:
			$"HUD/LegendLabel".text += "RIDS: " + str($NPC.query_result.path_rids) + "\n"
		if $NPC.metadata_flags == NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_OWNERS:
			$"HUD/LegendLabel".text += "OWNERS: " + str($NPC.query_result.path_owner_ids) + "\n"
		if $NPC.metadata_flags == NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_ALL:
			$"HUD/LegendLabel".text += "TYPES: " + str($NPC.query_result.path_types) + "\n"
			$"HUD/LegendLabel".text += "RIDS: " + str($NPC.query_result.path_rids) + "\n"
			$"HUD/LegendLabel".text += "OWNERS: " + str($NPC.query_result.path_owner_ids) + "\n"
		
func _on_included_regions_multi_selected(_index: int, _selected: bool):
	var selection = $HUD/IncludedRegions.get_selected_items()
	$NPC.included_regions = []
	
	for i in selection:
		$NPC.included_regions.append($NPC.regions_orig[i])
				
func _on_excluded_regions_multi_selected(_index: int, _selected: bool):
	var selection = $HUD/ExcludedRegions.get_selected_items()
	$NPC.excluded_regions = []
	
	for i in selection:
		$NPC.excluded_regions.append($NPC.regions_orig[i])

func _on_reset_pressed() -> void:
	get_tree().reload_current_scene()
