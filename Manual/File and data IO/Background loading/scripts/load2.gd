extends Node2D

var scene

func _ready() -> void:
	print('Load2')
	SmokeBig.global_position = Vector2(0, 0)
	Hud.get_node("Label").text = 'START: ' + Globals.log_delta()
	scene = load("res://scenes/scene.tscn")

func _on_timer_timeout() -> void:
	Hud.get_node("Label2").text = 'TIMER: ' + Globals.log_delta()
	get_tree().change_scene_to_packed(scene)
