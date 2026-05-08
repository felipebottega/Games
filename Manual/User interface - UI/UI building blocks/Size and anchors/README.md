# Size and anchors

Neste tutorial, falaremos de *anchor preset, anchor points* e *anchor offsets*. Estas ferramentas auxiliam para controlar o tamanho e posicionamento de qualquer objeto filho da classe `Control` (classe responsável pela UI do jogo). Em todos os tutoriais até agora, resolvemos estas duas questões clicando nos pontos de edição visual do objeto e ajustando com o mouse (indicado na imagem abaixo). Essa abordagem funciona, mas é manual e imprecisa.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/feef8551-ebc8-43cf-8bb6-dfcf3e667753" />
</p>

## Anchor Offsets

*Anchor offsets* (também chamados de "margens"), são as distâncias entre as arestas do objeto e as coordenadas $x$ e $y$ da "âncora" ("anchor" em inglês). A âncora é aquele X verde no canto superior esquerdo do objeto. Para editar estas margens, você deve ir em *Inspector → Control → Layout → Anchors Presets* e alterar esta propriedade para *Custom*. Isso vai abrir mais uma lista de propriedades para editar abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/044e14e1-c8e0-4f36-b883-d3876dcb4774" />
</p>

## Anchor Points

Como dito acima, a âncora é o X verde que serve como ponto de referência para as margens. Essa âncora na verdade não é um ponto, mas sim uma caixa. Você pode editar a posição deste pontos pelo *Inspector* ou clicando e arrastando os próprios pontos verdes. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/3218645d-28c3-4f52-9134-2a682c753529" />
</p>

O range dos valores mostrados no *Inspector* devem ser interpretados como a posição em relação ao node pai, sendo $0$ na origem e $1$ na posição oposta do outro lado. Esses valores apenas fazem efeito caso o node pai seja um `CanvasLayer` ou seja um node de `Control`. Por exemplo, se for um `Button` como filho de um `CanvasLayer` ou um `ColorRect`, vai funcionar. Mas se o `Button` for filho de um `Node2D`, apenas os valores de margem (*anchor offsets*) fazem efeito. Neste caso, a âncora é fixada no canto superior esquerdo do node pai.

## Anchor Presets

Existem alguns atalhos para obter valores de margem mais usuais, sem precisar fazer manualmente. Você pode clicar na opção que aparece acima do espaço 2D ou pode ir em *Inspector → Control → Layout → Anchors Presets* e selecionar uma das outras opções além da *Custom*.

<p align="center">
  <img width="720" src="https://github.com/user-attachments/assets/e9e62027-ef35-41dc-8463-a885946852d6" />
  <img width="280" src="https://github.com/user-attachments/assets/425b5609-f7ec-4b26-823f-655866e1bc5d" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Custom%20post-processing">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/User%20interface%20-%20UI/UI%20building%20blocks/Using%20Containers">Próximo ➡</a>
</p>
