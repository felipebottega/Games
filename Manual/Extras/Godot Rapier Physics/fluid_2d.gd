extends Fluid2D

var circle_radius
var fluid_tension_coefficient
var fluid_viscosity_coefficient
var density_value
var wait = true

func _process(_delta: float) -> void:
	if not wait:
		if circle_radius == null:
			return
		if fluid_tension_coefficient == null:
			return 
		if fluid_viscosity_coefficient == null:
			return
		if density_value == null:
			return
			
		print('circle_radius = ', circle_radius)
		points = create_circle_points(circle_radius)
	
		for effect in effects:
			if effect is FluidEffect2DSurfaceTensionAKINCI:
				print('fluid_tension_coefficient = ', fluid_tension_coefficient)
				effect.fluid_tension_coefficient = fluid_tension_coefficient
			if effect is FluidEffect2DViscosityArtificial:
				print('fluid_viscosity_coefficient = ', fluid_viscosity_coefficient)
				effect.fluid_viscosity_coefficient = fluid_viscosity_coefficient
				
		print('density = ', density_value)
		density = density_value
		wait = true
		print()
