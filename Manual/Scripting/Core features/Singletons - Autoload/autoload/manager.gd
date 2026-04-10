extends Node


var winners: Array

@onready var screen_size


func _ready():
	screen_size = get_viewport().get_visible_rect().size
	
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_on_timeout)
	add_child(timer)

func _on_timeout():
	var scene = get_tree().current_scene
	traverse(scene)

func traverse(node: Node):
	if node is RigidBody2D:
		if node.name not in winners and node.global_position.y > screen_size.y:
			winners.append(node.name)
	
	if node != null:
		for child in node.get_children():
			traverse(child)
