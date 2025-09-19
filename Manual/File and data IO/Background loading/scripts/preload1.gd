extends Node2D

var scene = preload("res://scenes/scene.tscn")

func _ready() -> void:
	print('Preload1')
	SmokeBig.global_position = Vector2(0, 0)
	Hud.get_node("Label").text = 'START: ' +  Globals.log_delta()

func _on_timer_timeout() -> void:
	Hud.get_node("Label2").text = 'TIMER: ' +  Globals.log_delta()
	get_tree().change_scene_to_packed(scene)
