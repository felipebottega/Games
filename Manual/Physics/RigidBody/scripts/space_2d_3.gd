extends Node2D

var speed = 2000
var ccd = false
var make_sound = true
var block_scene: PackedScene = preload("res://scenes/ball.tscn")

func _physics_process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and get_global_mouse_position().y > 100:
		spawn_ball()
		
func spawn_ball():
	var viewport_dims = get_viewport_rect().size
	var pos_x = 10
	var pos_y = viewport_dims.y/2.0
	var instance = block_scene.instantiate()
	instance.position = Vector2(pos_x, pos_y)
	instance.linear_velocity = speed * (get_global_mouse_position() - Vector2(pos_x, pos_y)).normalized()
	instance.continuous_cd = ccd
	add_child(instance)
	
	play_sound()
		
	await get_tree().create_timer(10).timeout
	instance.queue_free()
	
func play_sound():
	if make_sound:
		$AudioStreamPlayer.play()
		make_sound = false
		await get_tree().create_timer(0.03).timeout
		make_sound = true

func _on_speed_h_slider_value_changed(value: float) -> void:
	speed = value
	$SpeedLabel.text = "Speed = " + str(value)

func _on_continuous_check_box_toggled(toggled_on: bool) -> void:
	ccd = 1 if toggled_on else 0
