extends Sprite2D

var i = 0
var dx = 0.0
var dy = 0.0

func _physics_process(delta: float) -> void:
		if i % 30 == 0:
			if randf() > 0.5:
				dx = randf_range(-10, 10)
				dy = randf_range(-10, 10)
		position += Vector2(dx, dy) * delta
		i += 1
