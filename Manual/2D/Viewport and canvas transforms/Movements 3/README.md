# Movements 3

Este jogo é uma aplicação do que foi visto sobre rotações [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Viewport%20and%20canvas%20transforms#rota%C3%A7%C3%B5es). A ideia central é que se um filho estiver a uma certa distância do pai (foi transladado) e o pai rotacionar, o filho rotaciona junto de longe, como se orbitasse o pai. Se esse filho tem outros filhos, eles rotacionam junto.

## Sprites de sprites

Os objetos principais deste jogo, onde tudo começou, são os sprites *A, B, C, D, E*. Temos que *A* é o maior sprite no centro, *B* é o segundo, e assim por diante. Note que é uma sequência aninhada de sprites. Rotacionar *A* faz todos os seguintes rotacionarem, rotacionar *B* faz *C, D, E* rotacionarem, e assim por diante. Deste modo, *B* orbita *A*, *C*  orbita *B*, etc. O comportamento de fato é semelhante ao de planetas, mas com órbitas perfeitamente circulares.

<p align="center">
  <img src="https://github.com/user-attachments/assets/bc7fd5c7-0e56-4da4-9243-f6454a44604b" width="500">
</p>

Cada sprite contém o script simples mostrado abaixo. O atributo `modulate` serve para alterar as cores do sprite, não é nada demais. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/92f1f5e3-dd99-491f-a67d-de34f13da64a" width="200">
</p>

## Rastro de sprites

Para os comportamentos orbitais, o que foi descrito anteriormente basta. Mas não paramos por aí, queremos mais beleza para o jogo! O script do node principal da cena contém a lógica para que cada sprite deixe um "rastro" por onde passa, como um cometa.

<p align="center">
  <img src="https://github.com/user-attachments/assets/fe7ae4cf-0a25-49ed-a4a8-1c7db4912ed5" width="900">
</p>

