extends Sprite2D

var speed: float = 1

func _ready():
	modulate = Color(0.7, 1, 0.7)

func _process(delta):
	rotation += speed * delta
