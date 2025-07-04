extends CharacterBody2D

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.stop()
