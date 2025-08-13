extends Node2D

var time = 0.0
var duration = 1.0
var active = false

func crazy_sword():
	time = 0.0
	active = true
	set_process(true)

func _process(delta):
	if active:
		time += delta
		if time <= duration:
			$Sprite2D.modulate = Color(randf(), randf(), randf())
		else:
			active = false
			set_process(false)
  
