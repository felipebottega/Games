extends Node2D


# NORMAL COMMENT
# ALERT, ATTENTION, CAUTION, CRITICAL, DANGER, SECURITY
# BUG, DEPRECATED, FIXME, HACK, TASK, TBD, TODO, WARNING
# INFO, NOTE, NOTICE, TEST, TESTING

## This comment will appear in the script documentation.
var value: float

## This comment will appear in the inspector.
@export var exported_value = 1.0

var milliseconds: int = 15000

var seconds: int:
	get:
		print('Acessando seconds, é igual a ', str(milliseconds / 1000))
		return milliseconds / 1000
	set(value):
		print('Alterando o valor de seconds para ', str(value), ', miliseconds foi alterado para ', str(value * 1000))
		milliseconds = value * 1000


## Function comment test.
func foo() -> int:
	var x = 1
	var y = 2
	return x + y

#region Some description that is displayed even when collapsed
func foo2() -> int:
	var z = foo()
	return z
	
func foo3() -> void:
	value = 1
#endregion

#region callable example
func _ready() -> void:
	var my_array = [0, 1, 2, 3]

	for i in my_array:
		print(map(i, add1))
	
	print([milliseconds, seconds])
	seconds = 1
	print([milliseconds, seconds])
	seconds = 2
	milliseconds = 9000
	print([milliseconds, seconds])
		
func add1(value: int) -> int:
	return value + 1;

func map(item: int, function: Callable) -> int:
	var result = function.call(item)
	return result
#endregion
