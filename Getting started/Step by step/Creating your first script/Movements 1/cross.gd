extends Sprite2D    # importa a classe Sprite2D

# Variáveis da classe devem vir logo após o extend e antes das funções.
var angular_speed = 3   
var grow = true
var pos_orig = position
var t = 0
var factor = 1
var scale_orig = scale

func _init():
	print(pos_orig)

# Esta função é chamada repetidamente a cada frame. A variável delta está em segundos e indica
# quanto tempo se passou desde o último frame. Enquanto a cena estiver rodando, esta função
# é chamada em um loop.
func _process(delta):
	rotation += angular_speed * delta
	position = pos_orig + 100 * Vector2(cos(t), sin(t))
	scale = factor * scale_orig
	
	if t > 2 * PI:
		t = 0
	else:
		t += delta
		
	if factor >= 2:
		grow = false
	elif factor <= 1:
		grow = true
		
	if grow:
		factor += delta
	else:
		factor -= delta
