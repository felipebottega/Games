extends Node


var thread: Thread


# The thread will start here.
func _ready():
	var c = soma.bind(10, 20)
	c.call(1)

func soma(a, b, c):
	print(a + b + c)
