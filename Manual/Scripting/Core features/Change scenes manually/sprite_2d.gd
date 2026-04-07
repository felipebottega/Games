extends Sprite2D


var factor := 1.0


func _process(delta: float) -> void:
	rotation += factor * delta
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		factor = 8.0
		await get_tree().create_timer(1.0).timeout
		factor = 1.0
