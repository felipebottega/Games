class_name amazing2
extends Node


const VALUE: int = 1000

func _init(a: int):
	var b = compute_sum_with_parameter(a)
	print('b  = ', b)

func compute_sum_with_parameter(a) -> int:
	var s = 0
	
	for i in VALUE+1-a:
		s += i
		
	return s 
