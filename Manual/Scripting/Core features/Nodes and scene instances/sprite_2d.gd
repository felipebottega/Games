extends Sprite2D


func _ready() -> void:
	var parent = get_node(".")
	print([parent, parent == $"."])
	print()
	
	var parent2 = get_node("..")
	print([parent2, parent2 == $"..", parent2 == get_parent()])
	print()
	
	var parent3 = get_node("../..")
	print([parent3, parent3 == $"../..", parent3 == get_parent().get_parent()])
	print()
	
	var parent4 = get_node("../../..")
	print([parent4, parent4 == $"../../..", parent4 == get_parent().get_parent().get_parent()])
	print()
	
	var parent5 = get_node("../../Red/Sprite2D")
	print([parent5, parent5 == $"../../Red/Sprite2D"])
	print()
