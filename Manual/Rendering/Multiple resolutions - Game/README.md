# Multiple resolutions - Game

Decidi fazer este jogo para praticar os conhecimentos sobre `SubViewport` e resolução. Vou aproveitar e utilizar outros conhecimentos bacanas que foram vistos anteriormente. A ideia é fazer um jogo que tenha uma "subtela" capaz de ver o cenário com outra visão, de modo a revelar coisas que não conseguiríamos ver normalmente. Também será possível configurar a resolição do jogo na tela do menu.

## Assets

Depois de obter as spritesheets e tilesheets, montamos um cenário de fazenda contendo diversos animais. O level principal possui `NavigationRegion2D` com o caminho que as ovelhas seguem. O objetivo do jogo é utilizar a subtela/visor para identificar quais ovelhas na verdade são lobos disfarçados.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/bbd4da09-6cdd-4290-a81a-0aa70b3256cd" />
</p>

Cada animal possui sua própria cena, que é um `CharacterBody2D`. O template geral é de um `Node2D` contendo um `Sprite2D` para a sombra e um `AnimatedSprite2D`. Além disso, a cena também contém um `CollisionShape2D`. A necessidade do `Node2D` é para poder efetuar um flip horizontal coerente, uma vez que o sprite não está centralizado perfeitamente na origem. Isso ainda não resolve todo o problem, pois a colisão fica um pouco deslocada após o flip. O ideal seria centralizar tudo, mas percebi isso tarde demais e não quis arrumar.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/1a0595cb-f903-440b-a2d5-cd86614bc72e" />
</p>

> PS: Não coloquei a colisão dentro do `Node2D` para receber o mesmo flip porque não é recomendado mudar escala de [objetos físicos](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#mudan%C3%A7a-de-escala-e-f%C3%ADsica).
