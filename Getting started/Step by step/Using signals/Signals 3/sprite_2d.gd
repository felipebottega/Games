# Apesar do nome, os scripts são como classes. Abaixo você define atributos e depois métodos.
extends Sprite2D

# Variáveis colocadas logo depois do extend e antes das funções viram atributos da classe.
var speed = 400
var angular_speed = PI    # ângulos sempre em radianos

# A função _init é especial em GDSCript, ela sempre é chamada automaticamente.
func _init():    
	print("Iniciando...")
	
# Também é uma função nativa do Godot. Essas funções são chamadas de 'funções virtuais' do Godot e 
# sempre começam com um underline. Elas sempre são chamadas automaticamente.
func _process(delta):
	# delta é o tempo que passou desde o último frame, é uma variável nativa desta função
	# a cada 1 segundo o objeto gira PI radianos (ou 180 graus)
	rotation += angular_speed * delta    # rotation também é uma variável nativa
	
	var velocity = Vector2.UP.rotated(rotation) * speed    # vetor 2D contendo a posição do objeto
	position += velocity * delta

func apertou_botao():
	set_process(not is_processing())
