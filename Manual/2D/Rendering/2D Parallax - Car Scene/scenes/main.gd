extends Node2D

var i = 0
var t

func _physics_process(delta):
	t = abs(sin(PI/2 + i*delta/10))
	$NuvemBaixa/SpriteDia.modulate = Color(1, 1, 1, t)    # dia
	$NuvemBaixa/SpriteNoite.modulate = Color(1, 1, 1, 1-t)    # noite
	$NuvemAlta/SpriteDia.modulate = Color(1, 1, 1, t)    # dia
	$NuvemAlta/SpriteNoite.modulate = Color(1, 1, 1, 1-t)    # noite
	$Montanhas/Sprite2D.modulate = Color(max(t, 0.3), max(t, 0.3), 1, 1)
	$Floresta/Sprite2D.modulate = Color(max(t, 0.4), max(t, 0.4), 1, 1)
	$Estrada/Sprite2D.modulate = Color(max(t, 0.5), max(t, 0.5), 1, 1)
	$AnimatedSprite2D.modulate = Color(max(t, 0.5), max(t, 0.5), 1, 1)
	
	if t < 0.6:
		$PointLight2D.enabled = true
	else: 
		$PointLight2D.enabled = false
		
	i += 1
