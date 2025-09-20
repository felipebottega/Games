extends Node

var physics_instance : Node = null
var physics_scene : PackedScene = null

func load_physics_scene(path : String):
	physics_scene = load(path)
	physics_instance = physics_scene.instantiate()
	# Aqui você pode colocar em um viewport offscreen se quiser processar física antes
	#get_tree().root.add_child(physics_instance)  # opcional
