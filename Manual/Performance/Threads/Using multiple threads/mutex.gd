extends Node


var counter = 0
var mutex: Mutex
var thread: Thread


func _ready():
	mutex = Mutex.new()
	thread = Thread.new()
	thread.start(_thread_function)

	mutex.lock()
	counter += 1
	mutex.unlock()
	
	thread.wait_to_finish()
	print("Counter is: ", counter)    # deve ser igual a 2

func _thread_function():
	mutex.lock()
	counter += 1
	mutex.unlock()
	
