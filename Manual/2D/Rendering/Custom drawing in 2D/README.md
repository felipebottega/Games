# Custom drawing in 2D

As ferramentas de desenho customizado em Godot são bastante genéricas. Alguns exemplos de aplicação são: 

- Desenhar formas ou lógica que os nodes existentes não conseguem fazer, como um polígono animado especial.
- Desenhar um grande número de objetos simples, como uma grid ou um tabuleiro para um jogo 2D. O desenho personalizado evita a sobrecarga de usar um grande número de nodes, possivelmente reduzindo o uso de memória e melhorando o desempenho.
- Criar um controle de interface de usuário (UI) personalizado. Há muitos controles disponíveis, mas quando você tem necessidades incomuns, provavelmente precisará de um controle personalizado.

Os desenhos ficam no espaço de coordenadas do *Canvas Item* (https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Viewport%20and%20canvas%20transforms#atributo-transform), ou seja, as coordenadas do node pai. É importante ter isso em mente para não achar que está usando coordenadas da tela, pois algumas vezes pode não ser este o caso.

## _draw vs _queue_draw
