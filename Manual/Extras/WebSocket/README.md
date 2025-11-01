# WebSocket

É possível utilizar a engine Godot como frontend e um script rodando como backend. Isso é interessante quando se tem computações pesadas para processar e você não quer fazer isso com GDScript. Neste tutorial, vou mostrar como utilizar um script em Python para atuar como servidor backend de um jogo em Godot.

## Preparando o servidor backend em Python

Abaixo, temos um script minimal para rodar um servidor utilizando a biblioteca *fastapi* de Python. Ele é executado localmente na porta $8000$ e fica aguardando algum processo externo se comunicar com esta porta através de um tipo de POST. Quando esta comunicação ocorre, o servidor converte a mensagem recebida para um json. Neste exemplo, o json deve contar as chaves "npc_id" e "inputs". A função *process_npc* processa os inputs de cada NPC, resultando em uma lista de dicionários, um por NPC. Então a função *send_text* envia os resultados de volta para a engine.

```
import json
import asyncio
import uvicorn
from fastapi import FastAPI, WebSocket

app = FastAPI()

# Endpoint WebSocket: o Godot se conecta aqui. Execute o script com python server.py.
@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()  # Aceita a conexão do cliente
    print("✅ Conexão WebSocket estabelecida")

    try:
        while True:
            data = await websocket.receive_text()  # Recebe mensagem do cliente
            payload = json.loads(data)  # Converte a mensagem para JSON
            npcs = payload.get("batch", [])  # Obtém os dados dos NPCs
            results = []  # Lista para armazenar os resultados

            for npc in npcs:
                npc_id = npc.get("npc_id")  # Obtém o ID do NPC
                inputs = npc.get("inputs")  # Obtém os inputs do NPC
                action = process_npc(inputs)  # Processa os inputs e determina a ação
                results.append({"npc_id": npc_id, "action": action})  # Adiciona o resultado à lista

            response = json.dumps({"results": results})  # Cria a resposta com os resultados
            await websocket.send_text(response)  # Envia a resposta ao cliente

    except Exception as e:
        print("⚠️ Conexão encerrada:", e)  # Exibe erro caso ocorra
        await websocket.close()  # Fecha a conexão

# Função simulando a lógica de decisão de um NPC
def process_npc(inputs):
    if not inputs:
        return "idle"  # Retorna "idle" se não houver inputs
    if inputs[0] > 0.5:
        return "move_right"  # Retorna "move_right" se o primeiro input for maior que 0.5
    elif inputs[0] < -0.5:
        return "move_left"  # Retorna "move_left" se o primeiro input for menor que -0.5
    else:
        return "stand"  # Retorna "stand" para outros casos

# Inicia o servidor WebSocket local
if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)  # Inicia o servidor na porta 8000
```
