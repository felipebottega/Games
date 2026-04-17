extends Node


var player: AudioStreamPlayer


func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = load("res://music/cave themeb4.ogg")
	player.volume_db = -10
	player.play()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://main.tscn")
