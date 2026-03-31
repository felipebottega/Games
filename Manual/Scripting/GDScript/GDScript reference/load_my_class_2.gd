extends Node2D

var MyClass = load("res://my_class.gd")
var my_class_instance = MyClass.new()

func _ready() -> void:
	print('Parent VALUE = ', my_class_instance.VALUE)
	print('Parent func output = ', my_class_instance.compute_sum())
