extends Node2D

@export var sprite_scene: PackedScene  # arraste SpriteScene.tscn aqui no inspetor

var time_passed := 0.0
@export var delay = 0.1
@export var factor_scale = 0.3
@export var seconds = 3

func _process(delta):
	time_passed += delta
	
	delay = $HUD/HSliderDelay.value
	factor_scale = $HUD/HSliderScale.value
	seconds = $HUD/HSliderSeconds.value
	$A/B/C/D/E.speed = $HUD/HSliderOrbitalSpeed.value 
	$A/B/C/D.speed = $HUD/HSliderOrbitalSpeed.value 
	$A/B/C.speed = $HUD/HSliderOrbitalSpeed.value 
	$A/B.speed = $HUD/HSliderOrbitalSpeed.value
	$A.speed = $HUD/HSliderCoreSpeed.value
	
	if time_passed >= delay:
		time_passed = 0.0
		
		for sprite in [$A/B/C/D/E, $A/B/C/D, $A/B/C, $A/B]:
			var new_sprite = sprite_scene.instantiate()
			var pos_d = sprite.global_position
			new_sprite.global_position = pos_d
			var global_scale = sprite.global_transform.get_scale()
			new_sprite.scale = factor_scale * global_scale
			new_sprite.modulate = sprite.modulate
			get_parent().add_child(new_sprite)
			new_sprite.start_lifetime(seconds)

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
