# Signals 3

Nem todos os sinais disponibilizados pela Godot servem a todos os propósitos. Há momentos em que você vai querer um sinal que não está no conjunto de sinais deles. Para estes casos, é possível customizar seus próprios sinais. Neste projeto nós iremos fazer apenas um sinal customizado, que determina quando o jogo acabou e dispara uma mensagem de vitória na tela.

Começamos criando uma nova cena, que é um node raíz do tipo `Area2D` com um shape de colisão. É a mesma receita usada para a área de impulso, mas em vez de aplicar impulso, estaremos contando o número de bolinhas na região e suas velocidades. A condição é que se todas as 36 bolinhas estiverem na região e a soma das suas velocidades horizontais forem praticamente nulas, então o jogador ganhou o jogo.

<p align="center">
    <img src="https://github.com/user-attachments/assets/53525b9e-3a47-4b1f-aeed-697553180e19" width="700">
    <img src="https://github.com/user-attachments/assets/9e5c8c3d-83e7-4efd-8e06-4d0c3f79e869" width="800">
</p>

## Criando o seu próprio sinal

Para criar um sinal, basta usar a sintaxe `signal {my_signal}`, onde `my_signal` é qualquer nome que você queira dar para o teu sinal. Note que, automaticamente, ele já aparece na aba Node à direita da tela. 

Dentro do `_physics_process` o programa faz as verificações de contagem e velocidade que mencionamos anteriormente. Caso tudo se verifique, o comando `ganhou.emit()` faz com que o sinal seja emitido. Com isso, toda a lógica está pronta e o restante do procedimento é idêntico ao que vimos em *Signals 1*. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/de9b2788-00d7-45bb-b045-32fcd494fffb" width="1100">
</p>

> PS: É necessário subtrair 2 da contagem pois ele também está contando os dois corpos estáticos côncavos. Por esse mesmo motivo é necessário usar o `if body is RigidBody2D` na hora de calcular a velocidade, pois os corpos estáticos estão na lista e não possuem velocidade. Isso daria num erro ao executar.

O `Sprite2D` com a mensagem de vitória foi adicionado à cena principal mas com o parâmetro *Visible* desmarcado (está no *Inspector*, à direita na figura). Assim, o sprite começa invisível e apenas se torna visível quando o sinal do `ganhou` é emitido. Note que no script da cena principal está a função que é ativada com o sinal. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/2a0131ee-d9ac-49bb-9cbe-01912afee9fd" width="1100">
</p>

## Música de background

Para deixar o jogo com cara de finalizado, ele ganhou uma música de background. Adicionamos o node `AudioStreamPlayer` à cena principal e colocamos um mp3 na pasta do projeto, chamado *John Cage in a landscape.mp3*. Você deve arrastar o ícone do arquivo de *FileSystem* para *Stream* na aba *Inspector*. Depois disso, clique na setinha ao lado e marque a opção *Make Unique*. Eu ainda não sei o motivo, mas isso é necessário para marcar a opção *Loop*, que faz a música se repetir quando acabar. Por fim, marque a opção *Autoplay*, que faz a música começar a tocar assim que a cena é carregada. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/6b6cad30-7422-495e-acb7-c2392cd9e777" width="250">
    <img src="https://github.com/user-attachments/assets/6d371c07-841d-46dc-9590-d1890911dd6c" width="270">
</p>

Feito isso, o jogo está pronto!

> 🟦 **REVISÃO POSTERIOR:** Isso do *Make Unique* acontece porque a música é um recurso. Alterar a propriedade de loop afeta o recurso, o que vai afetar todas as instâncias deste recurso pelo projeto. Então a única maneira de ativar o loop é duplicando este recurso localmente com o *Make Unique*.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Using%20signals/Signals%202">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Coding%20the%20player/Animation%201">Próximo ➡</a>
</p>
