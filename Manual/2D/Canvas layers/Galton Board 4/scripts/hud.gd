extends CanvasLayer


var step_value: float
var num_balls: int
var delay: float
var gravity: float
var bscale: float
signal start_game(step_value: float, num_balls: int, delay: float, gravity: float, bscale: float)
signal shake

func update_num_balls(n):
	$Message.text = "Num balls = " + str(n)
	
func _on_start_pressed() -> void:
	$Start.hide()
	step_value = $SliderPin.value
	num_balls = $SliderNumBalls.value
	delay = $SliderDelay.value
	gravity = $SliderGravity.value
	bscale = $SliderScale.value
	start_game.emit(step_value, num_balls, delay, gravity, bscale)

func _on_quit_pressed() -> void:
	get_tree().reload_current_scene()

func _on_shake_pressed():
	shake.emit()
