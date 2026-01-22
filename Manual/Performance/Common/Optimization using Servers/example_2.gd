extends Node2D


var body: RID    # corpo físico gerenciado pelo PhysicsServer2D
var shape_rid: RID    # shape usada pelo corpo físico
var canvas_item_rid: RID    # CanvasItem usado para desenhar algo na tela


func _body_moved(state: PhysicsDirectBodyState2D, _index: int) -> void:
	"""
	Esta função é chamada pelo PhysicsServer2D durante a integração física. Ela faz a ponte entre 
	física e renderização. Não estamos "movendo um sprite". Estamos definindo o transform de um 
	CanvasItem de baixo nível que contém comandos de desenho previamente registrados.
	
	Parâmetros
	----------
		state: contém o estado atual do corpo (posição, rotação, etc).  
		index: é um identificador fornecido pelo usuário para diferenciar múltiplos corpos que estão
		usando esta função.
	"""

	RenderingServer.canvas_item_set_transform(canvas_item_rid, state.transform)
	
func _ready() -> void:
	# Criar um CanvasItem manualmente (ver exemplo 1). 
	canvas_item_rid = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(canvas_item_rid, get_canvas_item())
	RenderingServer.canvas_item_add_rect(canvas_item_rid, Rect2(-10, -10, 20, 20), Color(1, 0, 0))

	# Criar um corpo físico manualmente. O servidor PhysicsServer2D é o equivalente de baixo nível 
	# de um RigidBody2D.
	body = PhysicsServer2D.body_create()

	# Definimos o modo do corpo como RIGID.
	PhysicsServer2D.body_set_mode(body, PhysicsServer2D.BodyMode.BODY_MODE_RIGID)

	# Criar e associar uma shape. Shapes também são objetos quee precisam ter seus RIDs guardados.
	shape_rid = PhysicsServer2D.rectangle_shape_create()

	# Define o tamanho da shape.
	PhysicsServer2D.shape_set_data(shape_rid, Vector2(10, 10))

	# Associa a shape ao corpo físico.
	PhysicsServer2D.body_add_shape(body, shape_rid)

	# Colocar o corpo no mesmo espaço físico da cena. Sem isso, o corpo não participa da simulação 
	# do mundo atual.
	PhysicsServer2D.body_set_space(body, get_world_2d().space)

	# Definir transform inicial do corpo.
	PhysicsServer2D.body_set_state(body, PhysicsServer2D.BodyState.BODY_STATE_TRANSFORM, Transform2D(0, Vector2(600, 100)))

	# Registrar callback de integração física. Esta função será chamada sempre que o corpo for 
	# integrado, permitindo sincronizar física com renderização.
	PhysicsServer2D.body_set_force_integration_callback(body, Callable(self, "_body_moved"), 0)
