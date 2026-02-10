extends Node2D


var ballsize = 10.0
var ballmass = 1.0
const BASE_RADIUS := 10.0
const BASE_SPRITE_SCALE := 0.08
@export var n = 10


func _ready() -> void:
	$Camera2D.zoom = Vector2(0.5, 0.5)
	var viewport_dims = get_viewport_rect().size
	var block_scene: PackedScene = preload("res://scenes/block.tscn")
	
	for i in range(1, n-1):
		for j in range(2, n):
			var pos_x = i * viewport_dims.x/n
			var pos_y = j * viewport_dims.y/n
			var instance = block_scene.instantiate()
			instance.position = Vector2(pos_x, pos_y)
			add_child(instance)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var ball_scene: PackedScene = load("res://scenes/ball.tscn") 
			var viewport_dims = get_viewport_rect().size
			var instance = ball_scene.instantiate()
			instance.position = Vector2(viewport_dims.x/2.0, -viewport_dims.y * 0.8)
			instance.mass = ballmass
			instance.get_node("CollisionShape2D").shape = instance.get_node("CollisionShape2D").shape.duplicate()
			instance.get_node("CollisionShape2D").shape.radius = ballsize
			instance.get_node("Sprite2D").scale = Vector2.ONE * (ballsize / BASE_RADIUS) * BASE_SPRITE_SCALE
			add_child(instance)

func _on_size_h_slider_value_changed(value: float) -> void:
	ballsize = value
	$HUD/SizeLabel.text = "Size = " + str(value)

func _on_mass_h_slider_value_changed(value: float) -> void:
	ballmass = value
	$HUD/MassLabel.text = "Mass = " + str(value) + " kg"

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
