extends Node

var order = 6
var ta = 0.0
var tb = 0.0
var tc = 0.0
var td = 0.0
var te = 0.0
var tf = 0.0
var tg = 0.0
var th = 0.0
var batch = 10
var last_process = 0

func _ready():
	calcule_e_exiba_em_tempo_real()
	
func calcule_e_exiba_em_tempo_real():
	var signals = [1, -1, 0]
	var coef = []
	var roots = []
	var count = 0
	var results = []
	var vals_b = signals if order >= 2 else [0]
	var vals_c = signals if order >= 3 else [0]
	var vals_d = signals if order >= 4 else [0]
	var vals_e = signals if order >= 5 else [0]
	var vals_f = signals if order >= 6 else [0]
	var vals_g = signals if order >= 7 else [0]
	var vals_h = signals if order >= 8 else [0]
	var this_process = last_process + 1
	last_process += 1

	for a in signals:
		for b in vals_b:
			for c in vals_c:
				for d in vals_d:
					for e in vals_e:
						for f in vals_f:
							for g in vals_g:
								for h in vals_h:
									if this_process != last_process:
										print('ENCERRANDO')
										return
										
									coef = get_coef(a, b, c, d, e, f, g, h)
									roots = ComplexLib.find_roots(coef, 50)
									count += 1
									
									if roots.size() == coef.size() - 1:
										results.append_array(roots)
										if count % batch == 0 and count > batch - 1:
											$Labels/Progress.text = str(int(100 * count/(3 ** order))) + " %"
											$Plotter.set_zeros(results)
											await get_tree().process_frame  # Espera 1 frame
											results = []
								
	# Caso ainda tenham pontos restantes, eles são plotados agora.
	if results.size() > 0:
		$Plotter.set_zeros(results)
		await get_tree().process_frame  # Espera 1 frame
		$Labels/Progress.text = "100 %"
			
	return
	
func get_coef(a, b, c, d, e, f, g, h):
	if order == 1:
		return [1, a+ta]
	if order == 2:
		return [1, a+ta, b+tb]
	elif order == 3:
		return [1, a+ta, b+tb, c+tc]
	elif order == 4:
		return [1, a+ta, b+tb, c+tc, d+td]
	elif order == 5:
		return [1, a+ta, b+tb, c+tc, d+td, e+te]
	elif order == 6:
		return [1, a+ta, b+tb, c+tc, d+td, e+te, f+tf]
	elif order == 7:
		return [1, a+ta, b+tb, c+tc, d+td, e+te, f+tf, g+tg]
	elif order == 8:
		return [1, a+ta, b+tb, c+tc, d+td, e+te, f+tf, g+tg, h+th]
		
func _on_slider_drag_ended(_value_changed: bool) -> void:
	# Limpa zeros do plotter para evitar acumulo
	$Plotter.zeros.clear()
	
	# Atualiza os parâmetros dos polinômios e refaz tudo.
	order = $Sliders/VSlider_order.value
	ta = $Sliders/HSlider_a.value
	tb = $Sliders/HSlider_b.value
	tc = $Sliders/HSlider_c.value
	td = $Sliders/HSlider_d.value
	te = $Sliders/HSlider_e.value
	tf = $Sliders/HSlider_f.value
	tg = $Sliders/HSlider_g.value
	th = $Sliders/HSlider_h.value
	calcule_e_exiba_em_tempo_real()
		
	return

func _on_speed_drag_ended(_value_changed: bool) -> void:
	batch = int($Sliders/Speed.value)	
	return

func _on_size_drag_ended(_value_changed: bool) -> void:
	$Plotter.pointsize = $Sliders/Size.value
	return
	
func _process(_delta):
	if order >= 2:
		$Sliders/HSlider_b.show()
	else:
		$Sliders/HSlider_b.hide()
		
	if order >= 3:
		$Sliders/HSlider_c.show()
	else:
		$Sliders/HSlider_c.hide()
		
	if order >= 4:
		$Sliders/HSlider_d.show()
	else:
		$Sliders/HSlider_d.hide()
		
	if order >= 5:
		$Sliders/HSlider_e.show()
	else:
		$Sliders/HSlider_e.hide()
		
	if order >= 6:
		$Sliders/HSlider_f.show()
	else:
		$Sliders/HSlider_f.hide()
		
	if order >= 7:
		$Sliders/HSlider_g.show()
	else:
		$Sliders/HSlider_g.hide()
		
	if order >= 8:
		$Sliders/HSlider_h.show()
	else:
		$Sliders/HSlider_h.hide()

func _on_quit_pressed() -> void:
	$"../SinglePolynomial".hide()
	$"../LittlewoodPolynomials".hide()
	$"../Credits".show()
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
