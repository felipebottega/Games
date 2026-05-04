# Mouse and input coordinates

No tutorial oficial eles enfatizam que não é para buscar obter as coordenadas do mouse na tela a partir da coordenadas da tela (*screen cooridnates*). Aliás, já enfatizamos [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Viewport%20and%20canvas%20transforms#atributo-transform) que é para evitar ao máximo este sistema de coordenadas. Veremos nesse tutorial como fazer iso da maneira correta.

## Mouse e coordenadas da viewport

Use as coordenadas da viewport para obter a posição do mouse na tela. Fizemos um "jogo" associado a este tutorial, para mostrar como aplicar este conhecimento novo. Primeiro a cena começa chamando a função `get_viewport().get_visible_rect().size` para mostrar as dimensões da viewport do jogo. Depois disso temos a função nativa `_input` que reage a eventos de input de mouse: cliques e movimentos. Ela reage printando na tela a posição do mouse. Por default, essa posição sempre é em relação à viewport. Inclusive, este jogo contém um `CharacterBody2D` com uma `Camera2D`. Você pode deixar o mouse estático na tela e mover o personagem pelo cenário. Vai reparar que, quando clica, a posição do mouse não se altera, a menos que você o mude de posição. As coordenadas da viewport são em relação à tela e não ao mundo do jogo, por isso o `event.position` só se altera se a posição do mouse **na tela** se alterar.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/34763353-0bda-49d7-9a26-d46ba333be15" />
</p>

> PS: Você também poderia chamar a função `get_viewport().get_mouse_position()` em vez de `event.position`. São chamadas equivalentes.

## get_viewport().get_visible_rect().size vs get_viewport_rect().size

A chamada `get_viewport_rect().size` é um atalho para `get_viewport().get_visible_rect().size`, de modo que ambas são equivalentes e retornam o retângulo da viewport. Porém, não é verdade que `get_viewport_rect()` seja um atalho para `get_viewport().get_visible_rect()`.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Input%20examples">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Customizing%20the%20mouse%20cursor">Próximo ➡</a>
</p>
