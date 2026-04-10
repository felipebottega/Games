extends Node2D


@onready var screen_size
@onready var ball: PackedScene = preload("res://scenes/ball.tscn")
@onready var obstacle1: PackedScene = preload("res://scenes/obstacle_1.tscn")
@onready var obstacle2: PackedScene = preload("res://scenes/obstacle_2.tscn")


func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size
	
	for i in range(10):
		var pos_x = randf_range(20, screen_size.x - 20)
		var pos_y = randf_range(screen_size.y/3.0, screen_size.y)
		var obstacle_instance = null
		
		if i % 2 == 0:
			obstacle_instance = obstacle1.instantiate()
		else:
			obstacle_instance = obstacle2.instantiate()
		
		obstacle_instance.position = Vector2(pos_x, pos_y)
		obstacle_instance.scale = Vector2(randf_range(-1, 1), randf())
		add_child(obstacle_instance)
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var ball_instance = ball.instantiate()
			ball_instance.position = get_global_mouse_position()
			add_child(ball_instance)
			ball_instance.name = ball_instance.name + str(randi())

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
