# Using InputEvent

Vamos começar vendo os tipos de eventos e como tratá-los. Depois disso passaremos para as funções nativas da Godot para receber eventos de input. Apenas abordaremos os tipos mais usuais, como eventos de teclado, mouse, gamepad, etc.

## Tipos de eventos de input

### InputEvent

O `InputEvent` é uma classe em Godot que é a base para todos os tipos de inputs. É possível utilizá-la para coisas genéricas, mas essa classe não serve para nenhum tipo de input em específico, justamente por ser genérica. Por exemplo, o código abaixo detecta qualquer input que tenha sido enviado para a engine (tecla pressionada, clique de mouse pressionado, scroll do mouse, botão de controle, etc). Assim que este input é liberado, o outro atributo detecta isso também.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/11e2f73e-4e62-4cf5-857b-8ec212e34e14" />
</p>

Quando um evento de input é detectado, ele é do tipo `InputEvent`, como no exemplo acima. Porém, esse tipo/classe possui "subtipos"/"subclasses" que são especializados por tipo de input. 

### InputEventKey

O `InputEventKey` é um tipo de evento de input, representando o ato de pressionar ou soltar uma tecla do teclado. Quando queremos trabalhar com inputs de teclado, verificamos se o evento é do tipo `InputEventKey` e então fazemos algo a partir do input no código. Abaixo, temos um código que funciona igual ao de cima para teclados. Neste caso o código só funciona para teclados. Note que agora não há um método para detectar se a tecla foi pressionada e outro para detectar se foir liberada. O que temos é um atributo booleano.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/ebe49cc5-d6b4-4be5-a79d-0774f7c1796e" />
</p>

### InputEventMouseButton

O `InputEventMouseButton` é um tipo de evento de input que representa cliques do mouse. O código abaixo é análogo aos dois códigos acima, mas para detecção de clique do mouse. Há uma diferença sutil entre o comportamento deste código e dos anteriores. Se você segurar o clique do mouse, apenas o primeiro clique é registrado, enquanto que segurar uma tecla do teclado dispara uma sequência de detecções que só se encerra quando a tecla é solta.

<p align="center">
  <img width="410" src="https://github.com/user-attachments/assets/c42a3e2b-7106-4231-a4a1-37df11415fd1" />
</p>

### InputEventMouseMotion

O `InputEventMouseMotion` é um tipo de evento de input que representa movimentos do mouse. Abaixo, fizemos um código que detecta se o o tipo de evento é movimento do mouse e, caso seja, mostra a posição do ponteiro no output.

<p align="center">
  <img width="440" src="https://github.com/user-attachments/assets/fdebb07b-60bb-4870-ba21-f33282f530e5" />
</p>

### InputEventJoypadMotion

O `InputEventJoypadMotion` é um tipo de evento de input que representa os movimentos dos eixos (como joystick ou gatilhos analógicos) de um gamepad. O código abaixo retorna um float entre -1 e 1 conforme você move o analógico do joystick (detectado automaticamente). Não acho que este é o melhor método para trackear estes movimentos, mas fica aqui pois está na lista da documentação.

<p align="center">
  <img width="330" src="https://github.com/user-attachments/assets/d27a7c07-f580-4701-90c9-fe35db8366b2" />
</p>

### InputEventJoypadButton

O `InputEventJoypadButton` é um tipo de evento de input que representa o ato de pressionar ou soltar um botão do gamepad.

<p align="center">
  <img width="410" src="https://github.com/user-attachments/assets/1f52aa74-ded0-412e-af79-ea3c4a9480dc" />
</p>


