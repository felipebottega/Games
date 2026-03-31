extends Node2D

var my_class_instance = amazing.new()

func _ready() -> void:
	print('Parent VALUE = ', my_class_instance.VALUE)
	print('Parent func output = ', my_class_instance.compute_sum())
