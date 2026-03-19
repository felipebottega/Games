extends Node


func _on_resolution_item_selected(index: int) -> void:
	var res = $Resolution.get_item_text(index)
	var width = int(res.split('x')[0])
	var height = int(res.split('x')[1])
	$SubViewportContainer/SubViewport.size = Vector2i(width, height)
