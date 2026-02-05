extends Node2D


func _on_button_pressed() -> void:
	for child in get_children():
		if child is CanvasItem:
			child.visible = false
	
	var scene = preload("res://fluid_simulation.tscn").instantiate()
	scene.circle_radius = int($CircleRadiusLineEdit.text)
	scene.fluid_tension_coefficient = int($FluidTensionCoefficientLineEdit.text)
	scene.fluid_viscosity_coefficient = int($FluidEffect2DViscosityArtificialLineEdit.text)
	scene.density_value = int($DensityLineEdit.text)
	add_child(scene)
