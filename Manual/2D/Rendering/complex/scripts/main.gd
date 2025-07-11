extends Node2D

func _ready() -> void:
	$AudioStreamPlayer.volume_db = -10.0
	$AudioStreamPlayer.play()

func _on_complex_polynomial_roots_button_pressed() -> void:
	$SinglePolynomial.show()
	$LittlewoodPolynomials.hide()
	$Credits.hide()
	$ComplexPolynomialRootsButton.hide()
	$LittlewoodPolynomialRootsButton.hide()
	$AnimatedSprite2D.hide()

func _on_littlewood_polynomial_roots_button_pressed() -> void:
	$SinglePolynomial.hide()
	$LittlewoodPolynomials.show()
	$Credits.hide()
	$ComplexPolynomialRootsButton.hide()
	$LittlewoodPolynomialRootsButton.hide()
	$AnimatedSprite2D.hide()
	
func _on_music_pressed() -> void:
	if $Music.modulate != Color(1, 0, 0, 1):
		$Music.modulate = Color(1, 0, 0, 1)
		$AudioStreamPlayer.volume_db = -80.0  # Praticamente mudo
	else:
		$Music.modulate = Color(1, 1, 1, 1)
		$AudioStreamPlayer.volume_db = -10.0
