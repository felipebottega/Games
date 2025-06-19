extends CanvasLayer


var step_value: float
signal start_game(step_value: float)    # notifies Main node that the button has been pressed

func update_num_balls(n):
	$Message.text = "Num balls = " + str(n)
	
func _on_start_pressed() -> void:
	$Start.hide()
	step_value = $StepSlider.value
	start_game.emit(step_value)

func _on_quit_pressed() -> void:
	get_tree().reload_current_scene()
