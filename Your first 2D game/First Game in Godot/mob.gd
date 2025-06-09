extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# We play the animation and randomly choose one of the three animation types.
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()

# The last piece is to make the mobs delete themselves when they leave the screen. Connect the 
# screen_exited() signal of the VisibleOnScreenNotifier2D node to the Mob and add this code.
# queue_free() is a function that essentially 'frees', or deletes, the node at the end of the frame.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
