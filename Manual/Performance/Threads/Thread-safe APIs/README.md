# Thread-safe APIs

Godot tem suporte a multithreading, como já vimos. Porém, isso não vale para tudo na engine. Vamos ver o que pode e o que não pode ser feito com threads.

## O que não pode fazer com threads

  1. **Não mexer na árvore de cenas:** Por exemplo, comandos como `add_child()`, `remove_child()`, `queue_free()`, `get_node()` não podem ser chamados na thread.
  2. **Não mexer em UI:** Coisas como `Label.text = ""` ou `Button.disabled = true` não podem ser feitas na thread.
  3. **Não carregar o mesmo recurso em várias threads:** Por exemplo, ter duas (ou mais) threads carregando o mesmo *.tscn* é pedir para dar problema.
  4. **Não modificar o mesmo recurso em paralelo:** Por exemplo, ter duas (ou mais) threads mexendo na mesma imagem ou mesh é pedir para dar problema.
  5. **Não acessar Array ou Dicionário sem Mutex**
  6. **Não usar thread pra lógica de frame:** Não faça movimento de personagem, colisão por frame, input, lógica que depende do delta, etc. Thread não entende frame, só entende trabalho terminado.
  7. **Não usar "while true" sem bloqueio:** Sempre use `Semaphore.wait()` ou saia do loop.

## O que pode fazer com threads

  1. **Usar thread pra calcular coisas:** Pode usar thread para contas matemáticas, IA, pathfinding, gerar mapas, preparar dados.

> PS: Tenha isso como regra geral: Thread serve pra pensar, não pra mexer no jogo.

  2. **Criar nodes e cenas fora da árvore de cenas:** Você pode fazer `load()`, `instantiate()`, entre outros, desde que não dê `add_child()` e não encoste na árvore ativa. Quando a thread terminar o trabalho, ela sinaliza a main thread. Aí a main thread faz `add_child()`. Isso é possível.
  3. **Passar resultados simples do thread pra main thread:** A thread pode escrever resultados em dados compartilhados (variáveis, arrays, dicionários), desde que o acesso seja controlado (com Mutex). A main thread lê esses dados depois.
  4. **Usar chamadas de API para servidores:** Você pode usar servidores em thread se a thread não cria node, não chama `add_child()`, não acessa UI, só cria/configura coisas internas. Você não deve chamar se o método retorna node, o método depende da classe `SceneTree`, o método "parece alto nível".
  
> PS: Os servidores de renderização e física por default não são thread-safe. Para liberar isso, você deve ir em *Project → Project Settings → Rendering → Driver → Thread Model → Separate* e *Project → Project Settings → 2D (3D) → Run on Separate Thread*.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Threads/Using%20multiple%20threads">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction">Próximo ➡</a>
</p>
