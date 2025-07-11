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

func _ready():
	a = $Sliders/Slider_a.value
	b = $Sliders/Slider_b.value
	c = $Sliders/Slider_c.value
	d = $Sliders/Slider_d.value
	e = $Sliders/Slider_e.value
	f = $Sliders/Slider_f.value
	g = $Sliders/Slider_g.value
	h = $Sliders/Slider_h.value
	i = $Sliders/Slider_i.value
	j = $Sliders/Slider_j.value
	k = $Sliders/Slider_k.value
	l = $Sliders/Slider_l.value
	m = $Sliders/Slider_m.value
	_update_plot()

func _on_v_slider_value_changed(value):
	a = $Sliders/Slider_a.value
	b = $Sliders/Slider_b.value
	c = $Sliders/Slider_c.value
	d = $Sliders/Slider_d.value
	e = $Sliders/Slider_e.value
	f = $Sliders/Slider_f.value
	g = $Sliders/Slider_g.value
	h = $Sliders/Slider_h.value
	i = $Sliders/Slider_i.value
	j = $Sliders/Slider_j.value
	k = $Sliders/Slider_k.value
	l = $Sliders/Slider_l.value
	m = $Sliders/Slider_m.value
	_update_plot()
	_update_label()
	
func _update_plot():
	var coef = [a, b, c, d, e, f, g, h, i, j, k, l, m]
	var roots = ComplexLib.find_roots(coef)
	$Plotter.set_zeros([roots])
	
func _update_label():
	var sa = str(a) if a != 1 else ''
	var sb = str(b) if b != 1 else ''
	var sc = str(c) if c != 1 else ''
	var sd = str(d) if d != 1 else ''
	var se = str(e) if e != 1 else ''
	var sf = str(f) if f != 1 else ''
	var sg = str(g) if g != 1 else ''
	var sh = str(h) if h != 1 else ''
	var si = str(i) if i != 1 else ''
	var sj = str(j) if j != 1 else ''
	var sk = str(k) if k != 1 else ''
	var sl = str(l) if l != 1 else ''
	var sm = str(m) if m != 1 else '1'
	$Labels/Label.text = sa + " z¹² + " + sb + " z¹¹ + " + sc + " z¹⁰ + " + sd + " z⁹ + " + se + " z⁸ + " + sf + " z⁷ + " + sg + " z⁶ + " + sh + " z⁵ + " + si + " z⁴ + " + sj + " z³ + " + sk + " z² + " + sl + " z + " + sm 

func _on_button_pressed() -> void:
	$Sliders/Slider_a.value = 1
	$Sliders/Slider_b.value = 1
	$Sliders/Slider_c.value = 1
	$Sliders/Slider_d.value = 1
	$Sliders/Slider_e.value = 1
	$Sliders/Slider_f.value = 1
	$Sliders/Slider_g.value = 1
	$Sliders/Slider_h.value = 1
	$Sliders/Slider_i.value = 1
	$Sliders/Slider_j.value = 1
	$Sliders/Slider_k.value = 1
	$Sliders/Slider_l.value = 1
	$Sliders/Slider_m.value = 1
 
func _on_quit_pressed() -> void:
	$"../SinglePolynomial".hide()
	$"../LittlewoodPolynomials".hide()
	$"../ComplexPolynomialRootsButton".show()
	$"../LittlewoodPolynomialRootsButton".show()
	$"../AnimatedSprite2D".show()
	
func _on_instructions_pressed() -> void:
	$Instructions.show()
	$Back.show()
	$Plotter.hide()
	$Sliders.hide()
	$Labels.hide()
	$Buttons.hide()

func _on_back_pressed() -> void:
	$Instructions.hide()
	$Back.hide()
	$Plotter.show()
	$Sliders.show()
	$Labels.show()
	$Buttons.show()
