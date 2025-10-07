extends Node2D

signal area

func _on_acceleration_area_body_entered(_body: Node2D) -> void:
	area.emit()
