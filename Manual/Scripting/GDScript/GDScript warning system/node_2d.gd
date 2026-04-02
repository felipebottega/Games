extends Node2D


func _ready() -> void:
	@warning_ignore("unused_variable")
	var x = 123

func _process(_delta: float) -> void:
	var x = 1
	print(x)
	
	@warning_ignore_start("unused_variable")
	var y = 2
	var z = 3
	@warning_ignore_restore("unused_variable")
	
	
@warning_ignore_start("shadowed_variable", "unused_variable", "unused_parameter")
var t
	
func _physics_process(delta: float) -> void:
	var x = 1
	print(x)

func foo(x, y, z):
	var t = 2
	print(x + y + t)
