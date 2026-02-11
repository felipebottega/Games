# Using NavigationPaths

No [primeiro tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview) de navegação, vimos como criar um agente que calcula o caminho até um target, usando o node `NavigationAgent2D`. Como foi discutido [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationServer), tudo é computado em um servidor interno da Godot. O node `NavigationAgent2D` é uma interface para interagir com o servidor e extrair os caminhos, mas é possível falar com o servidor diretamente. Desta maneira, podemos obter caminhos sem precisar de um node intermediário. 

## map_get_path

O comando `NavigationServer2D.map_get_path(map, from, to, optimize, navigation_layers)` nos permite extrair um caminho diretamente do servidor, sem nenhum node intermediário no processo. Abaixo segue a descrição dos parâmetros de entrada da função.

- **map:** É o RID do mapa de navegação. O comando `get_world_2d().get_navigation_map()` permite extrair variável caso esteja utilizando o mapa default.
- **from:** Posição inicial do caminho (onde está o NPC dos exemplos anteriores).
- **to:** Posição final do caminho (onde está o target dos exemplos anteriores).
- **optimize:** Variável booleana. Se for *true*, usa um algoritmo otimizado de afunilamento ao gerar o caminho. Este é o default do `NavigationAgent2D`. Se for *false*, o caminho sempre passará pelo meio das arestas dos polígonos, sem tentar otimizar nada.
- **navigation_layers:** É uma bitmask para as regiões de navegação que podem atuar no caminho. Veremos mais sobre isso no próximo tutorial.

> PS: O comando para espaços 3D é totalmente análogo, basta trocar "2D" por "3D" no nome da função.

## PackedVector2Array 

Como é de se esperar, a saída da função `NavigationServer2D` é um array, mas não é um array qualquer, é um `PackedVector2Array`. Em Godot, `PackedVector2Array` é um array otimizado para armazenar muitos valores do tipo `Vector2`. É imutável em tipo, só aceita `Vector2`.
