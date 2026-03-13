extends Sprite2D


var t = 0.0
var original_pos


func _ready() -> void:
	original_pos = position

func _process(delta: float) -> void:
	t += delta/5
	position = Vector2(original_pos.x + 400 * sin(6*t)**2, original_pos.y + 400 * cos(t)**3)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and scale.x != 2.0:
		scale = Vector2(2.0, 2.0)
	elif event is InputEventMouseButton and event.pressed:
		scale = Vector2(1.0, 1.0)
