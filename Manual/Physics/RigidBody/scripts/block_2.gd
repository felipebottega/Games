extends RigidBody2D

var make_sound = true

func _on_body_shape_entered(_body_rid: RID, _body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	if make_sound:
		$AudioStreamPlayer.play()
		make_sound = false
		await get_tree().create_timer(0.5).timeout
		make_sound = true
	
