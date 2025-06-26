extends Sprite2D


func start_lifetime(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	queue_free()
