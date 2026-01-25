extends Node

var thread := Thread.new()
var semaphore := Semaphore.new()
var exit_thread := false


func _ready():
	thread.start(_thread_function)
	
func _input(event):
	# Thread principal.
	if event.is_action_pressed("ui_accept"):
		print("Main: liberando 1 trabalho")
		semaphore.post()

func _thread_function():
	# Thread secundária.
	while true:
		print("Thread: esperando sinal...")
		
		# Dorme aqui até alguém chamar post(). O loop não continua, fica tudo parado neste ponto.
		semaphore.wait()
		
		if exit_thread:
			print("Thread: encerrando")
			break
		
		print("Thread: trabalhando!")
		
func _exit_tree():
	exit_thread = true    # avisa a thread para sair
	semaphore.post()    # acorda a thread caso esteja dormindo
	thread.wait_to_finish()    # aguarda o término da thread para finalizar
