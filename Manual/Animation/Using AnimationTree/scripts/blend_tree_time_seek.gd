extends AnimationTree

func _ready() -> void:
	# Play child animation from 4 second timestamp.
	set("parameters/TimeSeek/seek_request", 1.5)
