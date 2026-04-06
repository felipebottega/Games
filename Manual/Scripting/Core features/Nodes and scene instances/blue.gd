extends Node2D


func _ready() -> void:
	var parent = get_node("..")
	#print(parent)
	var parent2 = get_node(".")
	#print(parent2)
	var parent3 = get_node("/root")
	#print(parent3)
	var parent4 = get_node("/root/Node2D")
	#print(parent4)
	#print(parent == parent4)
	var parent5 = get_node("/root/Node2D")
	#var parent2 = $. 
