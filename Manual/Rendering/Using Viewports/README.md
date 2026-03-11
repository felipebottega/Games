# Using Viewports

No [tabuleiro de Galton 4](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Canvas%20layers/Galton%20Board%204#viewport-e-canvas-items) vimos que "canvas" representa todo o espaço 2D disponível na engine e "viewport" representa a tela visível do jogo. A noção de viewport não é apenas conceitual, existe o node `Viewport` na engine.

O node `SubViewport` serve para criar e manipular telas extras no jogo. Pense nestas telas como áreas retangulares que podem ter texturas, podem receber inputs, áudio, etc. Elas funcionam como se fossem telas independentes que podem fazer tudo que um viewport comum faz. Algumas aplicações de `SubViewport` são:
  
  - Renderizar objetos 3D em um jogo 2D
  - Renderizar objetos 2D em um jogo 3D
  - Renderizar texturas que mudam dinamicamente
  - Múltiplas câmeras funcionando na mesma cena
  - Reflexo de espelho
  - Visualização de câmeras de monitoramento

## Exemplo inicial

Em muitos tutoriais anteriores, foi possível apenas listar propriedades e métodos do objeto de estudo em questão, pois era óbvio como ele deveria funcionar. No caso de `SubViewport`, acredito ser um tema menos óbvio, por isso começaremos com um exemplo prático. Só depois disso que passaremos para a parte mais técnica do assunto.

