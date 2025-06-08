# Signals 3

Nem todos os sinais disponibilizados pela Godot servem a todos os propósitos. Há momentos em que você vai querer um sinal que não está no conjunto de sinais deles. Par estes casos, é possível customizar seus próprios sinais. Neste projeto nós iremos fazer apenas um sinal customizado, que determina quando o jogo acabou e dispara uma mensagem de vitória na tela.

Começamos criando uma nova cena, que é um node raíz do tipo `Area2D` com uma shape de colisão. É a mesma receita usada para a área de impulso, mas em vez de aplicar impulso, estaremos contando o número de bolinhas na região e suas velocidades. A condição é que se todas as 36 bolinhas estiverem na região e a soma das suas velocidades horizontais forem praticamente nulas, então o jogador ganhou o jogo.

<p align="center">
    <img src="https://github.com/user-attachments/assets/53525b9e-3a47-4b1f-aeed-697553180e19" width="500">
    <img src="https://github.com/user-attachments/assets/9e5c8c3d-83e7-4efd-8e06-4d0c3f79e869" width="450">
</p>

Para criar um sinal, basta usar a sintaxe `signal {my_signal}`, onde `my_signal` é qualquer nome que você queira dar para o teu sinal. Note que, automaticamente, ele já aparece na aba Node à direita da tela. Dentro do `_physics_process` o programa faz as verificações de contagem e velocidade que mencionamos anteriormente. Caso tudo se verifique, o comando `ganhou.emit()` faz com que o sinal seja emitido. Com isso, toda a lógica está pronta e o restante do procedimento ´idêntico ao que vimos em *Signals 1*. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/de9b2788-00d7-45bb-b045-32fcd494fffb" width="700">
</p>


