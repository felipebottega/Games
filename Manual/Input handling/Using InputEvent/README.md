# Using InputEvent

Vamos começar vendo os tipos de eventos e como tratá-los. Depois disso passaremos para as funções nativas da Godot para receber eventos de input. Apenas abordaremos os tipos mais usuais, como eventos de teclado, mouse, joystick/gamepad, etc.

## Tipos de eventos de input

### InputEvent

O `InputEvent` é uma classe em Godot que é a base para todos os tipos de inputs. É possível utilizá-la para coisas genéricas, mas essa classe não serve para nenhum tipo de input em específico, justamente por ser genérica. Por exemplo, o código abaixo detecta qualquer input que tenha sido enviado para a engine (tecla pressionada, clique de mouse pressionado, scroll do mouse, botão de controle, etc). Assim que este input é liberado, isso é detectado também.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/11e2f73e-4e62-4cf5-857b-8ec212e34e14" />
</p>

> PS: É bom deixar claro o evento de liberar um input não é o mesmo que não ter nenhum input pressionado. A engine detecta que havia um input pressionado que foi liberado. Caso não tenha nenhum input, a engine não entra em nenhum dos ifs acima.  

Quando um evento de input é detectado, ele é do tipo `InputEvent`, como no exemplo acima. Porém, esse tipo/classe possui "subtipos"/"subclasses" que são especializados por tipo de input. Estes subtipos seguem abaixo.

### InputEventKey

O `InputEventKey` é um tipo de evento de input, representando o ato de pressionar ou soltar uma tecla do teclado. Quando queremos trabalhar com inputs de teclado, verificamos se o evento é do tipo `InputEventKey` e então fazemos algo a partir do input, no código. Abaixo, temos um código que funciona igual ao de cima, mas para para teclados. Note que agora não há um método para detectar se a tecla foi pressionada e outro para detectar se foi liberada. O que temos é um atributo booleano.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/ebe49cc5-d6b4-4be5-a79d-0774f7c1796e" />
</p>

### InputEventMouseButton

O `InputEventMouseButton` é um tipo de evento de input que representa cliques do mouse. O código abaixo é análogo aos dois códigos acima, mas para detecção de clique do mouse. Há uma diferença sutil entre o comportamento deste código e dos anteriores. Se você segurar o clique do mouse, apenas o primeiro clique é registrado, enquanto que segurar uma tecla do teclado dispara uma sequência de detecções que só se encerra quando a tecla é solta.

<p align="center">
  <img width="410" src="https://github.com/user-attachments/assets/c42a3e2b-7106-4231-a4a1-37df11415fd1" />
</p>

### InputEventMouseMotion

O `InputEventMouseMotion` é um tipo de evento de input que representa movimentos do mouse. Abaixo, fizemos um código que detecta se o tipo de evento é movimento do mouse e, caso seja, mostra a posição do ponteiro na tela.

<p align="center">
  <img width="440" src="https://github.com/user-attachments/assets/fdebb07b-60bb-4870-ba21-f33282f530e5" />
</p>

### InputEventJoypadMotion

O `InputEventJoypadMotion` é um tipo de evento de input que representa os movimentos dos eixos (como joystick ou gatilhos analógicos) de um joystick. O código abaixo retorna um float entre -1 e 1 conforme você move o analógico do joystick (detectado automaticamente). Não acho que este é o melhor método para trackear estes movimentos, mas fica aqui pois está na lista da documentação.

<p align="center">
  <img width="330" src="https://github.com/user-attachments/assets/d27a7c07-f580-4701-90c9-fe35db8366b2" />
</p>

### InputEventJoypadButton

O `InputEventJoypadButton` é um tipo de evento de input que representa o ato de pressionar ou soltar um botão do joystick.

<p align="center">
  <img width="410" src="https://github.com/user-attachments/assets/1f52aa74-ded0-412e-af79-ea3c4a9480dc" />
</p>

## Pipeline dos eventos de input

Quando um input é enviado pelo jogador, ele passa por várias camadas da engine. Cada camada possui prioridade sobre as camadas abaixo, isto é, recebem o input antes das outras. Além disso, é possível trabalhar o sinal de input em uma camada e cancelar a sua propagação para as próximas camadas. A Godot usa essas camadas para organizar a lógica de como os eventos são tratados (a questão de latência não é relevante).

A figura abaixo (do manual oficial) ilustra a disposição das camadas, de cima para baixo. No que diz respeito ao desenvolvimento, apenas a camada *Input Event* em diante é possível de se manipular. As camadas anteriores a essa basicamente lidam com todo o caminho entre o usuário e a entrada do sinal na engine. Uma vez que o sinal foi capturado e teve um tratamento preliminar para virar um `InputEvent`, aí sim entra o dev.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/d69efe51-8e03-4b35-81dc-633c0fb93c4f" />
</p>

### Input Event

