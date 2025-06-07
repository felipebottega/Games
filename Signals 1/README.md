# Signals 1

Este pequeno jogo teve como objetivo a aplicação de *sinais* em Godot. Apenas utilizamos os sinais na sua forma simples, isto é, sem código, apenas clicando em ícones da interface da Godot. Em *Signals 2* veremos o modo mais avançado de tratar de sinais. 

## Trabalhando apenas com shapes de colisão

Antes de falar de sinais, quero falar de algumas coisas novas que aprendi, começando pelos shapes de colisão. Eu não sabia disso, mas é possível não utilizar sprites e usar apenas os shapes de colisão. Isso significa focar na mecânica e deixar o visual de lado. Com sprites ou não, você pode ir em *Debug* e selecionar a opção *Visible Collision Shapes*, com isso as shapes de colisão sempre estarão visíveis, o que é bom para debugar.

<p align="center">
    <img src="https://github.com/user-attachments/assets/fd0ea7fe-f297-42b6-b632-3595d956a002" width="200">
</p>

## Polygon2D e CollisionPolygon2D

Para este jogo, eu queria formatos que não fossem quadrados ou elipses. Até tem como usar formas côncavas com o `CollisionShape2D` mas não consegui fazer funcionar e o próprio editor me recomendou usar `Polygon2D` e `CollisionPolygon2D`. Ao carregar o `CollisionPolygon2D`, ele te dá uma forma de quadrado no espaço 2D, é para criar o seu shape dentro deste quadrado. Se atente às três opções acima. A que está marcada por default é para acrescentar pontos para o seu shape. A opção ao lado é editar o shape depois de pronto. A terceira opção é para remover pontos (na minha opinião a opção de edição já faz adição e remoção de pontos, então a terceira me pareceu redundante). 

<p align="center">
    <img src="https://github.com/user-attachments/assets/173a51f1-f9a7-4344-af7f-718864ac4f55" width="200">
</p>

Você deve fazer um shape igual com o `Polygon2D`, sobrepor ambos no espaço 2D. Estes dois nodes devem ser filhos de um outro, como um `StaticBody2D` neste caso. O propósito do `Polygon2D` é introduzir a textura dentro de um formato que você criou na Godot. Caso contrário, teria que criar um PNG com o formato exato do shape da colisão, o que seria muito mais trabalhoso.

## Impulsos

Este jogo é basicamente uma simulação de <a href="https://www.anos80.com.br/brinquedos/aquaplay.html">Aquaplay</a>, um jogo que joguei bastante na minha infância. Diversas bolinhas estão dentro da água e você aperta botões para expelir ar e impulsioná-las para cima, com o objetivo de colocá-las em certos pontos target. Eu descobri nesse projeto que você criar uma cena com o node `Area2D` como raíz e um `CollisionShape2D` para demarcar uma região. Se algum outro objeto com física entrar nesta região, automaticamente é aplicada uma força para cima nele, simulando o jato de ar do jogo.

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

## Signals

Agora sim vamos falar de sinais! 
