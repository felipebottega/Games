extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cached_scene := ResourceLoader.load_threaded_get("res://scenes/game/levels/level.tscn")
	get_tree().change_scene_to_packed(cached_scene)
