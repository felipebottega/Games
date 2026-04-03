extends Sprite2D

var t: float = 0.0


func _process(delta: float) -> void:
	t += delta
	modulate = Color(sin(PI * t/(t+1)), cos(t), 1.0)
	rotation = t
