extends Node

var thread: Thread
var result_ready = false
var result = 0

func _ready():
	thread = Thread.new()
	
	# Inicia a thread passando um número grande
	thread.start(_heavy_calculation.bind(100_000_000))

func _process(_delta):
	# Main thread continua rodando normalmente
	if result_ready:
		print("Resultado recebido da thread:", result)
		result_ready = false

func _heavy_calculation(n):
	var sum = 0
	
	for i in range(n):
		sum += i
		
	# Apenas salvar dados simples e sinalizar o main thread.
	result = sum
	result_ready = true

func _exit_tree():
	thread.wait_to_finish()
