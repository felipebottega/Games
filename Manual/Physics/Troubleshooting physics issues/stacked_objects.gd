extends Node2D

@export var n: int = 100
var ball: PackedScene = preload("res://ball.tscn")

func _ready() -> void:
	var screen = get_viewport_rect().size 
	
	for i in range(n):
		var instance = ball.instantiate()
		instance.position = Vector2(randf() * screen.x, -10*randf() * screen.y)
		add_child(instance)
		
