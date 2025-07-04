extends CharacterBody2D

func _process(_delta):
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.stop()
