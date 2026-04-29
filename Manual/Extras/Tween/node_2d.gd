extends Node2D


var tween
var sprite
var animation_names := {
	0: "Base",
	1: "Callback",
	2: "Transition",
	3: "Interval",
	4: "Method",
	5: "Ease",
	6: "Parallel",
	7: "Set Parallel",
	8: "Loops",
	9: "Bind Node",
	10: "Stop/Play",
	11: "Set Delay",
}

@export var animation: int = 0


func _ready() -> void:
	_on_spin_box_value_changed(0)

func play_animation(value):
	kill_tween()
	sprite = await new_sprite()
	print('criou sprite')
	
	animation = value
	tween = create_tween()
	print('criou tween ', value)
	
	match animation:
		0: # animação base
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
		1: # tween_callback
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
			tween.tween_callback(sprite.queue_free)
		2: # set_trans
			tween.tween_property(sprite, "modulate", Color.RED, 2.0).set_trans(Tween.TRANS_SINE)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 2.0).set_trans(Tween.TRANS_BOUNCE)
			tween.tween_property(sprite, "scale", Vector2.ONE, 2.0).set_trans(Tween.TRANS_BOUNCE)
		3: # tween_interval
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.tween_interval(1.0) # faz pausa
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
		4: # tween_method
			for i in 5:
				tween.tween_method(set_flash, 1.0, 0.0, 0.2)
				tween.tween_method(set_flash, 0.0, 1.0, 0.2)
		5: # set_ease
			tween.tween_property(sprite, "modulate", Color.RED, 1.0).set_ease(Tween.EASE_OUT)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0).set_ease(Tween.EASE_IN)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
		6: # parallel
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.parallel().tween_property(sprite, "scale", Vector2.ZERO, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
		7: # set_parallel
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.set_parallel(true)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
			tween.tween_property(sprite, "rotation_degrees", 180.0, 1.0)
			tween.chain().tween_property(sprite, "scale", Vector2.ONE, 1.0)
		8: # set_loops
			tween = tween.set_loops(3)
			tween.tween_property(sprite, "modulate", Color.RED, 0.5)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 0.5)
			tween.tween_property(sprite, "scale", Vector2.ONE, 0.5)
			tween.tween_property(sprite, "modulate", Color.WHITE, 0.5)
		9: # bind_node
			tween = tween.bind_node(sprite)
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
			tween.tween_callback(sprite.queue_free)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
		10: # stop e play
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
			await get_tree().create_timer(1.5).timeout
			tween.stop()
			await get_tree().create_timer(1.5).timeout
			tween.play()
		11: # set_delay
			tween.tween_property(sprite, "modulate", Color.RED, 1.0)
			tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0).set_delay(1)
			tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)

func new_sprite():
	for child in get_children():
		if "Sprite" in child.name:
			child.queue_free()
			
	await get_tree().process_frame
	
	var node = Sprite2D.new()
	node.texture = load("res://icon.svg")
	node.position = get_viewport_rect().size/2.0
	node.name = "Sprite2D"
	add_child(node)
	
	return node

func set_flash(amount: float) -> void:
	sprite.modulate = Color(1.0, amount, amount)
	
func kill_tween() -> void:
	if tween and tween.is_valid():
		tween.kill()

func _on_spin_box_value_changed(value: float) -> void:
	var anim_name =  animation_names[int(value)]
	$RichTextLabel.text = "[wave amp=50.0 freq=5.0 connected=1]{0}[/wave]".format([anim_name])
	play_animation(value)
