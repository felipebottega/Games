extends Node2D


func _ready() -> void:
	var bloco_scene: PackedScene = load("res://blocks.tscn")
	var a = bloco_scene.instantiate()
	var b = bloco_scene.instantiate()
	a.global_position = Vector2(60, 180)
	b.global_position = Vector2(260, 180)
	a.get_node("Sprite2D").scale = Vector2(1, 2)
	a.get_node("CollisionShape2D").shape.size = Vector2(64, 32)
	b.get_node("Sprite2D").scale = Vector2(2, 1.2)
	b.get_node("CollisionShape2D").shape.size = Vector2(128, 20)
	add_child(a)
	add_child(b)
