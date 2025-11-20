extends Node2D

var t = 0
var s = 0
var Apos_orig = Vector2(100, 200)
var Bpos_orig =  Vector2(300, 500)
var Cpos_orig = Vector2(500, 200)
var Dpos_orig =  Vector2(700, 500)

func _ready() -> void:
	$A.position = Apos_orig
	$B.position = Bpos_orig
	$C.position = Cpos_orig
	$D.position = Dpos_orig

func _process(delta: float) -> void:
	var Apos = $A.position
	var Bpos = $B.position
	var Cpos = $C.position
	var Dpos = $D.position
	t += delta/10
	
	if t <= 1:
		s = (1 - cos(PI * t)) / 2
		$A.position = Apos_orig.lerp(Bpos_orig, t)
		$LabelLinear.text = "LINEAR\nt = {0}\nA.position = {1}\nB.position = {2}".format([t, $A.position, $B.position])
		$C.position = Cpos_orig.lerp(Dpos_orig, s)
		$LabelSmooth.text = "LINEAR SMOOTH\ns = {0}\nC.position = {1}\nD.position = {2}".format([s, $C.position, $D.position])

	if t > 1.2:
		t = 0
		$A.position = Apos_orig
		$B.position = Bpos_orig
		$C.position = Cpos_orig
		$D.position = Dpos_orig
