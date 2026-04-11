extends Node2D


func _ready() -> void:
	var scene = load("res://node.tscn")
	get_tree().root.add_child.call_deferred(scene.instantiate())
	
	print('get_tree(): ', get_tree())
	print('get_tree().root: ', get_tree().root)
	print('get_tree().paused: ', get_tree().paused)
	print('get_tree().current_scene: ', get_tree().current_scene)
	print('get_tree().physics_interpolation: ', get_tree().physics_interpolation )
	print('==================================================')
	print('get_tree().call_group(): ', get_tree().call_group)
	print('get_tree().get_nodes_in_group(): ', get_tree().get_nodes_in_group)
	print('get_tree().get_node_count_in_group(): ', get_tree().get_node_count_in_group)
	print('get_tree().has_group(): ', get_tree().has_group)
	print('get_tree().notify_group(): ', get_tree().notify_group)
	print('get_tree().set_group(): ', get_tree().set_group)
	print('--------------------------------------------------')
	print('get_tree().change_scene_to_file(): ', get_tree().change_scene_to_file)
	print('get_tree().change_scene_to_node(): ', get_tree().change_scene_to_node)
	print('get_tree().change_scene_to_packed(): ', get_tree().change_scene_to_packed)
	print('get_tree().create_timer(): ', get_tree().create_timer)
	print('get_tree().get_frame(): ', get_tree().get_frame)
	print('get_tree().get_node_count(): ', get_tree().get_node_count)
	print('get_tree().queue_delete(): ', get_tree().queue_delete)
	print('get_tree().quit(): ', get_tree().quit)
	print('get_tree().reload_current_scene(): ', get_tree().reload_current_scene)
	print('==================================================')
	print()
	
	print('get_tree().get_frame(): ', get_tree().get_frame())
	print('get_tree().get_node_count(): ', get_tree().get_node_count())
	
	
