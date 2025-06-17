# Add Child

Assim como foi ocorreu no [jogo do tutorial](https://felipebottega.github.io/Games/Getting%20started/Your%20first%202D%20game/First%20Game%20in%20Godot/html/), haverá vários outros momentos em que você precisará instanciar outras cenas de maneira automatizada. Isso é feito através do método `add_child`, mas ainda vamos precisar ver algumas coisas antes de chegar nisso.

Vamos começar preparando a cena do mob, que consiste das 3 animações que ele possui. Estamos nos baseando parcialmente no projeto [Animation 2](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Animation%202) para a criação desta cena. Abaixo segue um resumo gerawl de como as coisas estão configuradas. O objeto raíz da cena é um `RigidBody2D`. Uma coisa que percebi na prática é que esses objetos perdem velocidade com o tempo mesmo sem gravidade e fricção e com todos os damps zerados. Para evitar que isso aconteça, vá em *Linear → Damp Mode* e selecione a opção *Replace*. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/df8dd26c-814c-46c9-ab0b-50e3e9aebab9" width="1100">
</p>

Agora vamos criar uma cena com uma trajetória, baseado nos aprendizados vistos em [Path2D](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Path2D). O sprite não é necessário para o jogo do tutorial, apenas vamos incluí-lo para visualizar o que está acontecendo, ou seja, onde está o `PathFollow2D` a cada instante. É mais didático assim.

<p align="center">
    <img src="https://github.com/user-attachments/assets/75235ea3-d3fb-498c-93c2-5ce991851b32" width="700">
</p>

## position vs global_position em Path2D

Uma outra coisa que aprendi na prática é que o percurso de um `PathFollow2D` semppre começa no ponto $(0, 0)$, é como se ele estivesse num espaço separado. Não adianta você mover a trajetória da cena do `Path2D` nem a da main. O ponto $(0, 0)$ é o que você vai receber sempre que acessar o atributo `position` do  `PathFollow2D` no instante inicial. Caso você queria saber onde está o ponto em relação ao "mundo real", tem que usar o atributo `global_position`. Vamos ver mais adiante isso em uso.

## Configurando a Main

A cena principal será um `Node2D` contendo a cena do `Path2D` e um `Timer`. Com este último objeto, queremos lançar um mob na tela a cada 1 segundo. Faremos isso usando o sinal `timeout`, como mostrado abaixo. Note que o *Autostart* deve estar ativado.

<p align="center">
    <img src="https://github.com/user-attachments/assets/da653f2e-1af7-4633-9152-11fb50dcacb7" width="750">
</p>

Vamos começar com o script simples mostrado abaixo e, aos poucos, vamos colocando mais linhas de código nele.

<p align="center">
    <img src="https://github.com/user-attachments/assets/d15065ca-c3d4-44f5-a09f-e67074799fbe" width="700">
</p>

Note que a função `_on_timer_timeout` possui o ícone verde ao lado, indicando que é uma função que é disparada por um sinal. Primeiro ela acessa o objeto `PathFollow2D`, que é o ponto que se move ao longo da trajetória. Depois disso ela altera o `progress_ratio` (o percentual da posição do ponto em relação ao trajeto) para um número aleatório entre 0 e 1. Isso significa que a função muda a posição do ponto na trajetória. Como esta ponto tem um sprite associado, conseguimos ver ele mudando de posição. Do jeito que está o projeto, já é possível executar e ver o sprite mudando de posição aleatoriamente.

## PackedScene

Um `PackedScene` é uma classe que representa uma cena salva em memória e pronta para ser instanciada em tempo de execução. Quando você cria uma cena, ela é salva como um arquivo *.tscn*. Se você quiser criar cópias dessa cena no jogo (como vários inimigos iguais), você carrega o arquivo como um PackedScene, e então você pode instanciá-lo quantas vezes quiser. 

No código abaixo, a variável `mob_scene` é como um molde da cena original. A variável `mob` é uma instância real da cena, ou seja, é um node que pode ser manipulado, movido, animado, receber sinais, etc. Porém, ele só passa a existir de fato na árvore de nodes do seu jogo depois de `add_child`. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/bd5a00fb-7817-4930-ac00-189ca15ff587" width="700">
</p>




