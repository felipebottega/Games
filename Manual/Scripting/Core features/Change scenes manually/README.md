# Change scenes manually

Quando você executa o jogo de um projeto e uma cena inicial é carregada, o node raíz da cena não é o node raíz do jogo. Como já foi comentado [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Nodes%20and%20scene%20instances#obtendo-nodes), o node oculto *root* é um Viewport global, tudo no jogo fica abaixo dele, incluindo outras cenas e autoload. Este node sempre existe e sempre fica no topo da árvore do jogo. Na Godot, a `SceneTree` (veremos mais sobre esta classe em um tutorial mais adiante) já vem com um root viewport automático, e a cena principal do jogo é só um node adicionado como filho dele.

Devemos ter uma cena main para carregar inicialmente no jogo. Mas depois que essa cena foi carregada (e é filha do *root*), nada impede de carregar outras cenas irmãs da inicial. No exemplo abaixo, assim que a cena Main é carregada, seu script carrega outras cenas e as adiciona como filhas direta do *root*. Todasas cenas estão sendo executadas paralelamente e de maneira independente.

<p align="center">
  <img width="420" src="https://github.com/user-attachments/assets/db68665b-d808-495c-8dea-ac88afc282bc" />
  <img width="210" src="https://github.com/user-attachments/assets/9b31847b-f27d-44f1-8a08-6c51429b7121" />
</p>

## Visualização de múltiplas cenas irmãs

No contexto acima, o que devemos esperar ver na tela do jogo? Como *root* é um Viewport, a visualização é a mesma que teríamos em uma cena normal. Cada cena carregada nada mais é do que um node na árvore mais geral do jogo. Deste modo, veremos as três cenas ao mesmo tempo, com a sobreposição indo de cima para baixo, como é normalmente. Mostramos abaixo cada cena individual e em conjunto como irmãs. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/b81866a1-d65c-417e-9c72-6afe7996fe5c" />
</p>
