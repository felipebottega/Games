extends Sprite2D


var speed: float = 2.0


func _physics_process(_delta: float) -> void:
	position.x += speed
	
