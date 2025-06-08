# Signals 2

Como prometido, vamos abordar agora o tópico avançado de sinais. Não é avançado de verdade, o que muda é que o em vez de configurá-los clicando em ícones, agora eles são configurados via código. O projeto será o mesmo de antes, só vamos incluir um sinal a mais. 

Se você jogou o jogo, deve ter notado que existe uma zona de impulso vertical localizada quase no centro do jogo, e ela fica 100% do tempo ativa para evitar que as bolinhas fiquem presas ali. Vamos alterar essa dinâmica para que esse impulso central fique oscilando entre ativado e desativado a cada 4 segundos. Para este fim, vamos adicionar um node `Timer` à cena original do impulso. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/10efe3d3-58b6-44a1-920b-34d8a87e5ff9" width="200">
</p>

> PS: Poderíamos pensar em adicionar o `Timer` apenas ao node `Impulse 3` da cena principal já que esse é o node do impulso central. Porém, como o script é único e o nosso approach será por script, o tratamento todo tem que ser na cena original do impulso.

## Timer

O node `Timer` possui poucas propriedades para mexer, portanto é um node simples. O que fizemos foi alterar o `Wait Time` para 4 segundos e habilitar o `Autostart`. A primeira propriedade diz que o countdown é de 4 segundos, e depois vai se repetir indefinidamente (este é o comportamento default, se quiser que o countdown seja executado uma única vez tem que habilitar a propriedade `One Shot`). A segunda propriedade diz que o countdown deve começar assim que a cena principal começa a rodar (sem isso, precisaríamos dar o start no countdown de alguma outra maneira).

<p align="center">
    <img src="https://github.com/user-attachments/assets/977d6cf6-a445-40ab-afbe-239ac0b8e9f6" width="250">
</p>

## Criando o sinal

Na aba *Node* do `Timer`, notasmo que ele possui apenas um sinal próprio, o `timeout`. Este sinal é emitido quando o countdown termina. Uma coisa que vale a pena mencionar é que os outros sinais mostrados na janela são dos nodes pais de `Timer`. Ele herda estes sinais, então pode usá-los também. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/57020a7d-c76f-48f2-90b9-9f415953cc61" width="250">
</p>

Gosto possui uma ótima documentação, inclusive ela está inclusa no próprio editor. Recomendo bastante!

<p align="center">
    <img src="https://github.com/user-attachments/assets/26309aae-2e3f-4354-93b9-94762de2c050" width="400">
</p>

Na função `_ready` do script do impulso, a linha `$Timer.timeout.connect(_on_timer_timeout)` é a responsável por criar a conexão entre o sinal `timeout` e a função `_on_timer_timeout` que você mesmo deverá criar no script. Note como isso é semelhante ao que você faz no editor com clique de mouse, você vai no `Timer`, busca o sinal `timeout` na aba Node, clica em `connect` para criar a conexão, e na janela da conexão você define que a função vai se chamar `_on_timer_timeout`. São todos esses passos resumidos numa única linha de código. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/9434a2ca-af65-4ff6-8fb2-8f09cbee6282" width="300">
    <img src="https://github.com/user-attachments/assets/789ea920-655e-41c0-af73-8870a19e4e87" width="380">
</p>

> PS: Usar `$Timer` é equivalente a usar `get_node("Timer")`. Note que a referência é sempre relativa. Por exemplo, poderíamos ter colocado o `Timer` dentro do `CollisionShape2D` (sendo um filho deste), e neste caso iríamos ter que usar a chamada `$CollisionShape2D/Timer` ou `get_node("CollisionShape2D/Timer")`. Funcionaria igual.

## Vantangens e desvantagens

Como acabamos de ver, criar conexões via código é mais direto. Além disso, tem situações em que o sinal só pode ser criado por código, como sinais criados dinamicamente in-game, por exemplo. A desvantagem é a falta de apelo visual. Ao clicar no node eu consigo ver na hora se tem algum sinal indicando conexão, e o próprio script indica quando uma função é ativada por sinal.

<p align="center">
    <img src="https://github.com/user-attachments/assets/571e24cb-248c-41f4-8a4e-8e6c94597f62" width="700">
</p>

O ícone verde à esquerda da função indica que a função é ativada por um sinal. Inclusive é possível clicar e ver mais informações, como mostrado acima. Note que a função `_on_timer_timeout` não possui tal ícone. Então no caso de sinais criados via script, você precisa lembrar deles (acredito que deve ter alguma ferramenta que ajuda nisso, mas não vi ainda).

## _init vs _ready

Colocando aqui as diferenças pois isso me pegou um pouco.

<p align="center">
    <img src="https://github.com/user-attachments/assets/d58522ac-dd69-416a-b8a7-72fc85187b3f" width="700">
</p>

O `_init` é chamado imediatamente quando a instância do script é criada. Não tem acesso à árvore ainda, ou seja, métodos como o `get_node` ainda não funcionam bem aqui. O método `_ready` só é chamado depois que o node atual foi adicionado à árvore de cena e todos os seus filhos também já foram adicionados. Ou seja, é o ponto em que todo mundo está no palco e você pode começar a interagir com segurança. 

<p align="center">
   <img src="https://github.com/user-attachments/assets/e2884af0-435f-4242-aa9d-eebfaa526d4b" width="700">
</p>
