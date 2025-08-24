extends AnimationTree

func _ready() -> void:
	# Play child animation connected to "shot" port.
	set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	# Abort child animation connected to "shot" port.
	#set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)

	# Get current state (read-only).
	#get("parameters/OneShot/active")
