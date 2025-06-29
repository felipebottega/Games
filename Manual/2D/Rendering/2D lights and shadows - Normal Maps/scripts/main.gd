extends Node2D

func _process(delta):
	# Pega a posição global do mouse em relação à viewport
	var mouse_pos = get_viewport().get_mouse_position()
	$PointLight2D.global_position = mouse_pos
	
	# Clariadde inicial da viewport (determina o default do escura das sombras).
	modulate = Color($HUD/ShadowSlider.value, $HUD/ShadowSlider.value, $HUD/ShadowSlider.value)
	
	# Parâmetros de iluminação.
	$PointLight2D.texture_scale = $HUD/ScaleSlider.value
	$PointLight2D.energy = $HUD/EnergySlider.value
	$PointLight2D.height = $HUD/HeightSlider.value

func _on_cube_button_pressed():
	$Cube.show()
	$Wolverine.hide()
	$Bikini.hide()
	$Naruto.hide()
	$StellarBlade.hide()
	$RPGMaker.hide()

func _on_wolverine_button_pressed():
	$Cube.hide()
	$Wolverine.show()
	$Bikini.hide()
	$Naruto.hide()
	$StellarBlade.hide()
	$RPGMaker.hide()

func _on_bikini_button_pressed():
	$Cube.hide()
	$Wolverine.hide()
	$Bikini.show()
	$Naruto.hide()
	$StellarBlade.hide()
	$RPGMaker.hide()

func _on_naruto_button_pressed():
	$Cube.hide()
	$Wolverine.hide()
	$Bikini.hide()
	$Naruto.show()
	$StellarBlade.hide()
	$RPGMaker.hide()
	
func _on_stellar_blade_button_pressed():
	$Cube.hide()
	$Wolverine.hide()
	$Bikini.hide()
	$Naruto.hide()
	$StellarBlade.show()
	$RPGMaker.hide()

func _on_rpg_maker_button_pressed():
	$Cube.hide()
	$Wolverine.hide()
	$Bikini.hide()
	$Naruto.hide()
	$StellarBlade.hide()
	$RPGMaker.show()
	
