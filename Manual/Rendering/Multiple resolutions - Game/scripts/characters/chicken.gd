extends CharacterBody2D


const SPEED = 50.0
var t = randf_range(0, 10000)
var u = randf_range(0, 10000)


func _physics_process(delta: float) -> void:
	$Node2D.scale.x = -1 if sin(t * delta) > 0 else 1
	velocity.x = sin(t * delta) * SPEED + randf_range(-50, 50)
	velocity.y = sin(u * delta) * SPEED + randf_range(-50, 50)
	move_and_slide()
	t += 0.5
	u += 0.5
