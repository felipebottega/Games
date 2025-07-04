extends CharacterBody2D

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.stop()
