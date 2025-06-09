extends Sprite2D    # importa a classe Sprite2D

# Variáveis da classe devem vir logo após o extend e antes das funções.
var angular_speed = 1   
var grow = true

# Esta função é chamada repetidamente a cada frame. A variável delta está em segundos e indica
# quanto tempo se passou desde o último frame. Enquanto a cena estiver rodando, esta função
# é chamada em um loop.
func _process(delta):
	rotation += angular_speed * delta
		
	if angular_speed >= 20 :
		grow = false
	elif angular_speed <= 0:
		grow = true
		
	if grow:
		angular_speed += 0.01
	else:
		angular_speed -= 0.01
