extends Node

var a = 0.0
var b = 0.0
var c = 0.0
var d = 0.0
var e = 0.0
var f = 0.0
var g = 0.0
var h = 0.0
var i = 0.0
var j = 0.0
var k = 0.0
var l = 0.0
var m = 0.0

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
	for ii in range(1, coefficients.size()):
		result = result.mul(x).add(Complex.new(coefficients[ii], 0))
	return result

# Método de Durand–Kerner
func find_roots(coefficients: Array) -> Array:
	# O coeficiente líder tem que ser positivo para o algoritmo ficar estável.
	if coefficients[0] < 0:
		for ii in range(coefficients.size()):
			coefficients[ii] *= -1
			
	var n = coefficients.size() - 1
	var roots := []
	var angle_step = 2.0 * PI / n
	var epsilon = 0.05

	# Inicializa as raízes em torno do círculo unitário com leve ruído
	for ii in range(n):
		var angle = angle_step * ii + randf_range(-epsilon, epsilon)
		var r = 1.0 + randf_range(-epsilon, epsilon)
		roots.append(Complex.new(r * cos(angle), r * sin(angle)))

	var max_iter = 500
	var tol = 1e-6

	for iter in range(max_iter):
		var new_roots := []
		var converged = true

		for ii in range(n):
			var x = roots[ii]
			var fx = eval_polynomial(coefficients, x)
			var prod = Complex.new(1, 0)

			for jj in range(n):
				if jj != ii:
					var diff = x.sub(roots[jj])
					if diff.abs() < 1e-12:
						push_error("Raízes muito próximas na iteração %d (i=%d, j=%d)" % [iter, ii, jj])
						return []
					prod = prod.mul(diff)

			if prod.abs() < 1e-12:
				push_error("Denominador muito pequeno na iteração %d, índice %d" % [iter, ii])
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

func _ready():
	a = $VSlider_a.value
	b = $VSlider_b.value
	c = $VSlider_c.value
	d = $VSlider_d.value
	e = $VSlider_e.value
	f = $VSlider_f.value
	g = $VSlider_g.value
	h = $VSlider_h.value
	i = $VSlider_i.value
	j = $VSlider_j.value
	k = $VSlider_k.value
	l = $VSlider_l.value
	m = $VSlider_m.value
	_update_plot()

func _on_v_slider_value_changed(value):
	a = $VSlider_a.value
	b = $VSlider_b.value
	c = $VSlider_c.value
	d = $VSlider_d.value
	e = $VSlider_e.value
	f = $VSlider_f.value
	g = $VSlider_g.value
	h = $VSlider_h.value
	i = $VSlider_i.value
	j = $VSlider_j.value
	k = $VSlider_k.value
	l = $VSlider_l.value
	m = $VSlider_m.value
	_update_plot()
	_update_label()
	
func _update_plot():
	var coef = [a, b, c, d, e, f, g, h, i, j, k, l, m]
	var roots = find_roots(coef)
	$Plotter.set_zeros([roots])
	
func _update_label():
	var coef = [a, b, c, d, e, f, g, h, i, j, k, l, m]

	var terms = []
	for ii in range(coef.size()):
		var expoent = 12 - ii
		var term = "%s x^%d" % [coef[ii], expoent]
		terms.append(term)

	$Label.text = " + ".join(terms)
	$Label.text = str(a) + "x¹²" + "→ "
