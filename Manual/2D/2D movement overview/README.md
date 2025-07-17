# 2D movement overview

Neste tutorial, iremos ver as principais maneiras de se implementar movimento 2D. Alguns deles já foram implementados em tutoriais anteriores, mas aqui será um compilado geral, e feito da maneira correta. Usaremos o node `CharacterBody2D` para os nossos exemplos, mas poderia ser um `RigidBody2D` ou `Area2D` dependendo do objetivo. Vimos algumas diferenças de uso [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Animation%202#rigidbody2d-vs-characterbody2d-vs-node2d). A estrutura será a mesma em todas ascenas: um `Node2D` contendo um `CharacterBody2D` que contém um `Sprite2D` e um `CollisionShape2D`. A cena inicial mostrada será a base para todas as outras, apenas alteraremos o script do `CharacterBody2D` de uma para a outra.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/1d75c702-c81f-4eec-acb3-809620a9cde0" />
</p>

## Todos os vetores do transform são em coordenadas locais

Veja a figura acima novamente. O objeto foi colocado no centro da tela. Do [tutorial sobre viewport e transformações](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Viewport%20and%20canvas%20transforms) sabemos que estas coordenadas são em relação ao node pai. Neste caso, o `Node2D`. Apenas para relembrar, na imagem abaixo nós transladamos o node pai de posição. Note que a posição do `CharacterBody2D` ainda é a mesma, em $(500, 300)$.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/398e511c-9ee5-4310-9179-3376763732fa" />
</p>

Agora vamos rotacionar o node pai. Como podemos ver abaixo, o `CharacterBody2D` ficou inalterado. Inclusive, na tela de debugging eu coloquei para printar o atributo `transform` do `CharacterBody2D`. Ela é igual a $[(1,0),\ (0, 1),\ (500, 300)]$ (ignore o erro numérico na posição), como esperado. Isso significa que a direção $(1, 0)$, que é o "para frente" do boneco, é inclinado para cima no mundo real. Ou seja, não é o $(1, 0)$ do mundo real. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/a8f3937c-32e1-4a90-a6a0-a7a1adf997c6" />
</p>

Podemos obter os vetores em termos de mundo real com a transformação linear `get_global_transform()`, algo também visto no tutorial mencionado anteriormente. Neste caso, o resultado é <p align="center">`get_global_transform() * transform` $= [(0.925775,\ -0.378075),\ (0.378075,\ 0.925775),\  (1470.62,\ 363.3901)]$.</p>

Mas para quê essa recapitulação toda? Como veremos adiante, ao pressionar o botão de "ir para frente", o boneco não irá se mover na direção $(1, 0)$ nas coordenadas locais, mas sim nas globais. É bom ter isso em mente agora para não fazer confusão mais tarde sobre qual sistema de coordenadas o boneco vai se mover (é na global). 

## 8-way movement

Esta é a clássica movimentação nas 8 direções, muito utilizada em jogos de RPG. O simples script abaixo sobre o `CharacterBody2D` possibilita este tipo de movimento. 

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/94f7bcac-b923-4a57-8444-dfcc58a9f7cf" />
</p>

Agora vamos explicar as principais componentes deste script:

- **Input.get_vector:** Note que colocamos 4 inputs como parâmetros para esta função no script. De maneira informal, as entradas desta função são "para trás", "para frente", "para baixo" e "para cima", nesta ordem. Esta função sempre entrega vetores normalizados, com norma 1. 
- **velocity:** É um atributo nativo do `CharacterBody2D`. É um vetor 2D indicando a direção para onde o boneco está indo. Ele segue com velocidade horizontal e vertical de acordo com os valores $x$ e $y$ do vetor.
- **move_and_slide:** É um método nativo do `CharacterBody2D`. Ele não recebe nenhum parâmetro como entrada. É esta função que faz o boneco se mover de acordo com o vetor de velocidade definido acima. Caso ele colida com outro objeto, ele vai deslizar por ele em vez de parar imediatamente. Além disso, esta função retorna `true` se houve colisão, caso contrário retorna `false`.

> PS: Note que usamos `_physics_process` em vez de `_process`. Isto é importante pois `_process` pode rodar mais rápido ou mais lento de acordo com o FPS. Não queremos que a velocidade do boneco dependa de FPS.

## Rotação e movimento ("Asteroids-style")

Neste tipo de movimentação, você usa os botões esquerda-direita para rotacionar o boneco, e cima-baixo para ir para frente ou para trás. O nome "Asteroids-style" é porque essa é a movimentação clássica dos jogos de arcade estilo Asteroids. O script dele segue abaixo.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/4fb9dac1-5a02-49ba-b6a1-3c5f1c9a9fb6" />
</p>

- **Input.get_axis:** Recebe dois inputs como parâmetros. Quando o primeiro input é detectado, a função retorna $-1$. Quando o segundo input é detectado, a função retorna $1$.
- **rotation:** Atributo nativo do `CharacterBody2D`. Representa a rotação do objeto, em radianos.

> ⚠️ Atenção: O comando `velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed` foi o que começou a confusão mental que me levou à falar sobre coordenadas aqui. Se você rotacionar o node pai, o boneco vai apontar numa direção que não é o $(1, 0)$ do mundo, mas o `transform.x` dele será $(1, 0)$ em coordenadas locais. Este  comando para definir `velocity` só faz sentido quando as coordenadas locais e globais concordam. Caso contrário, o boneco rotacionado vai receber o vetor `transform.x` $= (1, 0)$ e vai se mover horizontalmente em relação ao mundo mesmo que esteja inclinado. Isso porque `velocity` é um vetor de movimentação em coordenadas globais. Eu estou copiando o tutorial, mas aconselho a não fazer assim na prática. Como `velocity` é global, você deveria usar um vetor global para definir `velocity`, não um vetor que depende de coordenadas locais.
  
