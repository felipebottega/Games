extends Node2D

var trigger_area
signal room_change

func _ready():
	trigger_area = $Area2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):  # garante que é o player
		room_change.emit(position.x)
