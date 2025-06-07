# Signals 2

Como prometido, vamos abordar agora o tópico avançado de sinais. Não é avançado de verdade, o que muda é que o em vez de configurá-los clicando em ícones, agora eles são configurados via código. O projeto será o mesmo de antes, só vamos incluir um sinal a mais. 

Se você jogou o jogo, deve ter notado que existe uma zona de impulso vertical localizada quase no centro do jogo, e ela fica 100% do tempo ativa para evitar que as bolinhas fiquem presas ali. Vamos alterar essa dinâmica para que esse impulso central fique oscilando entre ativado e desativado a cada 4 segundos. Para este fim, vamos adicionar um node `Timer` à cena original do impulso. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/10efe3d3-58b6-44a1-920b-34d8a87e5ff9" width="200">
</p>

> PS: Poderíamos pensar em adicionar o `Timer` apenas ao node `Impulse 3` da cena principal já que esse é o node do impulso central. Porém, como o script é único e o nosso approach será por script, o tratamento todo tem que ser na cena original do impulso.
>
> ## Timer

O node `Timer` possui poucas propriedades para mexer, portanto é um node simples. O que fizemos foi alterar o `Wait Time` para 4 segundos e habilitar o `Autostart`. A primeira propriedade diz que o countdown é de 4 segundos, e depois vai se repetir indefinidamente (este é o comportamento default, para fazer o countdown uma única vez tem que habilitar o `One Shot`). A segunda propriedade diz que o countdown deve começar assim que a cena principal começa a rodar (sem isso, precisaríamos dar o start no countdown de alguma outra maneira).

<p align="center">
    <img src="https://github.com/user-attachments/assets/977d6cf6-a445-40ab-afbe-239ac0b8e9f6" width="250">
</p>

