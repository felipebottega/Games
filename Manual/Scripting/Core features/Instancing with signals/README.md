# Instancing with signals

Neste tutorial, iremos aprender a maneira adequada de se usar sinais para instanciar objetos. O maior desafio disso é decidir "quem" vai instanciar os objetos. Por exemplo, se você tiver um personagem que atira uma pedra quando o usuário clica o mouse, então é o clique do mouse que ativa o sinal de atirar pedra. Este sinal faz alguma função ser executada, e ela deve incluir um `add_child` da pedra. Talvez o primeiro impulso seja o de colocar o sinal e a função no próprio personagem. Isso implicaria que a pedra é um node filho do personagem. Logo, se ele se mover ou rotacionar, a pedra fará o mesmo. Isso não deve acontecer. Assim que a pedra é atirada, ela deve ser independente do personagem. 

A solução para esse problema é usar um `emit`. O sinal inicial vem do input de clique, que faz parte do personagem sim, mas o sinal deve ser passado adiante com o `emit`, e será outro node que vai instanciar a pedra na cena. Qual node? Pode ser o node raíz da cena, ou um node container, ou algum outro da sua escolha. Não existe uma regra fixa para isso. O importante é que este node escolhido seja um bom representante para o sistema de referência da pedra. 

## Exemplo prático

Começamos criando a cena da pedra. Ela é simplesmente um node `Area2D` com o script abaixo. Poderia ser algum outro node com velocidade. 

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/24d36c06-f94a-4279-b9f0-9cfc5ccf1bd8" />
</p>

O node do personagem é um `Sprite2D` que pode se movimentar, rotaciona seguindo o ponteiro do mouse, e reage aos cliques do mouse emitindo um sinal. No que diz respeito ao sinal, é um [sinal customizado](https://github.com/felipebottega/Games/blob/gh-pages/Getting%20started/Step%20by%20step/Using%20signals/Signals%203/README.md#signals-3), chamado *shoot*, com os parâmetros *rock*, *direction* e *location*. Note que já trabalhamos [anteriormente](https://github.com/felipebottega/Games/blob/gh-pages/Getting%20started/Your%20first%202D%20game/Heads%20up%20display/Galton%20Board%202/README.md#cena-do-hud) com sinal enviando parâmetros junto.

<p align="center">
  <img width="570" src="https://github.com/user-attachments/assets/d5314623-d460-4268-88c8-563447e4c22d" />
</p>

Quando o jogador clica no mouse, é emitido o sinal do player para o exterior através do comando `shoot.emit(rock, rotation, position)`. Ele está enviando a cena da pedra (como `PackedScene`), a rotação e a posição do player. Abaixo, temos a cena Main. A função `_on_player_shoot` foi criada ao criar uma conexão com o sinal do player. Assim que o jogador clica, essa função é executada. Ela adiciona a cena da pedra na Main e atribui a rotação e posição do player naquele instante, mas é só isso que ela extrai do player. Depois disso a pedra segue o seu caminhos de maneira totalmente independente. No script da pedra, podemos ver que ela é inicializada com vetor velocidade $(100, 0)$, mas logo após ser inicializada a rotação dela é alterada. A partir daí a direção dela passa a ser a doração, que é a do player no momento do clique.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/8f16086d-2839-454c-b578-d9d2b1d51758" />
  <img width="320" src="https://github.com/user-attachments/assets/0fe2fbd7-0e21-4957-92e1-721d055c68e8" />
  <img width="480" src="https://github.com/user-attachments/assets/25ec0f8d-00ef-4cc0-826d-c79ace11618d" />
</p>

