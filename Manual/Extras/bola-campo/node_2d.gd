extends Node2D

func _process(_delta):
	$Label.scale = Vector2(3, 3)
	
	if areas_intersectam():
		$Label.text = "Dentro"
		$Label.modulate = Color(0, 1, 0, 1)
	else:
		$Label.text = "Fora"
		$Label.modulate = Color(1, 0, 0, 1)

func areas_intersectam() -> bool:
	return $Campo/Area2D.get_overlapping_areas().has( $Bola/Area2D)
