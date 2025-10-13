extends Node

@export var websocket_url : String = "ws://127.0.0.1:8000/ws"  # URL do servidor WebSocket
var socket : WebSocketPeer  # Instância do cliente WebSocket
var connected : bool = false  # Flag de conexão
var frame_count : int = 0  # Contador de frames
var send_timer : float = 0.0  # Timer para envio periódico

func _ready():
	socket = WebSocketPeer.new()  # Cria a instância
	connect_to_server()  # Conecta ao servidor

# Conexão WebSocket
func connect_to_server():
	var err = socket.connect_to_url(websocket_url)
	if err != OK:
		push_error("❌ Falha ao conectar ao servidor WebSocket!")
		return
	print("Tentando conectar ao servidor WebSocket...")

func _process(delta):
	socket.poll()  # Processa eventos pendentes

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
				send_dummy_inputs()
				send_timer = 0.0

		WebSocketPeer.STATE_CLOSING, WebSocketPeer.STATE_CLOSED:
			if connected:
				handle_disconnection()

# Processa dados recebidos
func handle_received_data(msg: String):
	var data = JSON.parse_string(msg)
	if data:
		for npc_data in data.get("results", []):
			print("NPC", npc_data["npc_id"], "→ ação:", npc_data["action"])

# Envia dados dummy
func send_dummy_inputs():
	if not connected:
		return

	frame_count += 1
	var batch = []
	for i in range(5):  # teste com 5 NPCs
		batch.append({
			"npc_id": i,
			"inputs": [sin(frame_count * 0.1 + i), cos(frame_count * 0.1 + i)]
		})

	var payload = {"batch": batch}
	socket.send_text(JSON.stringify(payload))  # envia como texto, não binário

# Trata desconexão
func handle_disconnection():
	print("⚠️ Desconectado do servidor WebSocket")
	connected = false
