extends Area2D


var velocity = 100 * Vector2.RIGHT


func _physics_process(delta):
	position += velocity * delta
