# Using NavigationPathQueryObjects

Vimos no [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationPaths) que é possível mandar o servidor de navegação gerar caminhos sem passar por nenhum node intermediário. No caso, vimos como utilizar a função `NavigationServer2D.map_get_path` para tal propósito. A verdade é que essa função é um método simplificado do que se pode fazer. Neste tutorial, iremos ver todos os parâmetros utilizados para a geração de caminhos. 

## NavigationPathQueryParameters2D

`NavigationPathQueryParameters2D` é um objeto feito especificamente para armazenar e customizar parâmetros que serão enviados para a query no servidor de navegação. Você pode criar uma instância deste objeto com um comando como `var query_parameters = NavigationPathQueryParameters2D.new()`.

## NavigationPathQueryResult2D

`NavigationPathQueryResult2D` é um objeto feito especificamente para receber as saídas da query de uma requisição de caminho no servidor de navegação. Você pode criar uma instância deste objeto com um comando como `var query_result = NavigationPathQueryResult2D.new()`.

## Exemplo prático do NavigationPathQuery

Os dois objetos acima sempre são usados em parceria: um define os inputs e o outro recebe os outputs. Em vez de simplesmente descrever item por item, vamos mostrar na prática como estes objetos são utilizados.

### NavigationRegion

Começamos criando um node raíz do tipo `Node2D` contendo um node `NavigationRegion2D` que chamaremos de *RegionA*. Depois vá em *Inspector → Navigation Polygon → New Navigation Polygon*. Agora desenhe a região de navegação na tela, mas faremos de modo que ela não ocupe muito espaço, pois iremos incluir mais coisas na tela depois. Este procedimento todo foi visto em detalhe [no primeiro tutorial de navegação](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview#navigationregion2d).

Em relação aos parâmetros, vamos apenas alterar o raio do agente, assim haverá mais espaço para o agente navegar. Não se esqueça que após alterar algum parâmetro da região é necessário aplicar o *Bake NavigationPolygon*.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/f16ff5b0-f0ff-4d26-bf97-1ae36165d081" />
</p>

### NPC 

Assim como foi anteriormente, o NPC (agente que vai requisitar e percorrer o caminho) será apenas um `CharacterBody2D` com o sprite do logo da Godot. A diferença é que agora não usamos o `NavigationAgent2D`, pois todo caminho será requisitado diretamente do servidor. Desta vez o target será um sprite estático, para simplificar.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/f19253c3-3872-45d4-975a-d5f01d8fadff" />
</p>

> PS: É recomendado usar *Motion Mode = Floating* no NPC (como mostrado na imagem), assim ele desliza mais facilmente pelos obstáculos.

### Executando queries

Toda a parte de código ficará em um script único no NPC. A primeira coisa que queremos é a função geral de executar as queries. Ela recebe o objeto de parâmetros e de outputs e retorna um `PackedVector2Array`. Internamente, ela consulta o RID do mapa de navegação e verifica se já passou da iteração zero. Após o mapa ser carregado pela primeira vez, ele sei da iteração zero e vai para 1. Depois disso vai incrementando a cada alteração. Depois disso ele envia os objetos para o servidor e armazena os resultados no objeto `NavigationPathQueryResult2D`. Esta função é bem genérica e direta. 

<p align="center">
  <img width="440" src="https://github.com/user-attachments/assets/549af838-8558-4f65-950d-b44b74e4e34e" />
  <img width="560" src="https://github.com/user-attachments/assets/d02ff36b-23cd-48f6-b196-469bec380ccc" />
</p>

A versão do código acima já é funcional, o NPC irá atrás do target seguindo um certo caminho que o servidor calculou. 

### Parâmetros para o caminho

Ao executar a requisição acima, não customizamos nenhum parâmetro, a única coisa que passamos foram os parâmetros `start_position` e `target_position`, que é o mínimo necessário para a coisa funcionar. Então o servidor entregou um caminho com os parâmetros default. 

Vamos acrescentar um parâmetro por vez, explicando como funciona e como inserir no código.

  - **pathfinding_algorithm:** Há apenas um algoritmo para calcular o caminho, que é o *Astar* (A*). Apesar de não ter o que modificar, incluímos este parâmetro no tutorial pois pode ser que outros entrem futuramente. Na Godot este parâmetro é dado pela constante `NavigationPathQueryParameters2D.PATHFINDING_ALGORITHM_ASTAR`.
  - **path_postprocessing:** Vimos um pouco deste parâmetro [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationPaths#map_get_path). Ele aplica um pós-processamento sobre o caminho calculado. Pode ser um algoritmo otimizado de afunilamento (default), um algoritmo que faz o caminho sempre passar pelo meio das arestas dos polígonos, ou nenhum pós-processamento. As constantes associadas a estas escolhas são `NavigationPathQueryParameters2D.PATH_POSTPROCESSING_CORRIDORFUNNEL`, `NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED` e `NavigationPathQueryParameters2D.PATH_POSTPROCESSING_NONE`.
  - **simplify_path:** Este parâmetro realiza cálculos adicionais para tentar simplificar o caminho, isto é, deixá-lo com menos pontos. O exemplo abaixo mostra duas versões de um mesmo caminho. Na esquerda temos o default, sem simplificação, e na direita o caminho com simplificação.

<p align="center">
  <img width="310" src="https://github.com/user-attachments/assets/8aecd11f-e444-4055-818c-685b4d627492" />
  <img width="310" src="https://github.com/user-attachments/assets/7b06a599-85f4-4495-8c14-54df82d35801" />
</p>

  - **simplify_epsilon:** Caso `simplify_path` seja *true*, este segundo parâmetro controla o nível da simplificação. Quanto maior, mais intensa é a simplificação.
  - 
