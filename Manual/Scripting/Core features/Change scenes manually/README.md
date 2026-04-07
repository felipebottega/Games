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

Vale mencionar que não é apenas a visualização, tudo é executado e mostrado na tela em conjunto: animação, interatividade, input, aúdio, etc. No que diz respeito a inputs, é bom ter cuidado. Do *root*, ele vai para cada filho de maneira totalmente paralela. Se um dos filhos consumir o input totalmente, isto apenas vale para os nodes daquele filho. 

## Mudança de cena

Até este momento, implementamos as mudanças de cena com o comando `get_tree().change_scene_to_file()`. Isso basicamente deleta a cena atual e inicia a outra do zero. Algumas vezes é exatamente isso o que queremos, mas nem sempre. Por exemplo, o menu do jogo pode ser uma cena própria que nós não queremos carregar do zero cada vez que o jogador acessar o menu. Pior ainda, usar o `get_tree().change_scene_to_file()` no meio de uma fase significaria matar a gameplay naquele ponto só para acessar o menu. Nesta situação, o menu poderia ser uma cena rodando em paralelo ao jogo mas com `visible=false`, e apenas essa variável se alternaria conforme o jogador quisesse ou não acessar o menu. Muito mais leve e mais simples do que qualquer solução envolvendo trocas reais de cena.

Existem 3 formas de fazer uma cena deixar de aparecer ou deixar de ser usada, e cada uma tem um custo diferente em memória, CPU e acesso aos dados.

1. **Apagar a cena**
    - A cena é destruída de verdade (deixa de existir na memória).
    - Libera RAM e para todo processamento (lógica, física, input).
    - Você perde acesso aos dados da cena.
    - Se quiser voltar depois, vai precisar carregar tudo novamente.
    - Use quando não pretende voltar para a cena tão cedo.

2. **Esconder a cena**
    - A cena continua existindo, só fica invisível para o jogador.
    - Os dados continuam acessíveis normalmente.
    - O processamento continua rodando.
    - Pode consumir mais CPU e memória se usado em excesso.
    - Use quando quer alternar rapidamente entre cenas sem custo de recarregamento.

3. **Remover da árvore (SceneTree)**
    - A cena continua na memória, mas fica desconectada do sistema principal.
    - O processamento para, porque ela não está mais na árvore.
    - É fácil reativar depois com add_child().
    - Alguns dados podem ficar desatualizados, pois não recebem updates (delta, input, etc.).
    - Use como um meio-termo: mantém a cena, mas sem custo de processamento.
