extends Sprite2D

var speed: float = 1

func _ready():
	modulate = Color(0.6, 1, 1)

func _process(delta):
	rotation += speed * delta
