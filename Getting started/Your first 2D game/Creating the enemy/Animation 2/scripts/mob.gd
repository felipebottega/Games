extends CharacterBody2D


var factor = [10, 40, 90, 120, 150].pick_random()

func _ready() -> void:
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	position[0] += factor * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print($AnimatedSprite2D.animation, ' saiu da tela')
	queue_free()
