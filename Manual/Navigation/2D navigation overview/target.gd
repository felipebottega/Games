extends Sprite2D

@export var radius = 100.0
@export var speed = 0.5
var screen_size
var t = 0

func _ready() -> void:
	screen_size = get_viewport().size

func _physics_process(delta: float) -> void:
	t += delta * speed
	position.x = screen_size.x/2 + radius * sin(t)
	position.y =  screen_size.y/2 + radius * cos(t)
