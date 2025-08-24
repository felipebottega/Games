extends AnimationTree

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	
	set("parameters/conditions/x", time > 5)
	set("parameters/conditions/y", time > 8)
	
