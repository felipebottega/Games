# Signals 1

Este pequeno jogo teve como objetivo a aplicação de *sinais* em Godot. Apenas utilizamos os sinais na sua forma simples, isto é, sem código, apenas clicando em ícones da interface da Godot. Em *Signals 2* veremos o modo mais avançado de tratar de sinais. 

## Trabalhando apenas com shapes de colisão

Antes de falar de sinais, quero falar de algumas coisas novas que aprendi, começando pelos shapes de colisão. Eu não sabia disso, mas é possível não utilizar sprites e usar apenas os shapes de colisão. Isso significa focar na mecânica e deixar o visual de lado. Com sprites ou não, você pode ir em *Debug* e selecionar a opção *Visible Collision Shapes*, com isso as shapes de colisão sempre estarão visíveis, o que é bom para debugar.

<p align="center">
    <img src="https://github.com/user-attachments/assets/fd0ea7fe-f297-42b6-b632-3595d956a002" width="200">
</p>

## Polygon2D e CollisionPolygon2D

Para este jogo, eu queria formatos que não fossem quadrados ou elipses. Até tem como usar formas côncavas com o `CollisionShape2D` mas não consegui fazer funcionar e o próprio editor me recomendou usar `Polygon2D` e `CollisionPolygon2D`. Ao carregar o `CollisionPolygon2D`, ele te dá uma forma de quadrado no espaço 2D, é para criar o seu shape dentro deste quadrado. Veja três opções acima do quadrado, na figura. A que está marcada por default é para acrescentar pontos para o seu shape. A opção ao lado é editar o shape depois de pronto. A terceira opção é para remover pontos (na minha opinião a opção de edição já faz adição e remoção de pontos, então a terceira me pareceu redundante). 

<p align="center">
    <img src="https://github.com/user-attachments/assets/173a51f1-f9a7-4344-af7f-718864ac4f55" width="200">
</p>

Você deve fazer um shape igual com o `Polygon2D` e sobrepor ambos no espaço 2D. Estes dois nodes devem ser filhos de um outro, como um `StaticBody2D` neste caso. O propósito do `Polygon2D` é introduzir a textura dentro de um formato que você criou na Godot. Caso contrário, teria que criar um PNG com o formato exato do shape da colisão, o que seria muito mais trabalhoso.

## Impulsos

Este jogo é basicamente uma simulação de <a href="https://www.anos80.com.br/brinquedos/aquaplay.html">Aquaplay</a>, um jogo que joguei bastante na minha infância. Diversas bolinhas estão dentro da água e você aperta botões para expelir ar e impulsioná-las para cima, com o objetivo de colocá-las em certos pontos target. Um approach para obter este efeito é criar uma cena com o node `Area2D` como raíz e um `CollisionShape2D` para demarcar uma região. Se algum outro objeto com física entrar nesta região, automaticamente é aplicada uma força para cima nele, simulando o jato de ar do jogo.

<p align="center">
    <img src="https://github.com/user-attachments/assets/f28238b3-4a76-4919-ab18-71b8e1c0a224" width="300">
</p>

A lógica é simples, o método `get_overlapping_bodies` gera uma lista de todos os objetos físicos dentro da região em um instante. Daí faz um loop nestes objetos e aplica uma força `force` nele. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/1ef91515-97c7-4acd-8708-5ec77c2f2d01" width="300">
</p>

A variável `force` é um vetor que foi definido globalmente no código, como mostrado abaixo. O interessante de definir usando o `@export` é que essa variável passa a ser manipulável na aba *Inspector* à direita da tela. Isso pode ser feito para qualquer variável global.

<p align="center">
    <img src="https://github.com/user-attachments/assets/20b951c5-7486-4f8c-bf19-4a4805a53125" width="750">
</p>

> PS: É possível fazer atualizações de física com o `_process` em vez do `_physics_process`, ainda vai funcionar. O primeiro é chamado a cada frame, podendo ser suscetível a lags ou ter atualização muito rápida. Normalmente se usa a variável `delta` para fazer as correções necessárias e atualizar de acordo com o tempo, não o frame. O segundo nativamente já atualiza a uma taxa constante no tempo, ou seja, tem o `delta` constante. Isso é o ideal se quisermos consistência nos fenômenos físicos. Além disso, a  `_physics_process` é otimizada para física.

## Signals

