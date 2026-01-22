# CPU optimization

Este tutorial é apenas uma pequena lista de ferramentas e dicas para monitoramente e otimização dos processos do lado da CPU.

## Profiler 

A primeira ferramenta fundamental para qualquer desenvolvedor que queira melhorar a performance do seu projeto é um *profiler*. Isso não se limita a jogos, em qualquer tipo de desenvolvimento de software isso é importante. Um profiler é um programa que monitora o seu programa enquanto ele está rodando. Mais especificamente, ele monitora o tempo que cada subrotina leva para ser executada. A Godot tem o seu próprio profiler, ele se encontra no painel de edição abaixo, em *Debbuger → Profiler*.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/9056416e-30c5-4add-83e2-a69e1e97fd62" />
</p>

## Árvore de cena

Nodes são muito poderosos no Godot, mas cada um tem um custo de performance. Funções como `_process` e `_physics_process` percorrem toda a árvore de cena, e isso pode virar um gargalo quando há muitos nodes. Normalmente é mais eficiente ter menos nodes com mais responsabilidade cada um. 

Em alguns casos, remover um node da árvore de cena traz mais ganho de performance do que apenas escondê-lo ou pausá-lo, já que nodes fora da árvore não são processados e podem ser removidos e recolocados depois sem serem destruídos. Um detalhe importante é que não é necessário deletar um node para parar seu processamento: ele pode ser removido da SceneTree com `remove_child`, mantendo a referência, e adicionado novamente depois com `add_child`.

Para cenários mais extremos, é possível até evitar a SceneTree e usar diretamente as Server APIs para obter melhor desempenho.

## Física

A física pode virar um gargalo em cenas complexas com muitos objetos. Dá para melhorar a performance usando shapes de colisões mais simples, removendo ou reutilizando objetos físicos fora da área ativa e, em alguns casos, reduzindo a taxa de atualização da física. Diminuir o physics tick rate reduz o uso de CPU, mas pode causar *jitter* e aumentar o input lag, então o default costuma ser o ideal. 

> PS: *Jitter* é quando o movimento do jogo parece tremido, mesmo sem queda de FPS. Normalmente acontece quando a taxa de atualização da física não coincide com a taxa de frames renderizados.
