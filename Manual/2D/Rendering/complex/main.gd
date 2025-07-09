extends Node
'''
# Classe Complex
class Complex:
	var re: float
	var im: float

	func _init(r: float, i: float):
		re = r
		im = i

	func add(other: Complex) -> Complex:
		return Complex.new(re + other.re, im + other.im)

	func sub(other: Complex) -> Complex:
		return Complex.new(re - other.re, im - other.im)

	func mul(other: Complex) -> Complex:
		return Complex.new(re * other.re - im * other.im, re * other.im + im * other.re)

	func div(other: Complex) -> Complex:
		var denom = other.re * other.re + other.im * other.im
		if denom == 0:
			push_error("Divisão por zero em número complexo.")
			return Complex.new(0, 0)
		var num_re = re * other.re + im * other.im
		var num_im = im * other.re - re * other.im
		return Complex.new(num_re / denom, num_im / denom)

	func abs() -> float:
		return sqrt(re * re + im * im)

	func as_string() -> String:
		var s = "%.6f" % re
		s += " + %.6fi" % im if im >= 0 else " - %.6fi" % abs(im)
		return s

# Método de Horner para avaliar polinômio real em x complexo
func eval_polynomial(coefficients: Array, x: Complex) -> Complex:
	var result = Complex.new(coefficients[0], 0)
	for i in range(1, coefficients.size()):
		result = result.mul(x).add(Complex.new(coefficients[i], 0))
	return result

# Método de Durand–Kerner
func find_roots(coefficients: Array) -> Array:
	# O coeficiente líder tem que ser positivo para o algoritmo ficar estável.
	if coefficients[0] < 0:
		for i in range(coefficients.size()):
			coefficients[i] *= -1
			
	var n = coefficients.size() - 1
	var roots := []
	var angle_step = 2.0 * PI / n
	var epsilon = 0.05

	# Inicializa as raízes em torno do círculo unitário com leve ruído
	for i in range(n):
		var angle = angle_step * i + randf_range(-epsilon, epsilon)
		var r = 1.0 + randf_range(-epsilon, epsilon)
		roots.append(Complex.new(r * cos(angle), r * sin(angle)))

	var max_iter = 500
	var tol = 1e-6

	for iter in range(max_iter):
		var new_roots := []
		var converged = true

		for i in range(n):
			var x = roots[i]
			var fx = eval_polynomial(coefficients, x)
			var prod = Complex.new(1, 0)

			for j in range(n):
				if j != i:
					var diff = x.sub(roots[j])
					if diff.abs() < 1e-12:
						push_error("Raízes muito próximas na iteração %d (i=%d, j=%d)" % [iter, i, j])
						return []
					prod = prod.mul(diff)

			if prod.abs() < 1e-12:
				push_error("Denominador muito pequeno na iteração %d, índice %d" % [iter, i])
				return []

			var delta = fx.div(prod)
			var x_new = x.sub(delta)

			if x_new.sub(x).abs() > tol:
				converged = false

			new_roots.append(x_new)

		roots = new_roots

		if converged:
			print("Convergência em ", iter, " iterações.")
			break

		if iter == max_iter - 1:
			print("Atingiu o limite de iterações: ", max_iter)

	return roots
'''
# Testes
'''
func _ready():
	var coef = [1, 0, 0, -1]  # x^3 - 1
	var roots = find_roots(coef)
	for i in range(roots.size()):
		print("Raiz ", i + 1, ": ", roots[i].as_string())
		
	coef = [1, 1, -1,- 1, 1, -1, 1]  # x^6 + x^5 -x^4 - x^3 + x^2 - x + 1
	roots = find_roots(coef)
	for i in range(roots.size()):
		print("Raiz ", i + 1, ": ", roots[i].as_string())
'''
'''
func _ready():
	var sinais = [1, -1, 0]
	var todos_zeros = []

	for a in sinais:
		for b in sinais:
			for c in sinais:
				for d in sinais:
					for e in sinais:
						for f in sinais:
							var coef = [1, a, b, c, d, e, f]
							var roots = find_roots(coef)
							if roots.size() == coef.size() - 1:
								todos_zeros.append(roots)
								
	# resultados agora contém as raízes de todos os polinômios
	print("Cálculo finalizado. Total de polinômios: ", todos_zeros.size())

	# Passa a lista para o node filho desenhar.
	var plotter = get_node("Plotter")
	plotter.set_zeros(todos_zeros)
'''
'''
func _ready():
	var sinais = [1, -1, 0]
	var threads: Array = []
	var resultados: Array = []
	var combinacoes: Array = []

	# Gerar todas as combinações possíveis.
	for a in sinais:
		for b in sinais:
			for c in sinais:
				for d in sinais:
					for e in sinais:
						for f in sinais:
							combinacoes.append([1, a, b, c, d, e])
							resultados.append(null)  # placeholder

	# Inicia uma thread para cada polinômio
	for i in range(combinacoes.size()):
		var t = Thread.new()
		threads.append(t)
		t.start(Callable(self, "_thread_root_solver").bind(combinacoes[i], resultados, i))

	# Espera todas as threads terminarem
	for t in threads:
		t.wait_to_finish()

	# resultados agora contém as raízes de todos os polinômios
	print("Cálculo finalizado. Total de polinômios: ", resultados.size())

	# Exemplo: imprimir os primeiros resultados
	#for i in range(resultados.size()):
	#	print("Polinômio ", i + 1, ":")
	#	for r in resultados[i]:
	#		print("  Raiz: ", r.as_string())

	# Você pode agora passar `resultados` para seu nó Plotter, por exemplo:
	$Plotter.set_zeros(resultados)
	
func _thread_root_solver(coef, resultados_ref, index):
	var roots = find_roots(coef)
	resultados_ref[index] = roots
'''
