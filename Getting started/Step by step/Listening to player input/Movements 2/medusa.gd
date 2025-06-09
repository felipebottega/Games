extends Node2D    # importa a classe Sprite2D

# Variáveis da classe devem vir logo após o extend e antes das funções.
var speed = 400    # pixels por segundo
var t = 0    # variável paramétrica (de 0 a 6*PI)
var orig_pos
var x = 0
var y = 0
var amplitude = 50

func _ready() -> void:
	orig_pos = position

# Esta função é chamada repetidamente a cada frame. A variável delta está em segundos e indica
# quanto tempo se passou desde o último frame. Enquanto a cena estiver rodando, esta função
# é chamada em um loop.
func _process(delta):
	x = orig_pos[0] - (orig_pos[0] + 30) * t / (6 * PI)
	y = orig_pos[1] + amplitude * sin(t)
	position = Vector2(x, y)
	
	if t >  6 * PI:
		t = 0
	else:
		t += 5 * delta
