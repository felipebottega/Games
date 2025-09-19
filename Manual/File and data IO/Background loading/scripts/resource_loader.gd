extends Node2D

var scene
var status

func _ready() -> void:
	print('ResourceLoader')
	SmokeBig.global_position = Vector2(0, 0)
	Hud.get_node("Label").text = 'START: ' + Globals.log_delta()
	ResourceLoader.load_threaded_request("res://scenes/scene.tscn")
	
func _process(_delta):
	status = ResourceLoader.load_threaded_get_status("res://scenes/scene.tscn")

func _on_timer_timeout() -> void:
	Hud.get_node("Label2").text = 'TIMER: ' + Globals.log_delta()
	
	if status == 3:
		scene = ResourceLoader.load_threaded_get("res://scenes/scene.tscn")
		get_tree().change_scene_to_packed(scene)
	else:
		print('A cena demorou muito para ser carregada. Abortando a execução.')
