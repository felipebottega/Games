extends Label

func _on_timer_timeout() -> void:
	modulate = Color(randf(), randf(), randf(), 1)
