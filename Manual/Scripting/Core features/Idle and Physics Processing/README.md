# Idle and Physics Processing

Os jogos são executados em um loop. A cada frame, você precisa atualizar o estado dos elementos jogo antes de desenhá-lo na tela. A Godot fornece dois métodos virtuais na classe `Node` para isso: `Node._process()` e `Node._physics_process()`. Se você definir um ou ambos em um script, a engine os chamará automaticamente.

> PS: Desde o início, estes dois métodos tem sido chamados de "funções nativas da Godot". O termo não está errado, foi escolha didática. Métodos do `Node` podem ser chamados diretamente em quase qualquer script (pois quase todas as classes mais usuais são filhas do `Node`), então estes métodos tem esse caráter de serem "onipresentes".

Existem dois tipos de processamento disponíveis (falamos um pouco desse tema [na introdução de física](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-process)):

- O "idle processing" (processamento normal) permite que você execute código que atualiza o node (associado ao script) a cada frame, com a maior frequência possível.
- O "physics processing" (processamento de física) ocorre a uma taxa fixa, 60 vezes por segundo por padrão. Isso é independente da taxa de frames real do seu jogo e mantém a física funcionando sem problemas. Você deve usá-lo para qualquer coisa que envolva a engine de física.

## Desativando os processamentos

Você pode ativar ou desativar o processamento normal com `set_process(true)` e `set_process(false)`. O método `is_processing()` serve para verificar se o processamento normal está ligado.

O controle do processamento de física é análogo. Neste caso, você usará `set_physics_process(true)` e `set_physics_process(false)`. A checagem de processamento é feita com o comando `is_physics_processing()`.

Mesmo que desative os dois processamentos, algumas coisas do jogo ainda continuam rodando: 

- O loop principal da Godot continua rodando. A engine ainda renderiza a tela a cada frame, atualiza a árvore da cena internamente e mantém o jogo "vivo", mesmo sem chamar seus métodos de script.
- A engine de física continua ativa. Corpos como `CharacterBody2D`, `RigidBody2D` etc. ainda sofrem gravidade, colisões e respostas físicas, porque isso é calculado pela engine, não pelo seu `_physics_process()`.
- Timers continuam funcionando: qualquer `Timer` na cena continua contando tempo e emitindo o sinal, independentemente de você ter desativado processamento no script.
- Animações continuam rodando. Sistemas como `AnimationPlayer`, `Tween` e `GPUParticles2D` continuam atualizando automaticamente, pois têm seus próprios ciclos internos.
- Sistema de input continua funcionando. Funções como `_input(event)` e `_unhandled_input(event)` ainda são chamadas quando o usuário pressiona teclas, clica ou interage.
- Áudio continua tocando. Sons e músicas seguem sendo reproduzidos normalmente, pois o sistema de áudio é independente do `_process()`.

> PS: Apenas `_process()` e `_physics_process()` param de funcionar. A engine simplesmente deixa de chamar esses métodos no seu script, então qualquer lógica que você colocou neles deixa de rodar.

## Parâmetro delta

Lembre-se de que a frequência com que a engine chama o `_process()` depende do FPS, que varia ao longo do tempo e entre máquinas. O parâmetro `delta` da função representa o tempo decorrido em segundos desde a última chamada a `_process()`. Use esse parâmetro para realizar cálculos independentes de FPS. O `delta` também existe para o `_physics_process()` e com a mesma definição, mas em geral devemos ter o delta físico constante e igual a $\frac{1}{60} = 0.0166 \ldots$ segundos. 

Veremos como utilizar este parâmetro no `_process()` através de um exemplo didático. Começamos construindo uma cena com um `Node2D` como node raíz e dois `Sprite2D` como filhos. Ambos vão se movimentar na horizontal e atravessar a tela. Um deles irá se movimentar pelo `_physics_process()` e o outro pelo `_process()`. O node `Label` está ali apenas para mostrar um cronômetro no canto da tela, é totalmente opcional.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/c6a9403e-35ae-4421-8243-b0993c6de3ad" />
</p>

Começamos pelo `_physics_process()`. O sprite irá se movimentar de acordo com o script abaixo. Isso significa que a cada frame físico a posição $x$ do sprite irá aumentar em $2$ pixels. Ou seja, a velocidade horizontal dele é de $2$ pixels a cada $\frac{1}{60}$ segundo, o que dá $120$ pixels por segundo.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/be4c9411-4975-42e0-bf5a-bb71713e25d5" />
</p>

Agora vamos para o `_process()`. Queremos que ele se movimente na mesma velocidade que o sprite anterior. A solução ingênua para este problema é repetir o script acima, trocando `_physics_process()` por `_process()`.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/28c4f4b0-3176-4cc6-a9a3-633a0be8d3a3" />
</p>

https://github.com/user-attachments/assets/896611ba-b08e-429e-b4ed-b61a7ba58ea3

No caso do `_physics_process()`, sabemos que a taxa de atualização é constante e equivalente a 60 FPS (assumindo a configuração default). Já para o `_process()` isso não é necessariamente verdadeiro. Se o jogo estiver rodando a 300 FPS, o `_process()` será atualizado 5 vezes mais rápido que o `_physics_process()`, então o sprite irá se mover 5 vezes mais rápido também. Não queremos isso.

Para resolver este problema, devemos utilizar o `delta`. Como já vimos, a velocidade do primeiro sprite é de $120\ \texttt{pixels/segundo}$. O `delta` nos diz quanto tempo passou entre este frame do `_process()` e o anterior, isto é a velocidade (instantânea) de atualização dos frames. Para saber quantos pixels o segundo sprite deve avançar para acompanhar o primeiro, fazemos uma "regra de três" ("proportion" ou "cross multiplication" no inglês).

<div align="center">
<table>
  <tr>
    <th></th>
    <th>Pixels</th>
    <th>Tempo (s)</th>
  </tr>
  <tr>
    <th>Physics Process</th>
    <td>120</td>
    <td>1</td>
  </tr>
  <tr>
    <th>Process</th>
    <td>$x$</td>
    <td><code>delta</code></td>
  </tr>
</table>
</div>

Resolvendo para $x$, obtemos $x = \frac{120 \cdot \texttt{delta}}{1} = 120 \cdot \texttt{delta}.$ Como já sabemos que `speed` $= 2$ no código, a fórmula passa a ser $x = 60 \cdot \texttt{speed} \cdot \texttt{delta}$.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/7a885b11-3aa4-474c-a74a-4a8b0c7074fd" />
</p>

Abaixo segue o resultado final.

https://github.com/user-attachments/assets/e38fc0c5-b833-46e1-8663-0aedb309281b

