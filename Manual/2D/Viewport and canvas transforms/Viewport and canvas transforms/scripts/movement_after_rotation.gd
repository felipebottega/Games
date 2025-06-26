extends Sprite2D

var speed = 100
var i = 0

func _process(delta):
	if i < 100:
		position += speed * delta * transform.x
	else:
		position += speed * delta * transform.y
	i += 1
	
	if i == 200:
		i = 0
