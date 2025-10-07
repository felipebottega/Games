extends AnimatedSprite2D

var conversa = 1     # conversa=i -> está na conversa i
var fala = 0

func _ready() -> void:
	$Label.text = ""
	return

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("focus_next") and Manager.close_to_npc == 3:
		if conversa == 1:
			conversa_1()
			
		elif conversa == 2:
			conversa_2()
		
	return

func conversa_1():
	if fala == 0:
		Manager.stop_player = true
		$TalkIconNPC.visible = false
		$Label.text = "Olá, grilo."
		$Label.position = Vector2(-400, -300)
	elif fala == 1:
		$Label.text = "Desisto..."
		$Label.position = Vector2(-800, -150)
	elif fala == 2:
		$Label.text = "Logo adiante há\numa plataforma."
		$Label.position = Vector2(-600, -500)
	elif fala == 3:
		$Label.text = "Basta pular nela e seguir\nsubindo que vai\nencontrar o que procura."
		$Label.position = Vector2(-600, -500)
	elif fala == 4:
		$Label.text = "Seguir subindo é a\nsua grande dica?"
		$Label.position = Vector2(-1100, -200)
	elif fala == 5:
		$Label.text = "Agradeça que é simples.\nSó pular he he he"
		$Label.position = Vector2(-500, -400)
	elif fala == 6:
		$Label.text = "..."
		$Label.position = Vector2(-600, -150)
	else:
		$Label.text =  ""
		conversa = 2
		fala = 0    # zera a fala para repetir a conversa do início
		Manager.stop_player = false    # o jogador pode se mover de volta
		Manager.state = 3    # passou da primeira conversa com o terceiro NPC
		$TalkIconNPC.visible = true
		return
		
	fala += 1
	
	return
	
func conversa_2():
	if fala == 0:
		Manager.stop_player = true
		$TalkIconNPC.visible = false
		$Label.text = "Boto fé em você he he he"
		$Label.position = Vector2(-600, -400)
	else:
		$Label.text =  ""
		fala = 0    # zera a fala para repetir a conversa do início
		Manager.stop_player = false
		$TalkIconNPC.visible = true
		return
		
	fala += 1
	
	return
