extends RigidBody2D

var prev_velocity := Vector2.ZERO

func _physics_process(_delta):
	prev_velocity = linear_velocity
