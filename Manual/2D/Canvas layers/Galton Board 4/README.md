# Galton Board 4

Este é o primeiro projeto relativo ao [manual oficial de Godot](https://docs.godotengine.org/en/stable/tutorials/2d/canvas_layers.html). Na minha terceira versão do tabuleiro de Galton, me pediram para fazer uma opção "shake", ou seja, de tremer o tabuleiro. Isto porque às vezes as bolas ficavam empacadas na entrada. Parte da culpa é do usuário que quis entupir de bola usando parâmetros inadequados, mas a ideia de tremer o tabuleiro é interessante. Na época eu não implementei pois não sabia como, e por acaso logo no primeiro item do manual a solução me aparece! Então vamos lá!

## Viewport e Canvas items

"Canvas" significa "tela" em inglês, enquanto que "viewport" significa "janela de visualização". Podemos entender o canvas como sendo todo o espaço 2D que temos para trabalhar, enquanto que viewport é a tela que o jogador enxerga.

<p align="center">
    <img src="https://github.com/user-attachments/assets/cf0ea1a7-0fe5-4ed2-8ddb-2ef1c4958070" width="800">
</p>

O node `CanvasItem` é a base para todos os nodes 2D, com o `Node2D` e `Control` sendo seus primeiros filhos. Uma característica crucial desta classe é que todos seus filhos herdam a transformação dos pais, isto é, se você transformar um `Node2D` (mudar posição, escala, ect), seus filhos serão transformados juntos. Vale ressaltar que `CanvasItem` é uma classe abstrata e não é diretamente manipulável em Godot. 

O node `Viewport` é filho direto de `Node`, e tem o papel de criar e manipular diferentes telas. Apesar de `CanvasItem` e `Viewport` não terem nenhuma relação hereditária, os filhos de `CanvasItem` são filhos de `Viewport`, direta ou indiretamente. Essa é uma escolha do design da engine, e faz sentido pois deformar a tela também deformar todos os elementos visíveis nela, e boa parte vem do `Node2D` ou `Control`. Abaixo temos um resumo visual do parentesco entre os nodes mencionados. Os gráficos completos podem ser encontrados [aqui](https://docs.godotengine.org/en/stable/contributing/development/core_and_modules/inheritance_class_tree.html).

<p align="center">
    <img src="https://github.com/user-attachments/assets/6a59f7c2-2a8c-440a-b3af-9b7500836f34" width="800">
</p>

## Viewport.canvas_transform

Uma das várias funcionalidades do `Viewport` é a função `Viewport.canvas_transform`. Esta função recebe três vetores em $\mathbb{R}^2$, sendo o primeiro associado ao eixo $x$, o segundo ao eixo $y$ e o terceiro à "origem" da tela. Por default o primeiro vetor é $e_1 = (1, 0)$, o segundo é $e_2 = (0, 1)$ e o terceiro é $v_o = (0, 0)$. Mudando $e_1$ e $e_2$ nós aplicamos deformações lineares na tela, enquanto que mudando $v_o$ nós transladamos a tela. Por exemplo definir $e_1 = (2, 0)$ altera a escala de toda a tela no eixo $x$, ampliando em 2 vezes. Definir $e_1 = (1, -1)$ aplica uma deformação no eixo x do viewport por $45^\circ$. A figura abaixo ilustra a ideia geral dessas transformações.

<p align="center">
    <img src="https://github.com/user-attachments/assets/bdeaff7e-aa5a-40fd-902a-5bf4e8fccd58" width="600">
</p>
