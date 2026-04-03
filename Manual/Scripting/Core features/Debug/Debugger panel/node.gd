extends Node

var s: int = 0
var t: float = 0.0


func _process(delta: float) -> void:
	s += 1
	#breakpoint
	
	if s % 2 == 0:
		foo(delta)
		
func foo(x: float):
	t += x**2
	#print([s, t])
	
	
