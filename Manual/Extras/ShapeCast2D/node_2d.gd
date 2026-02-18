extends Node2D


var dragging_body: Node2D = null
var offset := Vector2.ZERO


func _physics_process(delta: float) -> void:
	$ShapeCast2D.force_shapecast_update()
	var colliding = $ShapeCast2D.is_colliding()
	var count = $ShapeCast2D.get_collision_count()
	$ShapeCast2D.force_shapecast_update()
	
	#$Line2D.clear_points()
	#$Line2D.add_point($ShapeCast2D.global_position)
	#$Line2D.add_point($ShapeCast2D.to_global($ShapeCast2D.target_position))
	
	var text = ''
	
	if count > 1:
		for i in count:
			var point = $ShapeCast2D.get_collision_point(i)
			var collider = $ShapeCast2D.get_collider(i)
			print([i, colliding, point, collider])
			text += "colliding = {0}\npoint = {1}\ncollider = {2}\n".format([colliding, point, collider])
		print('\n')
		
	$Label.text = text
	$ShapeCast2D.force_shapecast_update()
	$ShapeCast2D.rotate(delta)
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		
		if event.pressed:
			# verifica qual corpo está sob o mouse
			var mouse_pos = get_global_mouse_position()
			
			for body in get_children():
				if body is PhysicsBody2D:
					if body.get_global_transform().origin.distance_to(mouse_pos) < 10:
						dragging_body = body
						offset = body.global_position - mouse_pos
						break
		else:
			dragging_body = null

func _process(delta):
	if dragging_body:
		dragging_body.global_position = get_global_mouse_position() + offset
