# Custom performance monitors

No tutorial sobre o [painel do debugger](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Debugger%20panel#monitors), fomos introduzidos à aba de monitoramento (*Monitors*). Esta aba possui diversos dados para serem monitorados. Além destes dados, é possível customizar outros dados que você queira monitorar. Vamos mostrar como se faz através de um exemplo.

## Customizando um dado para aparecer no monitoramento

Criamos um projeto simples de um chão estático (`StaticBody2D`) e diversas esferas (`RigiBody2D`) que ficam caindo continuamente do céu. Assim que elas saem da tela, são removidas da cena. Nosso objetivo é monitorar o número de bolas que existem a cada instante.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/5d24d797-431a-48e5-a8cf-70223669036e" />
</p>

A lógica do corpo é simples. O importante é que notar que ele é adicionado ao grupo *ball* assim que é criado.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/ff1d73e5-fc86-4508-8d9a-8ea1d0a5465b" />
</p>

No script da cena principal é onde as coisas mais importantes acontecem. Logo no `_ready` é feita a criação do monitoramento. O comando `Performance.add_custom_monitor("game/ball_count", get_ball_count)` diz para a engine criar o campo de monitoramento "game/ball_count", e este monitoramento usará a saída da função `get_ball_count` para colocar no gráfico. O resto do código é apenas a lógica de criação de instâncias. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/4f8ece0b-41ff-4ce1-996d-cd63eb8acd47" />
</p>

O resultado está mostrado abaixo. É bem simples!

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/2f431eca-0427-405c-bb6f-d366f60ab4e6" />
</p>

> PS: O monitoramento é atualizado uma vez por segundo. Você até pode criar os valores uma vez por frame, mas será mais do que o necessário de fato.
