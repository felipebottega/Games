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

Em muitos tutoriais anteriores, foi possível apenas listar propriedades e métodos do objeto de estudo em questão, pois era óbvio como ele deveria funcionar. No caso do `SubViewport`, acredito ser um tema menos óbvio, por isso começaremos com um exemplo prático. Só depois disso que passaremos para a parte mais técnica do assunto.

Vamos começar criando uma cena em que o node raíz é um `Node2D` chamado *FirstExample*. Dentro ele, colocamos um `Sprite2D` com o logo da Godot, e depois um `SubViewport` contendo o mesmo logo da Godot. Este segundo teve a sua cor alterada para um tom vermelho, assim é possível reconhecer a textura do `SubViewport`. 

Na Godot, um `SubViewport` não é exibido automaticamente. Ele só renderiza para uma textura interna, mas está desenhando essa textura na tela. No entando, você consegue visualizar o conteúdo dele no *Inspector*.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/5c5d6954-335e-4c44-84ad-59a673ea9fa0" />
</p>

Por conter uma textura, o `SubViewport` precisa de algum tipo de "container" na cena para renderizar esta textura, caso você queira que apareça no jogo. As opções mais comuns são o `Sprite2D`, `TextureRect`, `Shader`, `Material` e `SubViewportContainer`. Vamos testar o `Sprite2D`, que é o mais simples. Para isso, crie mais um `Sprite2D`, mas fora do `SubViewport` (chamaremos ele de *Container*). Criamos este sprite e o colocamos logo ao lado do sprite original da cena.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/f0698516-dfb9-409c-b8ef-999f89b186fa" />
</p>

Agora vá no *Inspector* e selecione a textura *ViewportTexture* para o seu sprite container. Vai abrir uma janela com as opções disponíveis. Escolha o subviewport que você acabou de criar e dê ok.

<p align="center">
  <img width="280" src="https://github.com/user-attachments/assets/aec8cf86-6969-46ec-85c7-f60be69c2a6c" />
  <img width="250" src="https://github.com/user-attachments/assets/6be794ac-daf4-4d95-be85-f0d423497598" />
</p>

Agora você já pode executar o jogo que ele vai renderizar a textura do subviewport sobre o sprite container, na posição onde ele está.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/b5fc86d5-33ae-4499-98ae-16039713ffbd" />
</p>

