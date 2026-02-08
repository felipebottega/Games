extends Node2D

var scene: PackedScene

func _ready() -> void:
	scene = preload("res://rigid_body_2d.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var instance = scene.instantiate() 
		instance.position = event.position
		add_child(instance)
		
		# O objeto é removido da cena após 10 segundos.
		await get_tree().create_timer(10.0).timeout
		instance.queue_free()
