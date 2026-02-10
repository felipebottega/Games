extends RigidBody2D

var aligned := false

func _physics_process(_delta):
	if sleeping and not aligned:
		global_position = global_position.snapped(Vector2(8, 8))
		gravity_scale = 1.0
		aligned = true

func _on_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.is_in_group("ball") and !$AudioStreamPlayer.playing:

		if body.prev_velocity.y > 100:
			$AudioStreamPlayer.play()
