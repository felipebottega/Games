extends Node2D

var s: int = 0
var t: float = 0.0

func _ready() -> void:
	breakpoint 

func _process(delta: float) -> void:
	s += 1
	
	if s % 2 == 0:
		foo(delta)
		
func foo(x: float):
	t += x**2
	print([s, t])
	
	
