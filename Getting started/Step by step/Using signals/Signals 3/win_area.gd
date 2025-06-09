extends Area2D

var num_balls
signal ganhou

func _physics_process(delta):
	num_balls = len(get_overlapping_bodies()) - 2
	
	if num_balls == 36:
		var total_velocity := 0.0
		
		for body in get_overlapping_bodies():
			if body is RigidBody2D:
				total_velocity += abs(body.linear_velocity.x)
				
		if total_velocity < 0.1:
			ganhou.emit()