Agora sim vamos falar de sinais! Há dois botões principais, um para "soltar ar" pelo canal direito e outro pelo esquerdo. Uma vez que você criou e configurou a aparência do node `Button`, vá na aba *Node* à direita do painel. Este painel contém todos os sinais que o botão pode emitir, cada um exige que se tire um tempo para entender como funciona. Aqui neste exemplo usaremos o sinal `pressed`. Ele emite um sinal quando o botão é pressionado. Dê o segundo clique nele e selecine a opção de conectar.

<p align="center">
    <img src="https://github.com/user-attachments/assets/d1786bb6-463f-47e3-a21b-d1fdb28167fc" width="250">
</p>

Uma janela contendo diversos nodes vai se abrir. Estes são os nodes da mesma cena onde está o botão que você escolheu para enviar o sinal. Ao escolher o node, o pressionar do botão vai ativar a execução de uma função no script deste node. Abaixo, na figura, note que temos o nome `_on_left_button_pressed`. Esta é a sugestão de nome de função dada pela Godot. Esta sugestão sempre é da forma `_on_{node_name}_{signal_name}`, mas você pode alterar. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/04c99364-f6bd-49a1-826f-8ddb1fee9d45" width="350">
</p>

Feito isso, você será redirecionado para o script automaticamente, e a função nova estará lá, mas sem conteúdo nenhum. Cabe a você implementar o que vai acontecer com este trigger que acabou de criar.

<p align="center">
    <img src="https://github.com/user-attachments/assets/3cc0494b-3c3d-495d-9544-21a4d4e48727" width="300">
</p>

Neste jogo, o botão se conecta com o node responsável pelos impulsos de ar nas bolinhas. Parte do script associado a este node está mostrado abaixo, com a função nova que é ativada quando o sinal do botão é enviado. O comando `set_physics_process(not is_physics_processing())` liga ou desliga todos os processos físicos deste node. Logo abaixo temos uma condicional que altera a cor do botão dependendo se a física está ligada ou desligada. O node `Left Button`, por exemplo, se conecta com o `Impulse 1`, que é um quadrado de colisão invisível no lado esquerdo da tela, responsável pelos impulsos de ar naquela parte da tela. Como o script está vinculado à `Impulse 1`, a linha de código `$"../../Left Button"` faz o caminho relativo para acessar o objeto `Left Button` e assim acessar seus métodos e atributos. É assim que o pressionar do botão consegue alterar o estado de mais de um node.

<p align="center">
    <img src="https://github.com/user-attachments/assets/e474fc29-9217-43ca-84e4-8c28c2c3b8dc" width="600">
    <img src="https://github.com/user-attachments/assets/3574021d-ddf0-48b4-abc5-b3be89c1181a" width="400">
</p>

> PS: Note que o script da cena original de impulso foi instanciada em `Impulse 1`, `Impulse 2` e `Impulse 3`, sendo que a chamada de `_on_left_button_pressed` não tem relação alguma com `Impulse 2` e `Impulse 3`. Ainda assim, ao pressionar o botão esquerdo essa função desliga a física como um todo. Por que só o `Impulse 1` foi afetado? Acontece que cada uma dessas instâncias compartilha o mesmo script, mas possui seu próprio estado interno e responde a eventos de forma independente. O botão `Left Button` está conectado especificamente à instância `Impulse 1`. O `set_physics_process` está sendo chamado dentro da instância `Impulse 1`. Cada instância executa seu próprio script separadamente, como se fossem cópias independentes em memória, embora compartilhem o mesmo "molde" (a cena base + script). Apesar da função `_on_left_button_pressed` estar presente em `Impulse 2` e `Impulse 3`, o sinal de pressionar o botão esquerdo chega apenas em `Impulse 1`.

Por fim, o botão de restart possui lógica semelhante, mas com um propósito diferente. Na imagem abaixo conseguimos ver na aba de node à direita que ele também se vale do sinal `pressed` para ativar a função `_on_restart_pressed` que está no script do node raíz da cena principal, o `Game`, que é do tipo `Node2D`. A chamada `get_tree().reload_current_scene()` serve exatamente para reiniciar a cena que chamou o script.

<p align="center">
    <img src="https://github.com/user-attachments/assets/fe0c2228-ff61-4f6e-baff-4f85b670c14a" width="1000">
</p>
