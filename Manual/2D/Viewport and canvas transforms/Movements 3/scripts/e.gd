extends Sprite2D

var speed: float = 1

func _ready():
	modulate = Color(0.7, 0.5, 1)

func _process(delta):
	rotation += speed * delta
