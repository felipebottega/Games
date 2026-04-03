# CPU optimization

Este tutorial é apenas uma pequena lista de ferramentas e dicas para monitoramento e otimização dos processos do lado da CPU.

## Profiler 

A primeira ferramenta fundamental para qualquer desenvolvedor que queira melhorar a performance do seu projeto é um profiler. Isso não se limita a jogos, em qualquer tipo de desenvolvimento de software isso é importante. "Profiler" é um programa que monitora o seu programa enquanto ele está rodando. Mais especificamente, ele monitora o tempo que cada subrotina leva para ser executada. A Godot tem o seu próprio profiler, ele se encontra no painel de edição, em *Debbuger → Profiler*.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/9056416e-30c5-4add-83e2-a69e1e97fd62" />
</p>

## Árvore de cena

Nodes são muito poderosos, mas cada um tem um custo de performance. Funções como `_process` e `_physics_process` percorrem toda a árvore de cena (SceneTree), e isso pode virar um gargalo quando há muitos nodes. Normalmente é mais eficiente ter menos nodes com mais responsabilidade cada um. 

Em alguns casos, remover um node da árvore de cena traz mais ganho de performance do que apenas escondê-lo ou pausá-lo, já que nodes fora da árvore não são processados e podem ser removidos e recolocados de volta depois. Um detalhe importante é que não é necessário deletar um node (`free`/`queue_free`) para parar seu processamento, ele pode ser removido com `remove_child` e adicionado novamente depois com `add_child`. Na Godot, `remove_child` apenas tira o node da cena sem destruí-lo, enquanto `free`/`queue_free` remove e apaga o node da memória definitivamente.

Para cenários mais extremos, é possível até evitar a árvore de cena e usar diretamente as Server APIs para obter melhor desempenho.

> PS: A diferença entre `free` e `queue_free` é que o primeiro deleta o node imediatamente, enquanto que o segundo deleta no frame seguinte. Em geral é mais seguro usar o `queue_free`.

## Física

A física pode virar um gargalo em cenas complexas com muitos objetos. É possível melhorar a performance usando shapes de colisões mais simples, removendo ou reutilizando objetos físicos fora da área ativa e, em alguns casos, reduzindo a taxa de atualização da física. Diminuir o physics tick rate reduz o uso de CPU, mas pode causar *jitter* e aumentar o input lag, então o default costuma ser o ideal. 

> PS: *Jitter* é quando o movimento do jogo parece tremido, mesmo sem queda de FPS. Normalmente acontece quando a taxa de atualização da física não coincide com a taxa de frames renderizados.