Todo `InputEvent` primeiro é passado para os nodes que implementaram o método nativo `_input(event)`. Todos os códigos dos exemplos acima utilizaram este método. Esta camada é utilizada para interceptação global. Pode ser utilizada para debugar ou detecção geral de pressionar teclas. Se quiser que o input não propague para as camadas seguintes, você pode usar o comando `get_viewport().set_input_as_handled()`. Abaixo, segue um exemplo de código atuando nesta camada.

<p align="center">
  <img width="610" src="https://github.com/user-attachments/assets/288ffaca-76e0-4e38-98d1-534462c0934b" />
</p>

> PS: O comando `get_viewport().set_input_as_handled()` pode ser utilizado em qualquer camada para consumir o evento, assim ele não segue adiante para os próximas camadas.

### GUI Event

Após a camada *Input Event*, temos a camada da GUI ("Graphical User Interface"). Esta é a camada da interface visual: botões, menus, painéis, etc. A classe responsável por lidar com isso é a `Control`, mas ela será abordada melhor em outro momento. O input é passado para os nodes que implementaram o método nativo `_gui_input(event)`. Abaixo, segue um exemplo de código em um `Button`.

<p align="center">
  <img width="310" src="https://github.com/user-attachments/assets/faf18850-9c60-408b-9066-10d89b979d51" />
</p>

Repare como está a nossa árvore de nodes até agora. Só temos os 2 nodes mencionados acima e o node raíz. Se deixarmos os scripts do jeito que estão acima, o botão não vai reagir ao clique pois a primeira camada "consumiu" o evento com o `get_viewport().set_input_as_handled()`. Se você quiser ver o clique funcionando no botão, deve comentar este comando, aí as duas camadas vão reagir ao clique do mouse.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/31c22056-ea0a-4691-a899-0f00ab1153b4" />
</p>

> PS: Por default, a GUI sempre consome os inputs. Há alguma maneiras de liberar a propagação entre nodes GUI, mas ainda assim é limitado. Se você pretende usar o input para interagir na GUI e em outras camadas, é melhor algum dos métodos seguintes para atuar na GUI.

### Shortcut Input Event

Esta camada é específica para atalhos de teclado ou joystick. Na minha opinião ela é desnecessária, pois basta colocar estes comandos em alguma das duas camadas a seguir.

### Unhandled Key Input Event

Esta camada é específica para eventos de teclado que ainda não fora consumidos pelas camadas anteriores. O input é passado para os nodes que implementaram o método nativo `_unhandled_key_input(event)`. Abaixo, segue um exemplo de código atuando nesta camada.

<p align="center">
  <img width="390" src="https://github.com/user-attachments/assets/ef2c1c91-3991-4baa-855a-17f4107b32d9" />
</p>

### Unhandled Input Event

Se o evento ainda não foi consumido por nenhuma das camadas anteriores, ele chega nesta camada genérica. Aqui qualquer tipo de input é tratado: teclado, mouse, joystick, etc. O input é passado para os nodes que implementaram o método nativo `_unhandled_input(event)`. Abaixo, segue um exemplo de código atuando nesta camada.

<p align="center">
  <img width="360" src="https://github.com/user-attachments/assets/d97dd2bf-fa3b-4454-b815-ad6040f78aaf" />
</p>

### Physycs Picking Event

Se o evento de input ainda não foi consumido, a engine pode efetuar o *picking*, que é a detecção de colisão com cliques do mouse. Isso é útil quando você quer que um objeto físico responda ao input.  O input é passado para os nodes que implementaram o método nativo `_input_event(event)` e que ativaram a propriedade *Pickable*. Você pode ativar esta propriedade pelo *Inspector*.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/ce052cff-187d-4445-bac8-5a6a9bff4b76" />
</p>

Abaixo, segue um exemplo de código atuando nesta camada. Note ativamos a propriedade *Pickable* por código. Esse approach é interessante quando queremos ativar e desativar este comportamento dinamicamente durante o jogo. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/0fdb9f97-ba6c-49ae-9602-1c035a5e81fd" />
</p>

## Input actions

Os *input actions* (*ações de input*) são um agrupamento de `InputEvent` sob um mesmo título (por exemplo, o input default "ui_left" agrupa tanto a entrada do joystick quanto a tecla de seta esquerda do teclado). Os principais benefícios deste approach são:

 1. Permitir que o mesmo código funcione em diferentes dispositivos com diferentes entradas (por exemplo, teclado no PC, joystick no console).
 2. Permitir que a entrada seja reconfigurada em tempo de execução.
 3. Permitir que ações sejam acionadas programaticamente em tempo de execução.

Já vimos como criar estes agrupamentos nos tutoriais [Using TileMaps - Game](https://github.com/felipebottega/Games/blob/gh-pages/Manual/2D/Tools/Using%20TileMaps%20-%20Game/README.md), [2D movement overview](https://github.com/felipebottega/Games/blob/gh-pages/Manual/2D/2D%20movement%20overview/README.md#clicar-e-mover) e [Movements 2](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Listening%20to%20player%20input/Movements%202#inputs), então não vou repetir como funciona.

Qualquer um destes eventos criados possui os mesmos métodos que o `InputEvent`, como o `is_action()`, `is_pressed()` e `is_echo()`.
