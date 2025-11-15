extends Node

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		print("is_action_pressed ui_down: ", Input.is_action_pressed("ui_down"))
	elif not Input.is_action_pressed("ui_down"):
		print("is_action_pressed ui_down: ", Input.is_action_pressed("ui_down"))
		
	if Input.is_action_just_pressed("ui_down"):
		print("is_action_just_pressed ui_down: ", Input.is_action_just_pressed("ui_down"))
	elif not Input.is_action_just_pressed("ui_down"):
		print("is_action_just_pressed ui_down: ", Input.is_action_just_pressed("ui_down"))

	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	print("get_vector: ", input_direction)
	
	var direction = Input.get_axis("ui_left", "ui_right")
	print("get_axis: ", direction)
