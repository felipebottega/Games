extends Node2D


var frame_count: int = 0
var ball: PackedScene = preload("res://ball.tscn")


func _ready() -> void:
	Performance.add_custom_monitor("game/ball_count", get_ball_count)

func _process(_delta: float) -> void:
	frame_count += 1
	var viewport_size = get_viewport_rect().size
	
	if frame_count % 10 == 0:
		var ball_instance: Node2D = ball.instantiate()
		ball_instance.position = Vector2(randf_range(0, viewport_size.x), 0.0)
		add_child(ball_instance)

func get_ball_count():
	return get_tree().get_nodes_in_group("ball").size()
