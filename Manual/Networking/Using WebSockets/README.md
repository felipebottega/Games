# WebSocket

É possível utilizar a engine Godot como frontend e um script rodando como backend. Isso é interessante quando se tem computações pesadas para processar e você não quer fazer isso com GDScript. Neste tutorial, vou mostrar como utilizar um script em Python para atuar como servidor backend de um jogo em Godot.

## Preparando o servidor backend em Python

Abaixo, temos um script minimal para rodar um servidor utilizando a biblioteca *fastapi* de Python. Ele é executado localmente na porta $8000$ e fica aguardando algum processo externo se comunicar com esta porta através de um tipo de POST. Quando esta comunicação ocorre, o servidor converte a mensagem recebida para um json. Neste exemplo, o json deve contar as chaves "npc_id" e "inputs". A função `process_npc` processa os inputs de cada NPC, resultando em uma lista de dicionários, um por NPC. Então o método `websocket.send_text()` envia os resultados de volta para a engine.

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

## Preparando o frontend na engine

Iremos criar a conexão numa cena do tipo `Node`. A primeira coisa necessária é estabelecer a conexão, faremos isso na função `_ready`. Importante ressaltar que o script deve estar executando antes do jogo ser executado.

<p align="center">
    <img width="650" src="https://github.com/user-attachments/assets/7a9ac1c8-35fa-4043-a8ef-092cce5970e4" />
</p>

Depois disso quem toma conta de tudo é o `_process`, todas as chamadas seguintes são feitas ali.

<p align="center">
    <img width="520" src="https://github.com/user-attachments/assets/827aecaa-8d18-4270-a659-11430feddabf" />
</p>

A função `handle_received_data` é responsável por receber e tratar a resposta do servidor. Esta resposta vem como uma string que precisa ser convertida em dicionário. A função `send_dummy_inputs` envia os inputs para o servidor. Note que eles são aleatórios pois este é um exemplo dummy, nada de fato acontece. Por fim, a função `handle_disconnection` trata a desconexão com o servidor. Ela é chamada quando o jogo é encerrado. 

<p align="center">
    <img width="560" src="https://github.com/user-attachments/assets/0e93bf77-cc26-4d88-b592-2e9e22d9cf44" />
    <img width="580" src="https://github.com/user-attachments/assets/d7db08e4-87e5-4772-a4b5-004d5a220efc" />
    <img width="420" src="https://github.com/user-attachments/assets/b636556d-922a-49f3-9906-7beee861a61c" />
</p>

> PS: Note que a variável *waiting_server* é fundamental para garantir que a engine só envie novos inputs quando os inputs anteriores já foram tratados. Sem essa variável de controle, a engine pode enviar múltiplos inputs enquanto as respostas ainda estão sendo calculadas, e esse acúmulo de requisições entra em uma fila que eventualmente irá estourar e matar a aplicação.

## Servidor remoto

Como podemos ver, o script Python está rodando localmente, na mesma máquina que a Godot. Caso fosse rodar esse script Python remotamente, em uma máquina EC2, como deveria ser implementada a comunicação? 

1. **Endereço: IP público ou domínio:**  
O endereço muda de `ws://127.0.0.1:8000/ws` para algo como `ws://<IP_PUBLICO>:8000/ws` ou `wss://api.mygame.com/ws`. Na Godot, basta trocar a URL: `@export var websocket_url = "wss://api.mygame.com/ws"`.

2. **EC2: liberar porta:**  
No *Security Group* da EC2, liberar a porta usada pelo servidor (ex: `8000` ou `443`), protocolo `TCP`, com origem `0.0.0.0/0` (teste) ou IPs específicos (produção).

3. **Bind correto do Uvicorn:**  
O servidor precisa escutar todas as interfaces: `uvicorn.run(app, host="0.0.0.0", port=8000)`.

4. **WS vs WSS:**  
Local pode usar `ws://`. Em produção, o recomendado é `wss://`, que exige TLS válido.

5. **Certificado TLS:**  
Para `wss://`, é necessário um certificado confiável (ex: Let’s Encrypt). Sem isso, a conexão falha no cliente.

6. **Proxy reverso (opcional, mas comum):**  
Usar Nginx para terminar TLS na porta `443` e repassar o WebSocket para o FastAPI (ex: `localhost:8000`).

7. **DNS:**  
Se usar domínio, o DNS deve apontar para o IP público da EC2 antes de emitir o certificado.

8. **Latência e quedas:**  
Em remoto há atraso e desconexões. O cliente precisa tratar `STATE_CLOSED` e reconectar.

9. **Timeout e fluxo:**  
Definir o que fazer se o servidor demorar ou não responder (retry, descartar, fallback).

10. **Ambiente da EC2:**  
Garantir que Python, dependências e o processo (systemd, screen, docker, etc.) mantenham o servidor rodando.

> PS: Em um jogo distribuído (ex: Steam), o usuário final **não deve nunca** lidar com certificados TLS. Toda a configuração de TLS (`wss://`) é responsabilidade exclusiva do servidor (domínio válido + certificado de CA confiável, como Let's Encrypt). Se o cliente Godot exigir configuração manual de certificados, isso indica ambiente de desenvolvimento.


