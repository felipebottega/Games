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
    <img src="https://github.com/user-attachments/assets/57020a7d-c76f-48f2-90b9-9f415953cc61" width="300">
</p>

Gosto possui uma ótima documentação, inclusive ela está inclusa no próprio editor. Recomendo bastante!

<p align="center">
    <img src="https://github.com/user-attachments/assets/26309aae-2e3f-4354-93b9-94762de2c050" width="200">
</p>

