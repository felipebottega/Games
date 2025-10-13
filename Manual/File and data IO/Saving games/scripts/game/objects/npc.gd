extends AnimatedSprite2D

var conversa = 1    # conversa=i -> está na conversa i
var fala = 0

func _ready() -> void:
	$Label.text = ""
	return

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("focus_next") or Input.is_action_just_pressed("accept")) and Manager.close_to_npc == 1:
		if conversa == 1:
			conversa_1()
			
		elif conversa == 2:
			conversa_2()
				
		# Esta conversa só é liberada quando o jogador passa do primeiro checkpoint.
		elif conversa > 2 and Manager.state >= 2:    
			conversa_3()
		
	return

func _on_first_timer_timeout() -> void:
	conversa = 1
	conversa_1()
	return

func conversa_1():
	if fala == 0:
		Manager.stop_player = true
		$TalkIconNPC.visible = false
		$Label.text = "Olá estranho. Primeira\nvez por aqui?"
		$Label.position = Vector2(-85, -50)
	elif fala == 1:
		$Label.text = "Estou na busca pelo famoso\ncálice sagrado. Me disseram\nque encontraria aqui."
		$Label.position = Vector2(-200, -50)
	elif fala == 2:
		$Label.text = "Ah sim, de fato ele está\nnestas terras, mas nunca\nconseguiram chegar até lá!"
		$Label.position = Vector2(-105, -60)
	elif fala == 3:
		$Label.text = "Ele fica tão alto que é\nimpossível para seres\ncomo nós."
		$Label.position = Vector2(-105, -60)
	elif fala == 4:
		$Label.text = "Porém um grilo com\npernas fortes como as\nsuas deve conseguir."
		$Label.position = Vector2(-105, -60)
	elif fala == 5:
		$Label.text = "Eu sou um gafanhoto."
		$Label.position = Vector2(-200, -15)
	elif fala == 6:
		$Label.text = "É inseto, é verde,\né pulante. Grilo!"
		$Label.position = Vector2(-75, -40)
	elif fala == 7:
		$Label.text = "..."
		$Label.position = Vector2(-120, -10)
	elif fala == 8:
		$Label.text = "Está vendo essa plataforma\naqui em cima? É só pular nela\ne começar a sua jornada."
		$Label.position = Vector2(-125, -60)
	elif fala == 9:
		$Label.text = "Tenho certeza que será\nmoleza para um grilo pulante\ncomo você. Boa sorte!!!"
		$Label.position = Vector2(-120, -60)
	else:
		$Label.text =  ""
		conversa = 2
		fala = 0    # zera a fala para repetir a conversa do início
		Manager.stop_player = false    # o jogador pode se mover de volta
		Manager.state = 1    # passou da primeira conversa com o primeiro NPC
		$TalkIconNPC.visible = true
		return
		
	fala += 1
	
	return
	
func conversa_2():
	if fala == 0:
		Manager.stop_player = true
		$TalkIconNPC.visible = false
		$Label.text = "Só precisa andar, pular e não\ncair. Um grilo como você vai\ntirar isso de letra!"
		$Label.position = Vector2(-115, -60)
	
	else:
		$Label.text =  ""
		fala = 0    # zera a fala para repetir a conversa do início
		Manager.stop_player = false
		$TalkIconNPC.visible = true
		return
		
	fala += 1
	
	return
	
func conversa_3():
	pass
	
