# Galton Board 4

Este é o primeiro projeto relativo ao [manual oficial de Godot](https://docs.godotengine.org/en/stable/tutorials/2d/canvas_layers.html). Na minha terceira versão do tabuleiro de Galton, me pediram para fazer uma opção "shake", ou seja, de tremer o tabuleiro. Isto porque às vezes as bolas ficavam empacadas na entrada. Parte da culpa é do usuário que quis entupir de bola usando parâmetros inadequados, mas a ideia de tremer o tabuleiro é interessante. Na época eu não implementei pois não sabia como, e por acaso logo no primeiro item do manual a solução me aparece! Então vamos lá!

## Viewport e Canvas items

"Canvas" significa "tela" em inglês, enquanto que "viewport" significa "janela de visualização". Podemos entender o canvas como sendo todo o espaço 2D que temos para trabalhar, enquanto que viewport é a tela que o jogador enxerga.

<p align="center">
    <img src="https://github.com/user-attachments/assets/cf0ea1a7-0fe5-4ed2-8ddb-2ef1c4958070" width="800">
</p>

O node `CanvasItem` é a base para todos os nodes 2D, com o `Node2D` e `Control` sendo seus primeiros filhos. Uma característica crucial desta classe é que todos seus filhos herdam a transformação dos pais, isto é, se você transformar um `Node2D` (mudar posição, escala, ect), seus filhos serão transformados juntos. Vale ressaltar que `CanvasItem` é uma classe abstrata e não é diretamente manipulável em Godot. 

O node `Viewport` é filho direto de `Node`, e tem o papel de criar e manipular diferentes telas. Apesar de `CanvasItem` e `Viewport` não terem nenhuma relação hereditária, os filhos de `CanvasItem` são filhos de `Viewport` de maneira direta ou indireta. Essa é uma escolha de design da engine, e faz sentido uma vez que deformar a tela também deforma os elementos visíveis nela (a maior parte sendo do `Node2D` ou `Control`). Abaixo temos um resumo visual do parentesco entre os nodes mencionados. Os gráficos completos podem ser encontrados [aqui](https://docs.godotengine.org/en/stable/contributing/development/core_and_modules/inheritance_class_tree.html).

<p align="center">
    <img src="https://github.com/user-attachments/assets/6a59f7c2-2a8c-440a-b3af-9b7500836f34" width="1000">
</p>

## Viewport.canvas_transform

Uma das várias funcionalidades do `Viewport` é a função `Viewport.canvas_transform`. Esta função recebe três vetores em $\mathbb{R}^2$, sendo o primeiro associado ao eixo $x$, o segundo ao eixo $y$ e o terceiro à "origem" da tela. Por default o primeiro vetor é $e_1 = (1, 0)$, o segundo é $e_2 = (0, 1)$ e o terceiro é $v_o = (0, 0)$. Mudando $e_1$ e $e_2$ nós aplicamos deformações lineares na tela, enquanto que mudando $v_o$ nós transladamos a tela. Por exemplo definir $e_1 = (2, 0)$ altera a escala de toda a tela no eixo $x$, ampliando em 2 vezes. Definir $e_1 = (1, -1)$ aplica uma deformação no eixo x do viewport por $45^\circ$. A figura abaixo ilustra a ideia geral dessas transformações.

<p align="center">
    <img src="https://github.com/user-attachments/assets/bdeaff7e-aa5a-40fd-902a-5bf4e8fccd58" width="600">
</p>

> PS: Tome cuidado com objetos que já foram transladados previamente a esta função. O espaço vazio entre o objeto transladado e a origem também entra na conta, daí o objeto pode mudar de posição de maneira inesperada.

## CanvasLayers

Tem um detalhe importante a se considerar com o método descrito acima: às vezes nós queremos deformar certos elementos da tela, mas não todos. A solução para isso é o node `CanvasLayer`. Este node adiciona uma camada de renderização 2D separada para todos os seus filhos e os filhos dos filhos. Por default os filhos da `Viewport` são desenhados na camada "0", enquanto um `CanvasLayer` desenhará em qualquer outra camada. É padrão da engine Godto que camadas com um número maior sejam desenhadas acima daquelas com um número menor. Isso explica aquele comportamento observado no [HUD do Galton Board 2](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Heads%20up%20display/Galton%20Board%202#sobre-o-canvaslayer).

##  Implementando o shake para o tabuleiro de Galton

Tudo já está perfeitamente alinhado para que o shake seja implementado.

- Acabamos de ver como fazer transformações sobre a tela;
- O HUD do tabuleiro de Galton foi contruído como um `CanvasLayer`, então o shake não vai afetá-lo;
- Sabemos como aplicar forças sobre áreas por causa do nosso [AquaPlay](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Using%20signals/Signals%201).

Começamos criando a cena, que será um node `Area2D` com uma `CollisionShape2D` retangular, e o script com a lógica do shake. Não precisamos nos preocupar em ajustar o shape de colisão, pois faremos isso quando essa cena for instanciada na Main.

<p align="center">
    <img src="https://github.com/user-attachments/assets/a582c561-fe8b-4e03-8369-fdaa03388fbf" width="900">
</p>

No HUD, adicionamos o botão, que deverá ser semelhante ao botão de Quit. Também aproveitamos para instanciar a cena da área de colisão na Main e ajustamos o tamanho para cobrir a área desejada.

<p align="center">
    <img src="https://github.com/user-attachments/assets/b56c00fd-a7d1-4cf1-b4ff-fe574436cdea" width="800">
</p>

Queremos que a função `apply_shake` do script da área seja ativada por $0.5$ segundos quando o botão de shake for pressionado. Para isso, devemos enviar um sinal do botão e devemos também ter um `Timer`. Definimos a variável booleana `shaking` no script da Main, ele será *true* quando o shake tem que ocorrer e *false* caso contrário. Também na `_physics_process`, incluímos a linha `$ShakeArea.apply_shake(shaking)` para chamar a função. Deste modo, toda a lógica se restringe a alterar o estado da variável `shaking`.

O primeiro passo natural é acrescentar um sinal ao botão. Como o HUD não possui a variável `shaking` nem o `Timer`, devemos criar um sinal extra para enviar à Main. É o mesmo approach que usamos para o Start.

<p align="center">
    <img src="https://github.com/user-attachments/assets/e825768b-a1ee-4664-b67a-55f2e66842aa" width="950">
</p>

Chamamos este sinal simplesmente de `shake`. Quando o botão é pressionado, o sinal do shake é emitido, a Main capta esse sinal e então executa a função `_on_hud_shake`. Esta função altera o estado do `shaking` para *true* e dá start no `Timer`. Ele foi configurado para durar $0.5$ segundos e quando terminar, emitir um sinal para voltar o `shaking` para *false*, como podemos ver no script abaixo.

<p align="center">
    <img src="https://github.com/user-attachments/assets/5c745f4b-b6f4-4ddc-a9be-7ca38f0f5745" width="950">
</p>


