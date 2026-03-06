@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	print('RODOU')
	get_scene().get_node("Sprite2D").scale = Vector2(2, 2)
	
