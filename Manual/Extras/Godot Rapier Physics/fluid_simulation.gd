extends Node2D

var circle_radius
var fluid_tension_coefficient
var fluid_viscosity_coefficient
var density_value

func _ready() -> void:
	$Fluid2D.circle_radius = circle_radius
	$Fluid2D.fluid_tension_coefficient = fluid_tension_coefficient
	$Fluid2D.fluid_viscosity_coefficient = fluid_viscosity_coefficient
	$Fluid2D.density_value = density_value
	$Fluid2D.wait = false

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
