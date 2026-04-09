extends Node2D


func _ready() -> void:
	var trevor_scene: PackedScene = load("res://scenes/trevor.tscn")
	var trevor_instance: CharacterBody2D = trevor_scene.instantiate()
	trevor_instance.position = Vector2(10, 10)
	add_child(trevor_instance)
