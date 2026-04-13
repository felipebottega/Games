extends Node2D


var t = 0.0


func _process(delta: float) -> void:
	t += delta
	RenderingServer.global_shader_parameter_set("my_global_uniform", cos(t))
	
