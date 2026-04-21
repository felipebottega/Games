# User interface - UI

Quando se fala de UI ("User Interface") em Godot, basicamente estamos falando da classe `Control`. No que diz respeito à objetos visuais 2D, ela fica logo ao lado do `Node2D` na hierarquia de classes da engine. Lembrando que `CanvasItem` é a classe responsável por todas os objetos visuais 2D.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/0a547436-ee9f-45ef-9c0d-b8becb4527e1" />
</p>

Não é obrigatório, mas quando se deseja que um objeto de UI seja parte do HUD, ele deve ser filho de um `CanvasLayer` (vimos isso [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Heads%20up%20display/Galton%20Board%202#cena-do-hud), por exemplo). Assim, o que acontece no jogo não afeta este objeto, pois ele pertence à outra camada. Caso o objeto fosse filho de um `Node2D`, por exemplo, qualquer alteração no `Node2D` afetaria também o objeto.  

Até agora, sempre manipulamos HUD e objetos de UI sem nenhum tutorial formalizado. Todo aprendizado veio conforme a necessidade. Agora chegou a hora de abordar este tópico de maneira mais organizada.
