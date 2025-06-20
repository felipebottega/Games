# Galton Board 3

Assim que mostrei o Galton Board 2 para alguns conhecidos, recebi pedidos. Como estes pedidos faziam bastante sentido e são fáceis de implementar, resolvi fazer logo. Um pedido era para aumentar o slider pois ele estava muito discreto, e outro eras para colocar poder alterar mais parâmetros (com sliders). 

Colocar mais sliders visualmente é fácil, só ir no HUD e acrescentar os nodes necessários e seus labels. Mudei um pouco algumas coisas na nomenclatura, mas nada demais. Cada slider tem sua própria configuração de parâmetros, não se esqueça de configurar.

<p align="center">
  <img src="https://github.com/user-attachments/assets/23bf0370-078e-4a8b-abfe-5179a557d167" width="700">
</p>

Além de configurar os valores nos sliders, você também deve adaptar o script de acordo. A ideia geral é seguir a receita do que foi feito para o slider que já existia. O único que requer um pouco mais de atenção é o fator de escala da bolinha. A observação que foi feita [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Animation%202#rigidbody2d-vs-characterbody2d-vs-node2d) para a posição de `RigidBody2D` também vale para mudança de escala. Não altere a escala de um `RigidBody2D` diretamente, mas sim de seus filhos, um `Sprite2D` e um `CollisionShape2D` nesse caso.

<p align="center">
  <img src="https://github.com/user-attachments/assets/791fdbf5-8cd2-4ae6-83bc-f583f2813334" width="500">
  <img src="https://github.com/user-attachments/assets/11aaa3b3-63da-4aff-8907-f0b2b7a987ca" width="250">
  <img src="https://github.com/user-attachments/assets/865dcc63-d71d-4e97-8787-817dd0c8dc48" width="480">
  <img src="https://github.com/user-attachments/assets/1e90b2e1-8a39-4f8a-8769-330b01308c97" width="430">
</p>

> PS: Não é possível utilizar `$Ball/Sprite2D.scale = Vector2(ball_scale, ball_scale)` nem `$Ball/CollisionShape2D.scale = Vector2(ball_scale, ball_scale)` no script, pois em Godot, `$node_name` é um atalho para `get_node("node_name")`, mas `ball` é uma instância criada dinamicamente que só existe dentro do `_physics_process`. Como ela não é um filho da cena Main, a chamada não funciona.
