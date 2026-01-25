extends Node

var thread: Thread

func _ready():
	# A thread será criada e iniciada aqui.
	thread = Thread.new()
	
	# É possível usar bind() para fixar um ou mais argumentos que serão passados para a função 
	# executada pela thread.
	thread.start(_thread_function.bind("123456789"))

func _thread_function(userdata):
	# Esta função é executada dentro da thread. O argumento recebido vem do bind() usado no start().
	print("I'm a thread! Userdata is: ", userdata)

func _exit_tree():
	# A thread deve ser finalizada corretamente ao sair da cena. A chamada wait_to_finish() bloqueia 
	# até a thread terminar sua execução, evitando problemas de concorrência.
	thread.wait_to_finish()
