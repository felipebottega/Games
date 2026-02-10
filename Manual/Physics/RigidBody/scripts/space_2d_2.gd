extends Node2D


var instance
var gravity = 1.0
var lin_velocity_x = 0.0
var lin_velocity_y = 0.0
var damp_lin_velocity = 0.0
var ang_velocity = 0.0
var damp_ang_velocity = 0.0
var force_x = 0.0
var force_y = 0.0
var torque = 0.0
var center_mass_mode = 0
var center_mass_x = 0.0
var center_mass_y = 0.0


func _ready() -> void:
	$Camera2D.zoom = Vector2(0.95, 0.95)

func _on_gravity_h_slider_value_changed(value: float) -> void:
	gravity = value
	$HUD/GravityLabel.text = "Gravity = " + str(value)
	update_instance()

func _on_linear_velocity_xh_slider_value_changed(value: float) -> void:
	lin_velocity_x = value
	$HUD/LinearVelocityXLabel.text = "Linear Velocity.x = " + str(value)
	update_instance()

func _on_linear_velocity_yh_slider_value_changed(value: float) -> void:
	lin_velocity_y = value
	$HUD/LinearVelocityYLabel.text = "Linear Velocity.y = " + str(value)
	update_instance()

func _on_damp_linear_velocity_h_slider_value_changed(value: float) -> void:
	damp_lin_velocity = value
	$HUD/DampLinearVelocityLabel.text = "Damp Linear Velocity = " + str(value)
	update_instance()

func _on_angular_velocity_h_slider_value_changed(value: float) -> void:
	ang_velocity = value
	$HUD/AngularVelocityLabel.text = "Angular Velocity = " + str(value)
	update_instance()

func _on_damp_angular_velocity_h_slider_value_changed(value: float) -> void:
	damp_ang_velocity = value
	$HUD/DampAngularVelocityLabel.text = "Damp Angular Velocity = " + str(value)
	update_instance()

func _on_force_xh_slider_value_changed(value: float) -> void:
	force_x = value
	$HUD/ForceXLabel.text = "Force.x = " + str(value)
	update_instance()

func _on_force_yh_slider_value_changed(value: float) -> void:
	force_y = value
	$HUD/ForceYLabel.text = "Force.y = " + str(value)
	update_instance()

func _on_torque_h_slider_value_changed(value: float) -> void:
	torque = value
	$HUD/TorqueLabel.text = "Torque = " + str(value)
	update_instance()
	
func _on_center_of_mass_x_label_h_slider_value_changed(value: float) -> void:
	center_mass_x = value
	$HUD/CenterOfMassXLabel.text = "Center of Mass.x = " + str(value)
	update_instance()
	
func _on_center_of_mass_y_label_h_slider_value_changed(value: float) -> void:
	center_mass_y = value
	$HUD/CenterOfMassYLabel.text = "Center of Mass.y = " + str(value)
	update_instance()

func _on_play_pressed() -> void:
	for node in get_tree().current_scene.get_children():
		if node is RigidBody2D:
			node.queue_free()

	var viewport_dims = get_viewport_rect().size
	var block_scene: PackedScene = load("res://scenes/block_2.tscn")
	instance = block_scene.instantiate()
	instance.position = Vector2(viewport_dims.x / 2.0, 0.0)
	update_instance()
	
	add_child(instance)

func _on_reset_pressed() -> void:
	get_tree().reload_current_scene()

func update_instance():
	if instance != null:
		instance.gravity_scale = gravity
		instance.linear_velocity = Vector2(lin_velocity_x, lin_velocity_y)
		instance.linear_damp = damp_lin_velocity
		instance.angular_velocity = ang_velocity
		instance.angular_damp = damp_ang_velocity
		instance.constant_force = Vector2(force_x, force_y)
		instance.constant_torque = torque
		
		if center_mass_x == 0 and center_mass_y == 0:
			instance.center_of_mass_mode = 0
		else:
			instance.center_of_mass_mode = 1
			instance.center_of_mass = Vector2(center_mass_x, center_mass_y)
