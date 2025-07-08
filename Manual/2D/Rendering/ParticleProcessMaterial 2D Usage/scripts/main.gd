extends Node2D

var animation_sequence := ["walk", "walk", "walk", "walk", "stand", "stand", "stand", "walk", "walk", "crouch", "liedown"]
var current_index := 0
var cray_init_pos = Vector2(800, 70)
var fix_pos = true    # gambiarra para deslocar uma animação alguns pixels par a direita

func _ready() -> void:
	modulate = Color(0.4, 0.4, 0.4)
	$Cray.position = cray_init_pos
	play_next_animation()
	
func _process(delta):
	if current_index < 4:
		$Cray.position.x += -38 * delta
	elif current_index == 7 or current_index == 8:
		$Cray.position.x += -32 * delta
	if current_index == 10 and fix_pos:
		$Cray.position.x += 2
		fix_pos = false

func play_next_animation():
	if current_index < animation_sequence.size():
		$Cray/AnimatedSprite2D.play(animation_sequence[current_index])

func _on_animated_sprite_2d_animation_finished():
	current_index += 1
	play_next_animation()
