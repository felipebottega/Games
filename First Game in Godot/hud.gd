extends CanvasLayer

# Notifies `Main` node that the button has been pressed.
signal start_game

# We now want to display a message temporarily, such as "Get Ready".
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
# We also need to process what happens when the player loses. The code below will show "Game Over" 
# for 2 seconds, then return to the title screen and, after a brief pause, show the "Start" button.
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
# The code below HUD to updates the score.
func update_score(score):
	$ScoreLabel.text = str(score)

# Connect the pressed() signal of StartButton and the timeout() signal of MessageTimer to the HUD 
# node, and add the following code to the functions below.
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
