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




## 8-way movement

Esta é a clássica movimentação nas 8 direções, muito utilizada em jogos de RPG. 

