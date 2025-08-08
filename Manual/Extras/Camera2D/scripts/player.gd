extends CharacterBody2D

const SPEED = 400.0
var TARGET    # coordenada onde o jogador clicou com o mouse

func _ready() -> void:
	TARGET = position
	$AnimatedSprite2D.play("idle")
	
func _input(event):
	if event.is_action_pressed("click"):
		TARGET = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(TARGET) * SPEED
	
	if position.distance_to(TARGET) > 10:
		move_and_slide()
		var dif = TARGET - global_position
		$AnimatedSprite2D.flip_h = dif.x < 0
		$AnimatedSprite2D.play("run")
	elif $AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("idle")
