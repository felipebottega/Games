# Size and anchors

Neste tutorial, falaremos de *anchor preset, anchor points* e *anchor offsets*. Estas ferramentas auxiliam para controlar o tamanho e posicionamento de quaqluer objeto filho da classe `Control` (classe responsável pela UI do jogo). Em todos os tutoriais até agora, resolvemos estas duas questões clicando nos pontos de edição visual do objeto e ajustando com o mouse (indicado na imagem abaixo). Essa abordagem funciona, mas é manual e imprecisa.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/feef8551-ebc8-43cf-8bb6-dfcf3e667753" />
</p>

## Anchor Offsets

*Anchor offsets* (também chamados de "margens"), são as distâncias entre as arestas do objeto e as coordenadas $x$ e $y$ da "âncora" ("anchor" em inglês). A âncora é aquele X verde no canto superior esquerdo do objeto. Para editar estas margens, você deve ir em *Inspector → Control → Layout → Anchors Presets* e alterar esta propriedade para *Custom*. ISso vai abrir mais uma lista de propriedades para editar abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/ffad3384-f060-4571-a56c-cd0f2e9ddd2c" />
</p>

