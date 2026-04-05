extends Sprite2D


var speed: float = 2.0


func _process(delta: float) -> void:
	#position.x += speed # naive
	position.x += 60 * speed * delta # correct
	
