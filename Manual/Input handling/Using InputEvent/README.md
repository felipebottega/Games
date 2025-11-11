# Using InputEvent

O `InputEvent` é uma classe em Godot que é a base para todos os tipos de inputs. É possível utilizá-la para coisas genéricas, mas essa classe não serve para nenhum tipo de input em específico, justamente por ser genérica. Por exemplo, o código abaixo detecta qualquer input que tenha sido enviado para a engine (tecla pressionada, clique de mouse pressionado, scroll do mouse, botão de controle, etc). Assim que este input é liberado, o outro atributo detecta isso também.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/11e2f73e-4e62-4cf5-857b-8ec212e34e14" />
</p>

Quando um evento de input é detectado, ele é do tipo `InputEvent`, como vemos no exemplo acima. Mas esse tipo possui "subtipos", que são especializados por tipo de input.
