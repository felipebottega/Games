@tool
extends Sprite2D


@export var speed: float = 1.0:
	set(new_speed):
		speed = new_speed
		rotation = 0
			

func _process(delta):
	if Engine.is_editor_hint():    # apenas roda no editor
		rotation += PI * delta * speed
	else:    # apenas roda no jogo
		rotation -= PI * delta * speed
		
