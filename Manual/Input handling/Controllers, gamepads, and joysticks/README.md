# Controllers, gamepads, and joysticks

Godot oferece suporte a centenas de modelos de controles prontos para uso. Os controles são compatíveis com Windows, macOS, Linux, Android, iOS e Web. Note que dispositivos mais especializados, como volantes, pedais de leme e HOTAS, são menos testados e podem não funcionar sempre como esperado.

## Supporting universal input

Por causa do sistema de *ação de input* da Godot, não é necessário ter códigos separados para cada tipo de input. Você pode simplesmente criar uma ação de input e associa-la a diversos inputs diferentes. Isso só não vale para mouse. O tratamento de inputs de mouse deve ser separado do restante.

Abaixo, segue um pequeno guia de quando usar cada chamada de input. Vimos um pouco sobre isso [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Using%20InputEvent#input-actions), mas vale a pena dar uma repassada neste tópico, acrescentando algumas informações novas.

  - **Input.get_vector:** Geralmente usado quando temos 2 eixos ($x$ e $y$) para trabalhar.
  - **Input.get_axis:** Geralmente usado quando temos apenas 1 eixo para trabalhar.
  - **Input.get_action_strength:** Este é útil para inputs que tem percepção de intensidade, como controle analógico. O argumento de entrada é o nome da ação de input, e ele retorna um valor entre $0$ e $1$, indicando a intensidade do input.
  - **Input.is_action_pressed:** Para inputs digitais/booleanas não-analógicos (apenas valores "pressionado" ou "não pressionado"), como botões de controle, botões de mouse ou teclas de teclado. As intensidades são apenas $0$ ou $1$.

> PS: No caso do `Input.is_action_pressed`, já vimos que ele percebe quando o input continua sendo pressionado em um `InputEvent`, mas isso n~çao vale para joysticks/gamepads. Nesses casos é mais aconselhável usar o *ação de input* em um `_process`.
