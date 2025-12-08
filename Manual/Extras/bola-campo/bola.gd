extends Sprite2D

@export var speed = 100

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		position.x -= delta * speed
	if Input.is_action_pressed("ui_right"):
		position.x += delta * speed
	if Input.is_action_pressed("ui_down"):
		position.y += delta * speed
	if Input.is_action_pressed("ui_up"):
		position.y -= delta * speed
