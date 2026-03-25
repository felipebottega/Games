extends CharacterBody2D


const SPEED = 300.0
var t = 0


func _physics_process(delta: float) -> void:
	$Node2D.scale.x = -1 if sin(t * delta) > 0 else 1
	velocity.x = sin(t * delta) * SPEED
	velocity.y = sin(t * delta) * SPEED
	move_and_slide()
	t += 0.1
