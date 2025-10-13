extends AnimatedSprite2D

var conversa = 1     # conversa=i -> está na conversa i
var fala = 0

func _ready() -> void:
	$Label.text = ""
	return

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("focus_next") or Input.is_action_just_pressed("accept")) and Manager.close_to_npc == 2:
		if conversa == 1:
			conversa_1()
			
		elif conversa == 2:
			conversa_2()
		
	return

func conversa_1():
	if fala == 0:
		Manager.stop_player = true
		$TalkIconNPC.visible = false
		$Label.text = "Eu já sei de tudo. Você está\nna busca pelo cálice sagrado."
		$Label.position = Vector2(-600, -500)
	elif fala == 1:
		$Label.text = "Vou te falar como proceder,\npreste bastante atenção!"
		$Label.position = Vector2(-600, -500)
	elif fala == 2:
		$Label.text = "Atrás de mim tem um abismo.\nVocê vai se jogar nele, indo\nuns 15 pixels para frente."
		$Label.position = Vector2(-600, -500)
	elif fala == 3:
		$Label.text = "Depois disso tem que dar 3\nsaltos de fé para frente.\nVai com tudo!"
		$Label.position = Vector2(-600, -500)
	elif fala == 4:
		$Label.text = "Por fim..."
		$Label.position = Vector2(-500, -400)
	elif fala == 5:
		$Label.text = "Ehmmmmmmm"
		$Label.position = Vector2(-500, -400)
	elif fala == 6:
		$Label.text = "Acho que esqueci... mas um\ngrilo forte como você vai dar\num jeito na hora."
		$Label.position = Vector2(-600, -500)
	elif fala == 7:
		$Label.text = "Na verdade eu sou\num gafanhoto."
		$Label.position = Vector2(-1300, -200)
	elif fala == 8:
		$Label.text = "Tanto faz. "
		$Label.position = Vector2(-500, -400)
	elif fala == 9:
		$Label.text = "..."
		$Label.position = Vector2(-800, -150)
	else:
		$Label.text =  ""
		conversa = 2
		fala = 0    # zera a fala para repetir a conversa do início
		Manager.stop_player = false    # o jogador pode se mover de volta
		Manager.state = 2    # passou da primeira conversa com o segundo NPC
		$TalkIconNPC.visible = true
		return
		
	fala += 1
	
	return
	
func conversa_2():
	if fala == 0:
		Manager.stop_player = true
		$TalkIconNPC.visible = false
		$Label.text = "Atrás de mim tem um abismo.\nVocê vai se jogar nele, indo\nuns 15 pixels para frente."
		$Label.position = Vector2(-600, -500)
	elif fala == 1:
		$Label.text = "Depois disso tem que dar 3\nsaltos de fé para frente.\nVai com tudo!"
		$Label.position = Vector2(-600, -500)
	else:
		$Label.text =  ""
		fala = 0    # zera a fala para repetir a conversa do início
		Manager.stop_player = false
		$TalkIconNPC.visible = true
		return
		
	fala += 1
	
	return
