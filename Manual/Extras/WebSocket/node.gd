extends Node

@export var websocket_url : String = "ws://127.0.0.1:8000/ws"    # url do servidor WebSocket
var socket : WebSocketPeer    # instância do cliente WebSocket
var connected : bool = false    # flag de conexão
var frame_count : int = 0    # contador de frames
var send_timer : float = 0.0    # timer para envio periódico
var waiting_server = false    # flag de espera do servidor

func _ready():
	socket = WebSocketPeer.new()  # cria a instância
	connect_to_server()  # conecta ao servidor

func connect_to_server():
	"""
	Conexão WebSocket.
	"""
	
	var err = socket.connect_to_url(websocket_url)
	if err != OK:
		push_error("❌ Falha ao conectar ao servidor WebSocket!")
		return
	print("Tentando conectar ao servidor WebSocket...")

func _process(delta):
	socket.poll()  # processa eventos pendentes

	match socket.get_ready_state():
		WebSocketPeer.STATE_OPEN:
			if not connected:
				connected = true
				print("✅ Conectado ao servidor WebSocket!")

			# Recebe mensagens do servidor
			while socket.get_available_packet_count() > 0:
				var msg = socket.get_packet().get_string_from_utf8()
				handle_received_data(msg)

			# Envia dummy data a cada 1 segundo
			send_timer += delta
			if send_timer >= 1.0:
				if not waiting_server:
					send_dummy_inputs()
					send_timer = 0.0

		WebSocketPeer.STATE_CLOSING, WebSocketPeer.STATE_CLOSED:
			if connected:
				handle_disconnection()

func handle_received_data(msg: String):
	"""
	Processa dados recebidos do servidor.
	"""
	
	var data = JSON.parse_string(msg)
	if data:
		for npc_data in data.get("results", []):
			print("NPC", npc_data["npc_id"], "→ ação:", npc_data["action"])

	# Libera flag de espera do servidor.
	waiting_server = false

func send_dummy_inputs():
	"""
	Envia dados para o servidor.
	"""
	
	if not connected:
		return

	frame_count += 1
	var batch = []
	for i in range(5):  # teste com 5 NPCs
		batch.append({
			"npc_id": i,
			"inputs": [sin(frame_count * 0.1 + i), cos(frame_count * 0.1 + i)]
		})
		
	send_to_server(batch)

func send_to_server(batch):
	waiting_server = true
	var payload = {"batch": batch}
	socket.send_text(JSON.stringify(payload))
	
func handle_disconnection():
	"""
	Trata desconexão.
	"""
	
	print("⚠️ Desconectado do servidor WebSocket")
	connected = false
