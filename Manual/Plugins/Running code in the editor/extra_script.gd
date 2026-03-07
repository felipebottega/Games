@tool
extends EditorScript

func _run() -> void:
		get_scene().get_node("Sprite2D").scale = Vector2(2, 2)
