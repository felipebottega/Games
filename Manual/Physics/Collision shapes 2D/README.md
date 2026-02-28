# Collision shapes 2D

Para qualquer corpo físico, você pode associar uma (ou várias) shape de colisão, que pode vir do node `CollisionShape2D` ou `CollisionPolygon2D`. No caso do `CollisionPolygon2D`, os pontos que definem o polígono são customizados. Já no caso do `CollisionShape2D`, existem algumas shapes nativas/primitivas da Godot à disposição. Todas estas shapes vem da classe abstrata `Shape2D`. Esta classe é um resource da engine, mas não precisamos entrar em detalhes sobre isso agora. As definições para 3D são análogas, mas vamos nos limitar ao 2D neste tutorial.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/b95df652-e206-4c0b-b62e-f8925d39b223" />
</p>

> PS: Ao adicionar várias shapes de colisão a um único corpo, elas não colidem entre si.

## Mudança de escala e física

Já vimos isso [antes](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#mudan%C3%A7a-de-escala-e-f%C3%ADsica), mas vale a pena reforçar. Quando quiser alterar o tamanho ou formato de uma shape de colisão, nunca faça isso alterando o Scale do Inspector (destacado em vermelho na imagem abaixo). Dê preferência aos marcadores em torno da shape no próprio editor (destacado em verde na imagem abaixo). A engine física não lida bem com mudanças de escala, o que pode acarretar em comportamentos inesperados ou erros. Alterar a escala por código também deve ser evitado, pois é equivalente a alterar pelo Inspector.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/5edd07f8-da33-4acb-8379-d2739cc6e02c" />
</p>

## Shapes de colisão primitivas

Um processo que já fizemos diversas vezes foi o de adicionar um `CollisionShape2D` a um corpo físico. Quando vamos no *Inspector* para selecionar a shape, estamos na verdade selecionando shapes primitivas da classe `Shape2D`. Sempre que possível, dê preferência às shapes primitivas, pois elas possuem uma melhor performance no cálculo de colisões. Apesar das opções `ConvexPolygonShape2D` e `ConcavePolygonShape2D` estarem disponíveis, é altamente recomendado usar o `CollisionShape2D` no lugar destas. Inclusive, iremos ignorar totalmente os nodes `ConvexPolygonShape2D` e `ConcavePolygonShape2D` nesta série de tutoriais.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/95d77b2a-0fd5-4413-947b-92f8d9f8ec2d" />
</p>

- **RectangleShape2D:** Shape retangular
