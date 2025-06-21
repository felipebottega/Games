extends Area2D


func apply_shake(shaking):
	if shaking:
		get_viewport().canvas_transform.origin[0] = randf_range(-10, 10)
		get_viewport().canvas_transform.origin[1] = randf_range(-10, 10)
				
		for body in get_overlapping_bodies():
			if body is RigidBody2D:
				body.apply_force(Vector2(randf_range(-500, 500), randf_range(0, -200)))
	else:
		get_viewport().canvas_transform.origin[0] = 0
		get_viewport().canvas_transform.origin[1] = 0
