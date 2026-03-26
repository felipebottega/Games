# Using Viewports

No [tabuleiro de Galton 4](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Canvas%20layers/Galton%20Board%204#viewport-e-canvas-items) vimos que "canvas" representa todo o espaço 2D disponível na engine e "viewport" representa a tela visível do jogo. A noção de viewport não é apenas conceitual, existe o node `Viewport` na engine.

O node `SubViewport` serve para criar e manipular telas extras no jogo. Pense nestas telas como áreas retangulares que podem ter texturas (também chamadas de "render target" neste contexto), podem receber inputs, áudio, etc. Elas funcionam como se fossem telas independentes que podem fazer tudo que um viewport comum faz. Algumas aplicações de `SubViewport` são:
  
  - Renderizar objetos 3D em um jogo 2D
  - Renderizar objetos 2D em um jogo 3D
  - Renderizar texturas que mudam dinamicamente
  - Múltiplas câmeras funcionando na mesma cena
  - Reflexo de espelho
  - Visualização de câmeras de monitoramento
  - Visualização "raio-x"
  - Minimapas

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

O método `get_viewport().get_texture().get_image()` permite fazer uma captura de tela e armazenar o resultado como uma textura. Você pode usar este método tanto no viewport raíz como em um subviewport.

Na cena de exemplo, adicionamos um botão que contém dois sprites. O primeiro é aquele quadrado verde, que serve apenas de background, nada demais. O segundo é um `Sprite2D` vazio, chamado *Capture*. Ele está ali para ser a textura da captura de tela do subviewport.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/b32042cc-5977-4851-be96-eccfec607a5e" />
</p>

Quando o botão é pressionado, o script abaixo (que está no node raíz da cena) é ativado, e isso faz uma captura do subviewport e joga o resultado para o sprite. Você pode apertar o botão várias vezes seguidas e ver como ele de fato captura o instante do que está acontecendo no subviewport.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/69fc8144-471d-4649-be55-e35e09e8e47a" />
</p>

## Input

Como mencionado anteriormente, `SubViewport` não é apenas uma "tela dentro da tela". Pense nele como um "jogo dentro do jogo". Assim como o `Viewport` raíz é o responsável por receber inputs, o `SubViewport` também pode receber inputs. Por default, não recebe inputs automaticamente. A única maneira dele receber inputs é quando é filho do node `SubViewportContainer`. Este node foi feito especificamente para conter nodes `SubViewport` e garantir as suas funcionalidades. Caso o seu interesse seja apenas na textura do `SubViewport`, já comentamos que existem várias opções. Caso queria mais funcionalidades, use o `SubViewportContainer`.

Vamos criar um segundo exemplo agora. Desta vez, o container não ser mais um `Sprtite2D`, mas sim o `SubViewportContainer`. Faça como mostrado abaixo. ao colocar o `SubViewport` dentro de um `SubViewportContainer`, a textura já é renderizada automaticamente na cena.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/8e13e67b-69d9-43ea-be78-575a43b215c8" />
</p>

Ao script do `Sprite2D`, adicionamos uma função que aumenta ou diminui a escala do sprite conforme clicamos com o mouse. Note que estamos utilizando o mesmo script de antes. Esta função de input não tem efeito nenhum no primeiro exemplo pois o `SubViewport` não está dentro de um `SubViewportContainer`.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/a2073c58-7562-45ff-99f2-e3e31a3e4477" />
</p>

## Câmeras

Sempre que você adiciona câmeras na cena, ela vai mostrar o conteúdo do primeiro viewport acima dela na árvore de nodes. 

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/12aad556-b245-495f-8cc5-a3b619059f5b" />
</p>

> PS: Só pode haver uma câmera ativa por (sub)viewport. Caso você tenha múltiplas câmeras, é possível escolher qual ficará ativa com o comando `camera.make_current()`, em que `camera` a variável do node da câmera.

Para deixar este exemplo mais interessante, colocamos um background estático no subviewport e fizemos o sprite se mover de uma manei mais interessante. Enquanto ele se move, a câmera do subviewport acompanha o movimento.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/cbd75fd0-dc52-4ddc-b868-4cf4a9dc8294" />
</p>

## World

Em Godot, o `World2D` (`World3D`) é o "ambiente de simulação" ligado a um viewport, ele reúne o que faz aquele conteúdo existir e funcionar ali, como renderização/canvas, física e áudio espacial. Já o viewport é a "tela" em si, a superfície onde o jogo é projetado. Se dois viewports usam o mesmo `World2D`, eles enxergam a mesma física/canvas desse mundo. Se usam mundos diferentes, cada um fica isolado. Em 2D, cada viewport já vem com seu próprio `World2D` por default, mas em 3D o default é todos usarem o mesmo `World3D`. É possível alterar este comportamento nos dois casos.

Um exemplo de aplicação: Você pode ter várias câmeras olhando para o mesmo mundo, cada uma com uma "interpretação visual" diferente. Se dois viewports compartilham o mesmo `World2D`, eles estão enxergando os mesmos nodes (`Node2D`, `PhysicsBody2D`, etc.), a mesma simulação de física, o mesmo estado do jogo. A única coisa que muda é como esse mundo é renderizado, ou seja, a câmera e os efeitos.

## Size e stretch

Em *Inspector → SubViewport*, temos algumas propriedades que merecem uma atenção especial.

- **SubViewport/Size:** Define o tamanho da tela do `SubViewport`. Caso ele seja filho de um `SubViewportContainer` e este esteja com a propriedade *stretch* habilitada, então é o tamanho dele que é usado.
- **SubViewport/Size 2D Override:** Funciona como o "tamanho lógico 2D" usado para o sistema 2D. Se qualquer componente for 0, o override é desabilitado. 
- **SubViewport/Size 2D Override Stretch:** Se for habilitada, este propriedade faz com que esse tamanho lógico 2D também seja usado no stretch. É como se o *size* fosse colocado para o tamanho definido pelo *Size 2D Override*.

Por exemplo, se `size = Vector2i(1920, 1080)` e `size_2d_override  = Vector2i(640, 360)`, os nodes 2D (CanvasItems, controles, Camera2D, etc.) são posicionados/medidos como se a área fosse $640  \times 360$, mas o conteúdo é renderizado para a textura de $1920 \times 1080$. Isto é útil para: 

- UI com escala uniforme
- Pixel-art com escala controlada
- Renderizar em alta resolução enquanto mantém layout 2D estável.

## Efeito "raio-x" com a câmera

Mostramos acima um exemplo em que a câmera se move perseguindo um sprite dentro do subviewport. Porém, note que a tela do subviewport não tem relação nenhuma com a tela principal. Faremos um último exemplo agora, aplicando a ideia de efeito "raio-x" com a câmera. Este "raio-x" não é literalmente o raio-x tradicional, mas sim a ideia de passar a câmera do subviewport sobre a imagem da tela principal e obter uma visualização diferente do mesmo objeto (assim como seria em um raio-x).

Começamos criando os nodes da cena. É semelhante ao exemplo anterior, só temos mais sprites dentro do subviewport. Iremos alternar a visibilidade entre eles para mostrar um de cada vez sobre a imagem "base" que está na tela principal (viewport raíz). A propriedade *size* do subviewport foi definida para ter as dimensões que a gente quer para o quadro de visualização. Como todos os sprites são variações do sprite base e queremos sobreposição perfeita, todos devem ser posicionados na exata mesma posição. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/40354d0e-9abf-4c72-95c8-b6d4d58f4ee6" />
</p>

Não queremos que a visualização do subViewport seja do tamanho da tela inteira, por isso optamos por $250 \times 250$. A ideia é que ele funcione como um mini visor retangular que nos permite ver outro aspecto da imagem enquanto passamos o visor sobre a imagem base (em outros contextos ele poderia ser uma lupa, uma câmera infra-vermelho, etc.). Devemos adicionar um node de câmera dentro do `SubViewport` e deixá-la posicionada na coordenada $(-250, -250)$. Com isso, temos o efeito desejado mostrado abaixo. O quadro do subviewport tem o papel de mostrar em alta resolução uma parte da imagem base (que é pixelada).

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/084879f2-f84e-49f5-b78b-cddf5e034b14" />
</p>

> PS: Dado o tamanho $(x, y)$ do subviewport, sempre colocamos a câmera na posição $(-x, -y)$ de modo a tê-la centralizada na tela do subviewport. 
 
O script abaixo deve ser adicionado ao `SubViewportContainer`. Assim, sempre que movemos o mouse, o container se move e a câmera move junto, de modo a revelar o conteúdo do subviewport naquela exata posição.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/e7770ed6-6b82-48e9-a60f-5e52e5dfe6de" />
</p>

> PS: Provavelmente a tela do subviewport terá um efeito "trêmulo" ao movimentar o mouse. Isto acontece porque a renderização é feita em subpixels. Para remover este efeito indesejado, vá em *Inspector → Viewport* e habilite a opção *Snap 2D Transforms to Pixel*.
