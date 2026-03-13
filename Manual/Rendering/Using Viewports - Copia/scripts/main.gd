extends Node2D


func _on_example_1_pressed() -> void:
	free_scene()
	load_scene("first_example")

func _on_example_2_pressed() -> void:
	free_scene()
	load_scene("second_example")

func _on_example_3_pressed() -> void:
	free_scene()
	load_scene("third_example")

func free_scene():
	var viewport = $SubViewportContainer/SubViewport
	
	for child in viewport.get_children():
		child.queue_free()
		
func load_scene(name):
	var scene = load("res://scenes/%s.tscn" % name)
	var instance = scene.instantiate()
	$SubViewportContainer/SubViewport.add_child(instance)
	
