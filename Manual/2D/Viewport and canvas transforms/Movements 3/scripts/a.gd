extends Sprite2D

var speed: float = 1

func _process(delta):
	rotation += speed * delta
