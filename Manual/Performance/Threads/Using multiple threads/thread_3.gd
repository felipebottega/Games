extends Node


func _ready():
	# Pergunta ao sistema operacional quantos núcleos de CPU existem (inclui hyper-threading).
	var cpu_count := OS.get_processor_count()
	print("CPUs disponíveis:", cpu_count)

	# Cria uma tarefa para cada CPU. Cada tarefa será executada em paralelo pelo WorkerThreadPool.
	for i in range(cpu_count):
		# Passamos uma função para o pool. Lembre que o bind(i) NÃO executa a função. Ele apenas 
		# "gruda" o valor de i como argumento da função. Se o segundo argumento for true, a tarefa é 
		# considerada de alta prioridade. Daí o pool tenta executá-la o quanto antes.
		WorkerThreadPool.add_task(_heavy_calculation.bind(i), true)

func _heavy_calculation(id):
	# Variável local usada apenas dentro desta thread.
	var sum = 0

	# Simula um cálculo pesado (CPU-bound). Esse loop NÃO trava o jogo, pois roda em outra thread.
	for i in range(40_000_000):
		sum += i

	# Mostra no console qual "job" terminou. Note que prints podem aparecer fora de ordem, pois as 
	# threads terminam em momentos diferentes.
	print("Job", id, "finalizado na thread")
