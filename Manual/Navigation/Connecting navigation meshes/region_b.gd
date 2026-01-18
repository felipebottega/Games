extends Sprite2D


var speed = 10.0


func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	position.x += speed  * direction * delta
