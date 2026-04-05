# Idle and Physics Processing

Os jogos são executados em um loop. A cada frame, você precisa atualizar o estado dos elementos jogo antes de desenhá-lo na tela. A Godot fornece dois métodos virtuais na classe `Node` para isso: `Node._process()` e `Node._physics_process()`. Se você definir um ou ambos em um script, a engine os chamará automaticamente.

> PS: Desde o início estes dois métodos tem sido chamados de "funções nativas da Godot". O termo não está errado, é apenas para lembrar que método do `Node` são profundamente enraizados na engine, a ponto de fazer sentido considera-los nativos. Métodos do `Node` podem ser chamados diretamente em qualquer script (pois todas as classes mais usuais são filhas dele), então estes métodos tem esse caráter de serem "onipresentes".

Existem dois tipos de processamento disponíveis (falamos um pouco desse tema [na introdução de física](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-process)):

- O "idle processing" permite que você execute código que atualiza um node a cada frame, com a maior frequência possível.
- O "physics processing" ocorre a uma taxa fixa, 60 vezes por segundo por padrão. Isso é independente da taxa de frames real do seu jogo e mantém a física funcionando sem problemas. Você deve usá-lo para qualquer coisa que envolva a engine de física.

