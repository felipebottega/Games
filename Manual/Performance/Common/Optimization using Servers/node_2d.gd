extends Node2D


# O RenderingServer espera que referências a Resources sejam mantidas enquanto usadas.
var texture
# Guarde também o RID do canvas item se precisar atualizar / limpar depois.
var ci_rid


func _ready():
	# Cria um CanvasItem (RID). É um objeto de baixo nível para desenhar no Canvas.
	ci_rid = RenderingServer.canvas_item_create()
	
	# Define como pai o CanvasItem interno pertencente a este Node2D.
	# get_canvas_item() retorna o RID do CanvasItem pertencente ao Node2D atual (aonde este script
	# está anexado).
	RenderingServer.canvas_item_set_parent(ci_rid, get_canvas_item())
	
	# Carrega a textura e mantém a referência na variável 'texture'.
	# IMPORTANTE: o RenderingServer não garante manter referências aos Resources por você,
	# então guardar a referência evita que o Resource seja liberado (garbage-collected).
	texture = load("res://crazy.jpg")
	
	# Adiciona a textura como um retângulo texturizado, centralizando o retângulo em (0,0).
	# Rect2(posição_top_left, tamanho). Usamos -texture.get_size()/2 para que o centro fique em (0,0).
	RenderingServer.canvas_item_add_texture_rect(ci_rid, Rect2(-texture.get_size() / 2, texture.get_size()), texture)
	
	# Cria uma transformação (rotacao, translacao e escala).
	var xform = Transform2D().rotated(deg_to_rad(45)).translated(Vector2(700, 600)).scaled(Vector2(0.5, 0.5))
	
	# Aplica a transformação ao CanvasItem (rotaciona/posiciona/escala o que desenhamos).
	RenderingServer.canvas_item_set_transform(ci_rid, xform)
