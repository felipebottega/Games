extends Node2D


func _ready():
	$Button1.grab_focus.call_deferred()
	$FlowContainer/Button1.grab_focus.call_deferred()
