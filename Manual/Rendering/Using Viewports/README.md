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
  <img width="700" src="https://github.com/user-attachments/assets/9eee5816-cb5b-4d21-9eb6-2ff5f184ba6f" />
</p>

Agora você já pode executar o jogo que ele vai renderizar a textura do subviewport sobre o sprite container, na posição onde ele está.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/b5fc86d5-33ae-4499-98ae-16039713ffbd" />
</p>

## Transparent BG

O container foi colocado um pouco mais para o centro da tela e foi criado um script que desloca o sprite dentro do `SubViewport` horizontalmente. O sprite azul está mais ao fundo do `SubViewport` apenas porque ele vem primeiro na árvore de nodes. Além disso, podemos notar que o sprite dentro do container é "cortado" após um certo ponto. Isto ocorre porque ele foi além dos limites do subviewport. Neste exemplo, o subviewport está parado, é apenas o sprite dentro dele que está se movendo, então ele escapa da "tela" onde está inserido e é cortado.

https://github.com/user-attachments/assets/5246e7f9-7d3d-466b-b9fd-81a52dfb8437

No subviewport apenas temos o sprite vermelho se movendo, não há nenhum background renderizado. Isso significa que o sprite azul está sendo sobreposto por algo que em teoria é transparente. Você pode desfazer esse comportamento habilitando a opção *Transparent BG* em *Inspector → Viewport → Transparent BG*. O efeito dessa opção está mostrado abaixo.

https://github.com/user-attachments/assets/312c8998-f158-4ef9-bc07-918533bf2942

## Captura




## Input

Como mencionado anteriormente, `SubViewport` não é apenas uma "tela dentro da tela". Pense nele como um "jogo dentro do jogo". Assim como o `Viewport` raíz é o responsável por receber inputs, o `SubViewport` também recebe inputs. Por default, não recebe inputs automaticamente. Você deve habilitar isso indo em *Inspector →*
