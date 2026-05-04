# Controllers, gamepads, and joysticks

Godot oferece suporte a centenas de modelos de controles prontos para uso. Os controles são compatíveis com Windows, macOS, Linux, Android, iOS e Web. Note que dispositivos mais especializados, como volantes, pedais de leme e [HOTAS](https://en.wikipedia.org/wiki/HOTAS) são menos testados e podem não funcionar sempre como esperado.

## Supporting universal input

Por causa do sistema de [input action](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Using%20InputEvent#input-actions) da Godot, não é necessário ter códigos separados para cada tipo de input. Você pode simplesmente criar uma *input action* e associá-la a diversos inputs diferentes. Isso só não vale para mouse. O tratamento de inputs de mouse deve ser separado do restante.

Abaixo, segue um pequeno guia de quando usar cada chamada de input. Vimos um pouco sobre isso [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Using%20InputEvent#input-actions), mas vale a pena dar uma repassada neste tópico, acrescentando algumas informações novas.

- **Input.get_vector:** Geralmente usado quando temos 2 eixos ($x$ e $y$) para trabalhar.
- **Input.get_axis:** Geralmente usado quando temos apenas 1 eixo para trabalhar.
- **Input.get_action_strength:** Este é útil para inputs que tem percepção de intensidade, como controle analógico. O argumento de entrada é o nome da ação de input, e ele retorna um valor entre $0$ e $1$, indicando a intensidade do input.

> PS: Vale notar que a Godot já percebe a intensidade do direcional analógico automaticamente para as funções `Input.get_vector` e `Input.get_axis`. Normalmente você vai querer usar `Input.get_action_strength` para inputs novos que necessitam de controle de intensidade.

- **Input.is_action_pressed:** Para inputs digitais/booleanas não-analógicos (apenas valores "pressionado" ou "não pressionado"), como botões de controle, botões de mouse ou teclas de teclado. As intensidades são apenas $0$ ou $1$.

> PS: No caso do `Input.is_action_pressed`, já vimos que ele percebe quando o input de teclado continua sendo pressionado em um `InputEvent`, mas isso não vale para joysticks/gamepads. Nesses casos é mais aconselhável usar uma ação de input em um `_process`.

## Dead zone

Controles com direcional analógico possuem intensidade e por isso devem ser trabalhados com a função `Input.get_action_strength`. Algumas vezes eles podem sofrer do fenômeno chamado de "drifting", em que o analógico envia sinais de intensidade muitos fracos mesmo sem ninguém tocar neles. Isso pode causar leves movimentos contínuos e indesejados no jogo. Para evitar que isso aconteça, é comum se aplicar uma *dead zone*, que é um intervalo de valores onde a intensidade do input é considerada zero automaticamente. 

> PS: A função `Input.get_vector` possui o parâmetro *deadzone*. Se você determinar que *deadzone* $=0.5$, por exemplo, então qualquer input com intensidade menor que $0.5$ é considerado como tendo intensidade $0.0$ automaticamente. 

Por default, todas as *ações de input* da Godot possuem deadzone igual a $0.5$. Você pode alterar isso para cada input no Project Settings.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/bc630f2d-27e5-4a52-a9d9-fdda4227634f" />
</p>

## Jogo teste de aceleração

Para testar o conhecimento adquirido aqui, fiz um "jogo", que é basicamente um sprite que pode se mover pela tela. A ideia é movê-lo com um controle analógico que possua um botão analógico para controlar a aceleração. Para isso, vá em *Project → Project Settings → Input Map* e crie uma ação de input nova. Para testar este jogo você deve baixar o projeto e rodar na engine. A versão web não respondeu aos inputs.

<p align="center">
  <img width="830" src="https://github.com/user-attachments/assets/2f057ceb-e1a1-4e50-82c8-1820d7e937aa" />
</p>

O sprite possui uma velocidade máxima de $500$ pixels/segundo. A aceleração se dá pelo botão novo que configuramos. Note que o sprite fica imóvel mesmo que você pressione os direcionais. Para mover é necessário usar o botão de aceleração, e ele será sensível à intensidade aplicada. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/a08a9c31-04d5-4063-ac34-41562ecb8408" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Customizing%20the%20mouse%20cursor">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Handling%20quit%20requests">Próximo ➡</a>
</p>
