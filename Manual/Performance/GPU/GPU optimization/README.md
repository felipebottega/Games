# GPU optimization

Assim como foi o [tutorial da CPU](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/CPU/CPU%20optimization), este tutorial é apenas uma pequena lista de ferramentas e dicas para otimização dos processos do lado da GPU. 

Entender e investigar gargalos na GPU é um pouco diferente da situação na CPU. Isso porque, muitas vezes, você só consegue alterar o desempenho indiretamente, modificando as instruções enviadas à GPU. Além disso, pode ser mais difícil realizar medições. Em muitos casos, a única maneira de medir o desempenho é examinando as mudanças no tempo gasto na renderização de cada quadro.

## Reduzir draw calls - batching

Um *draw call* é basicamente quando o jogo pede para a GPU desenhar um certo objeto com material e textura. Cada draw call tem custo no CPU. Se você tem 500 sprites, todos usando a mesma textura e o mesmo material, a Godot pode agrupar isso em poucos draw calls (batching automático). Por outro, se cada sprite usa uma textura diferente ou cada um tem um material próprio, isso quebra o batching, e vira 500 draw calls.

O que fazer na prática:
  1. Reutilize o mesmo material (evite criar materiais únicos "só para mudar uma cor", por exemplo).
  2. Em 2D, prefira `TileMap` quando há repetição.
  3. Em 3D, prefira `MultiMeshInstance3D` para objetos idênticos.

## Texture Atlas

Este problema tem a ver com quantas vezes você troca a textura de um objeto. Trocar de textura caro. Mesmo que a GPU já esteja desenhando, trocar a textura é equivalente a mudar o estado interno da GPU, e isso impede o batching.

Com *Texture Atlas*, você junta várias imagens pequenas em uma textura grande e cada sprite usa a mesma textura. Neste cenário o batching volta a funcionar e o número de draw calls despenca. Em Godot, você usa essa ferramenta através do `AtlasTexture` ou `TileSet`.

## Overdraw e transparência

*Overdraw* é quando um pixel é desenhado depois outro sprite transparente vem por cima, depois outro, etc. Neste caso, a GPU calcula o pixel várias vezes e só o último fica visível. Com objetos opacos, a GPU pode descartar pixels escondidos. Com objetos transparentes, todos são sempre desenhados, mesmo se estiverem atrás de outro. Isso acontece normalmente com partículas, fumaça, sprites grandes com fundo transparente, entre outros. 

O que fazer na prática:
  1. Evite sprites transparentes gigantes. Já vimos uma técnica para lidar com isso no [tutorial de malhas 2D](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20Meshes).
  2. Prefira sprites opaco com recorte quando possível.

## Bake de iluminação

Iluminação dinâmica é pesada. Uma maneira de lidar com isso é fazendo *bake* de ilumnação. Ou seja, você pré-calcula todas as luzes que não precisam se mover. Então durante o jogo a GPU só lê uma textura, isso é zero cálculo de luz. Isso essa técnica apenas em cenários estáticos. Ela não funciona para objetos que se movem muito e luzes que ligam/desligam o tempo todo, por exemplo.
