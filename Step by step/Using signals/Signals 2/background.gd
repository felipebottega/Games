extends Sprite2D

var orig_pos
var t = 0

func _ready():
	orig_pos = position
	
func _process(delta):
	position = Vector2(orig_pos[0] + 100 * sin(t), orig_pos[1]) 
	
	if t < 2 * PI:
		t += 0.0005
	else:
		t  = 0
