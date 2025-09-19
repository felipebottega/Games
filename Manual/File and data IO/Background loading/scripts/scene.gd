extends Node2D

var wait

func _ready() -> void:
	wait = true
	SmokeBig.visible = false
	Smoke.visible = true
	Ball.visible = true
	Fireworks.visible = true
	Sparkles.visible = true

func _process(delta: float) -> void:
	if wait and $Ball.position.y > 0:
		wait = false
		Hud.get_node("Label3").text = 'FINISH: ' + Globals.log_delta()
