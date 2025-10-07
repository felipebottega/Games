extends Sprite2D

var time = 0
var position_orig 

func _ready() -> void:
	position_orig = position

func _physics_process(delta: float) -> void:
	time += delta
	position.y = position_orig.y + sin(5 * time)
