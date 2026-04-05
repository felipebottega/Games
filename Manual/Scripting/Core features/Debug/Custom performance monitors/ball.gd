extends Node2D


func _ready() -> void:
	add_to_group("ball")

func _process(_delta: float) -> void:
	if global_position.y > get_viewport_rect().size.y:
		queue_free()
