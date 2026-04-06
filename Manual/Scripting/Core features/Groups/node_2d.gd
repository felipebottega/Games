extends Node2D


func _ready() -> void:
	var scene: PackedScene = load("res://pink.tscn")
	var instance := scene.instantiate()
	add_child(instance)

	for node in get_tree().current_scene.get_children():
		print(node.name, " -> ", node.get_groups())
