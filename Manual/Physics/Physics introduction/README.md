# Physics introduction

Já fizemos diversas aplicações de física em tutoriais anteriores, mas agora chegou o momento de encarar este tópico de maneira mais organizada. Por enquanto iremos ver tudo no contexto 2D, futuramente abordaremos os tópicos espeíficos de 3D. A primeira coisa a se ter em mente é que os principais nodes de física são: `Area2D`, `StaticBody2D`, `RigidBody2D` e `CharacterBody2D`. É a partir deles que aplicamos a maioria das propriedades físicas da engine.

## Physics material

Tanto o `StaticBody2D` quanto o `RigidBody2D` possuem a capacidade de terem suas propriedades físicas configuradas através do *Physics material*, que fica no *Inspector*. Não vou detalhar como cada um funciona, aconselho a testar na prática.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/a4f793da-ea48-4be7-9301-65b35c8ec567" />
  <img width="350" src="https://github.com/user-attachments/assets/a53e9a17-fc05-4460-8405-0660768d271f" />
</p>

Os nodes `Area2D` e `CharacterBody2D` não possuem *Physics material* por serem "menos físicos" que os dois nodes mencionados acima. O `Area2D` serve apenas para detectar colisão, mas não reage fisicamente a essas colisões (você pode interpretá-lo como um sensor simplesmente). O `CharacterBody2D` já responde mais a física, mas não tanto assim, pois ele também deve responder aos inputs do jogador, então ele é mais meio termo.

## Shapes de colisão

Em alguns projetos anteriores, se tivéssemos que criar diversas paredes em um cenário (por exemplo), criaríamos um `StaticBody2D` por parede, cada um contendo um `CollisionShape2D`. Este approach no estilo "cada objeto é um node" teve como objetivo a didática. Uma outra maneira de abordar este exemplo seria criar um único `StaticBody2D` e colocar todas as shapes de colisão neste único node. Esta solução é mais simples e ideal para objetos que pertencem ao mesmo "pacote". Pode-se fazer isso para o `RigidBody2D` também, mas é necessário ter mais precaução neste caso. No caso de haver diversas shapes de colisão em um único `RigidBody2D`, cada shape é considerada como uma "parte" do corpo. Se um `RigidBody2D` com diversas partes cai no chão, por exemplo, ele pode quicar, e o modo como o corpo reage dependerá do centro de massa em relação a essas shapes.

> PS: Apesar do `CollisionShape2D` ser o modo mais prático de atribuir uma shape para um corpo físico, também é possível utilizar o `CollisionPolygon2D`

## Mudança de escala e física
