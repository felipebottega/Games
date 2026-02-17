extends CharacterBody2D

class_name Bullet

var direction

func _physics_process(delta):
	var motion = direction * delta
	var collision = move_and_collide(motion)
	
	if collision:
		direction = direction.bounce(collision.get_normal())
		
		# Aplica o restante do movimento refletido.
		move_and_collide(collision.get_remainder())
