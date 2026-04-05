# Idle and Physics Processing

Os jogos são executados em um loop. A cada frame, você precisa atualizar o estado dos elementos jogo antes de desenhá-lo na tela. A Godot fornece dois métodos virtuais na classe `Node` para isso: `Node._process()` e `Node._physics_process()`. Se você definir um ou ambos em um script, a engine os chamará automaticamente.

> PS: Desde o início estes dois métodos tem sido chamados de "funções nativas da Godot". O termo não está errado, é apenas para lembrar que método do `Node` são profundamente enraizados na engine, a ponto de fazer sentido considera-los nativos. Métodos do `Node` podem ser chamados diretamente em qualquer script (pois todas as classes mais usuais são filhas dele), então estes métodos tem esse caráter de serem "onipresentes".

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
