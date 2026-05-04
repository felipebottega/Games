# Input examples

Este tutorial consiste apenas de um pequeno conjunto de dicas sobre inputs. Listamos abaixo as que considerei mais relevantes.

## Lista de dicas sobre o uso de inputs

1. Todo evento possui o método `as_text()` que printa na tela algumas informações básicas do input detectado (ex. tecla pressionada, posição do mouse).

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/19d637db-224f-40de-9a0f-a8e351bb43fa" />
</p>

2. Você pode usar os métodos `is_action_pressed()` e `is_action_released()` para detectar se uma ação de input foi acionada ou liberada, usando o nome da ação.

<p align="center">
  <img width="580" src="https://github.com/user-attachments/assets/0994e52c-1dc4-4643-a151-78665092d5ce" />
</p>

3. Em [@GlobalScope_Key](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-key) você vai encontrar diversas constantes de identificação de teclas. Um exemplo simples de aplicação é dado abaixo.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/682ead3f-3285-4ce1-b8b8-db0bae12d3bf" />
</p>

4. É possível adicionar *modificadores* aos sinais de input, isto é, inputs junto de outros inputs que modificam o primeiro. Por exemplo, um input ser a letra "T" e outro input ser "T + shift". Neste caso, o shift é o "modificador" do input "T". Modificadores podem ser utilizados por todas as classes que herdam de [InputEventWithModifiers](https://docs.godotengine.org/en/stable/classes/class_inputeventwithmodifiers.html#class-inputeventwithmodifiers). 

<p align="center">
  <img width="620" src="https://github.com/user-attachments/assets/3d0b16bc-4938-4a65-9ac7-54f7899bcf5b" />
</p>

5. Em [@GlobalScope_MouseButton](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-mousebutton) você vai encontrar diversas constantes de identificação de botões de mouse. Note que o scroll (wheel) do mouse também é considerado um botão do mouse. Um exemplo simples de aplicação é dado abaixo.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/f3e9decc-e32a-4826-a3cd-fc725d43f9e8" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Using%20InputEvent">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Mouse%20and%20input%20coordinates">Próximo ➡</a>
</p>
