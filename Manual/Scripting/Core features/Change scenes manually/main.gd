extends Node2D


var scene_1 = preload("res://scene_1.tscn")
var scene_2 = preload("res://scene_2.tscn")
var scene_3 = preload("res://scene_3.tscn")


func _ready() -> void:
	_add_a_scene_manually()

func _add_a_scene_manually():
	get_tree().root.add_child.call_deferred(scene_1.instantiate())
	get_tree().root.add_child.call_deferred(scene_2.instantiate())
	get_tree().root.add_child.call_deferred(scene_3.instantiate())
