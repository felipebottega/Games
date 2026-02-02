# Physics introduction

Já fizemos diversas aplicações de física em tutoriais anteriores, mas agora chegou o momento de encarar este tópico de maneira mais organizada. Por enquanto iremos ver tudo no contexto 2D, futuramente abordaremos os tópicos espeíficos de 3D. A primeira coisa a se ter em mente é que os principais nodes de física são: `Area2D`, `StaticBody2D`, `RigidBody2D` e `CharacterBody2D`. É a partir deles que aplicamos a maioria das propriedades físicas da engine.

## Physics material

Tanto o `StaticBody2D` quanto o `RigidBody2D` possuem a capacidade de terem suas propriedades físicas configuradas através do *Physics material*, que fica no *Inspector*. Com isso você cosegue manipular algumas características físicas do objeto. Não vou detalhar como cada um funciona, aconselho a testar na prática.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/a4f793da-ea48-4be7-9301-65b35c8ec567" />
  <img width="350" src="https://github.com/user-attachments/assets/a53e9a17-fc05-4460-8405-0660768d271f" />
</p>

Os nodes `Area2D` e `CharacterBody2D` não possuem *Physics material* por serem "menos físicos" que os dois nodes mencionados acima. O `Area2D` serve apenas para detectar colisão, mas não reage fisicamente a essas colisões (você pode interpretá-lo como um sensor simplesmente). O `CharacterBody2D` já responde mais a física, mas não tanto assim, pois ele também deve responder aos inputs do jogador, então ele é mais meio termo.

