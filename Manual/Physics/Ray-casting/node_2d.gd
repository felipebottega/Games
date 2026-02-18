extends Node2D


func _physics_process(delta: float) -> void:
	var colliding = $RayCast2D.is_colliding()
	var point = $RayCast2D.get_collision_point()
	var collider = $RayCast2D.get_collider()
	
	$Line2D.clear_points()
	$Line2D.add_point($RayCast2D.global_position)
	$Line2D.add_point($RayCast2D.to_global($RayCast2D.target_position))
	
	print([colliding, point, collider])
	$Label.text = "colliding = {0}\npoint = {1}\ncollider = {2}".format([colliding, point, collider])
	$RayCast2D.rotate(delta)
