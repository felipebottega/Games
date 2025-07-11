# class_name é o nome global para o script inteiro. Basta o script estar na pasta e os outros scripts poderão acessar via ComplexLib. 
# Por exemplo var z = ComplexLib.Complex.new(1.0, 2.0) ou ComplexLib.find_roots().
# PS: Toda classe em GDScript já possui o método new() automaticamente, que cria uma nova instância da classe, chamando o _init() se existir.
class_name ComplexLib  

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
static func eval_polynomial(coefficients: Array, x: Complex) -> Complex:
	var result = Complex.new(coefficients[0], 0)
	for ii in range(1, coefficients.size()):
		result = result.mul(x).add(Complex.new(coefficients[ii], 0))
	return result

# Método de Durand–Kerner
static func find_roots(coefficients: Array, MAX_ITER=500) -> Array:
	# O coeficiente líder tem que ser positivo para o algoritmo ficar estável.
	if coefficients[0] < 0:
		for ii in range(coefficients.size()):
			coefficients[ii] *= -1
			
	var n = coefficients.size() - 1
	var roots := []
	var angle_step = 2.0 * PI / n
	var epsilon = 0.05
	var fx = 99999.0
	var max_iter = MAX_ITER
	var tol = 1e-6

	# Inicializa as raízes em torno do círculo unitário com leve ruído
	for ii in range(n):
		var angle = angle_step * ii + randf_range(-epsilon, epsilon)
		var r = 1.0 + randf_range(-epsilon, epsilon)
		roots.append(Complex.new(r * cos(angle), r * sin(angle)))

	for iter in range(max_iter):
		var converged = true

		for ii in range(n):
			var x = roots[ii]
			fx = eval_polynomial(coefficients, x)
			var prod = Complex.new(1, 0)
			
			for jj in range(n):
				if jj != ii:
					var diff = x.sub(roots[jj])
					if abs(diff.re) + abs(diff.im) < 1e-12:
						push_error("Raízes muito próximas na iteração %d (i=%d, j=%d)" % [iter, ii, jj])
						return []
					prod = prod.mul(diff)

			if prod.abs() < 1e-12:
				push_error("Denominador muito pequeno na iteração %d, índice %d" % [iter, ii])
				return []

			var delta = fx.div(prod)
			converged = converged and delta.abs() <= tol
			roots[ii] = roots[ii].sub(delta)

		if converged:
			#print("Convergência em ", iter, " iterações. |f(z)| = ", fx.abs())
			break

		if iter == max_iter - 1:
			print("Atingiu o limite de iterações: ", max_iter)

	return roots
