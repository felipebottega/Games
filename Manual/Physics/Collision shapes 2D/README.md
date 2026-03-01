# Collision shapes 2D

Para qualquer corpo físico, você pode associar uma (ou várias) shape de colisão, que pode vir do node `CollisionShape2D` ou `CollisionPolygon2D`. No caso do `CollisionPolygon2D`, os pontos que definem o polígono são customizados. Já no caso do `CollisionShape2D`, existem algumas shapes nativas/primitivas da Godot à disposição. Todas estas shapes vem da classe abstrata `Shape2D`. Esta classe é um resource da engine, mas não precisamos entrar em detalhes sobre isso agora. As definições para 3D são análogas, mas vamos nos limitar ao 2D neste tutorial.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/b95df652-e206-4c0b-b62e-f8925d39b223" />
</p>

> PS: Ao adicionar várias shapes de colisão a um único corpo, elas não colidem entre si.

## Mudança de escala e física

Já vimos isso [antes](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#mudan%C3%A7a-de-escala-e-f%C3%ADsica), mas vale a pena reforçar. Quando quiser alterar o tamanho ou formato de uma shape de colisão, nunca faça isso alterando o *Scale* do *Inspector* (destacado em vermelho na imagem abaixo). Dê preferência aos marcadores em torno da shape no próprio editor (destacado em verde na imagem abaixo). A engine física não lida bem com mudanças de escala, o que pode acarretar em comportamentos inesperados ou erros. Alterar a escala por código também deve ser evitado, pois é equivalente a alterar pelo *Inspector*.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/5edd07f8-da33-4acb-8379-d2739cc6e02c" />
</p>

## Shapes de colisão primitivas

Um processo que já fizemos diversas vezes foi o de adicionar um `CollisionShape2D` a um corpo físico. Quando vamos no *Inspector* para selecionar a shape, estamos na verdade selecionando shapes primitivas da classe `Shape2D`. Sempre que possível, dê preferência às shapes primitivas, pois elas possuem uma melhor performance no cálculo de colisões. Apesar das opções `ConvexPolygonShape2D` e `ConcavePolygonShape2D` estarem disponíveis, é altamente recomendado usar o `CollisionShape2D` no lugar destas. Inclusive, iremos ignorar totalmente os nodes `ConvexPolygonShape2D` e `ConcavePolygonShape2D` nesta série de tutoriais.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/95d77b2a-0fd5-4413-947b-92f8d9f8ec2d" />
</p>

As shapes `RectangleShape2D`, `CircleShape2D` e `CapsuleShape2D` são bem simples de usar e já foram vistas antes, então vou pular. Vamos dar uma maior atenção para as shapes não vistas ainda.

- **SegmentShape2D:** Esta shape é basicamente um segmento de reta com colisão. Basta selecioná-lo e então pode começar a manipular o seu início e fim no painel. A propriedade *One Way Collision* é usada quando você quer que apenas um dos lados tenha colisão.  

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/c52b8167-fb9b-42c8-8de1-e2e27f4fb599" />
</p>

- **SeparationRayShape2D:** O `SeparationRayShape2D` é aquela "setinha" abaixo da colisão de cápsula na figura abaixo. Essa seta pode ser movida e esticada à vontade. Ela serve como um "repulsor" de outros objetos de colisão. Isso é ideal para dinâmicas tipo subir escadas (neste caso o `SeparationRayShape2D` é filho de um `CharacterBody2D`).

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/0e2d5c8a-b747-4e0b-b48f-91b1a997c17c" />
</p>

- **WorldBoundaryShape2D:** É basicamente um chão reto infinito. A seta indica a direção "para cima", a normal ao chão. É possível rotacional e mover este objeto como qualquer outro. Também tem um método para alterar o vetor normal, caso precise.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/c3ff9db3-247a-4fdd-9f30-86aa5d4baec2" />
</p>

## CollisionPolygon2D Sibling

Já vimos em duas circunstâncias ([aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20lights%20and%20shadows%20-%20Introduction) e [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20Meshes)) o uso das opções especiais do `Sprite2D` na tela 2D de edição. Agora veremos como criar um shape poligonal de colisão a partir de um sprite.

Crie um Sprite2D e vá na opção escrita Sprite2D acima da tela. Selecione a opção *Create CollisionPolygon2D Sibling*.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/9b4b6286-518c-49ac-8739-a030bcb700ad" />
  <img width="500" src="https://github.com/user-attachments/assets/75880764-019e-4b2d-b74b-d46b9ec4d06e" />
  <img width="200" src="https://github.com/user-attachments/assets/6502e0a7-3530-40c8-8baa-9954582186bb" />
</p>

Segue abaixo uma breve descrição dos parâmetros:

- **Simplification:** Parâmetro associado à quantidade de pontos para identificar o shape da imagem. Quanto maior é este parâmetro, menos pontos são utlizados e mais simplificado o shape.
- **Shrink:** Encolhe o shape em alguns pixels em relação a imagem. É útil quando você não quer cobrir literalmente tudo que está a vista.
- **Grow:** Faz o contrário do shrink, aumenta o shape em alguns pixels. É útil quando o sprite possui buracos e você não quer que eles sejam levados em conta, por exemplo.

Os exemplos mostrados aqui não estão em forma de jogo exportado, mas todos podem ser acessados através do editor diretamente.
