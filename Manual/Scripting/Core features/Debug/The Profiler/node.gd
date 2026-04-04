extends Node

var s: int = 0
var t: float = 0.0


func _ready() -> void:
	var result: float = 0.0
	var start = Time.get_ticks_msec()
	
	for i in range(1, 999999):
		result += 1.0/i 
		
	var end = Time.get_ticks_msec()
	var loop_time = (end-start)/100.0

	print("Loop time: {0} seconds".format([loop_time]))
	print("Result = {0}".format([result]))

func _process(delta: float) -> void:
	s += 1
	#breakpoint
	
	if s % 2 == 0:
		foo(delta)
		
func foo(x: float):
	t += x**2
	#print([s, t])
