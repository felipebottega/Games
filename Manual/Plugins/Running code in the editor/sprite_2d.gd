@tool
extends Sprite2D


@export var speed: float = 1.0:
	# Update speed and reset the rotation.
	set(new_speed):
		speed = new_speed
		rotation = 0
			

func _process(delta):
	if Engine.is_editor_hint():
		rotation += PI * delta * speed
	else:
		rotation -= PI * delta * speed
		
