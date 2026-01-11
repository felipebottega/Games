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

  - **simplify_epsilon:** Caso `simplify_path` seja *true*, este segundo parâmetro controla o nível da simplificação. Quanto maior, mais intensa é a simplificação. Abaixo mostramos o que acontece quando a simplificação está ativada, com `simplify_epsilon` igual a $0$, $1$ e $40$, respectivamente (esquerda para a direita).

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/ab6bb0b2-88f8-4cb7-b5e4-2b3ba12f7333" />
  <img width="305" src="https://github.com/user-attachments/assets/54d6673c-7bf9-4c6d-bcd0-4c8fab201c10" />
  <img width="310" src="https://github.com/user-attachments/assets/e5c7567e-5a72-48e3-a106-3bb33d6a1145" />
</p>

  - **path_return_max_length:** A engine calcula o caminho e retorna só um pedaço dele, com o comprimento estabelecido por este parâmetro, em pixels. O valor $0$ (default) faz o caminho completo ser retornado.
  - **path_return_max_radius:** A engine calcula o caminho e retorna só um pedaço dele, dentro do raio (ao redor do início do caminho) estabelecido este parâmetro, em pixels. O valor $0$ (default) faz o caminho completo ser retornado.
  - **path_search_max_distance:** Distância máxima, em pixels, que a engine usa para determinar até qual polígono o caminho será calculado. Nos dois parâmetros anteriores, o caminho completo era calculado mas apenas um pedaço dele era retornado. Com este parâmetro a engine pode calcular caminhos efetivamente menores. O valor $0$ (default) faz o caminho completo ser retornado.
  - **path_search_max_polygons:** Número máximo de polígonos permitidos para serem usados no cálculo do caminho. Assim como `path_search_max_distance`, este parâmetro pode calcular caminhos efetivamente menores. Esta variável deve ser um número inteiro. O valor $0$ (default) faz o caminho completo ser retornado. 
  - **navigation_layers:** É um valor inteiro usado como bitmask que diz ao servidor quais camadas (layers) de navegação devem ser consideradas ao gerar um caminho. Por exemplo, o valor $5 = 101$ significa que é para considerar as camadas 1 e 3 e desconsiderar a camada 2. No *Inspector*, a propriedade *Navigation Layers* mostra em quais camadas o `NavigationRegion2D` pertence. 

<p align="center">
  <img width="250" height="464" alt="image" src="https://github.com/user-attachments/assets/7323aa1b-072b-4582-b9f6-7527c10e0d49" />
</p>

Considere as duas regiões mostradas abaixo, onde a da esquerda está na região 1 e a da direita está na região 4.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/5c3d7c3e-7b36-420f-8115-dd368c6bab53" />
</p>

<p align="center">
  <img width="300" alt="image" src="https://github.com/user-attachments/assets/05ea9932-ece9-45fa-a81d-15ad041aaf43" />
  <img width="300" src="https://github.com/user-attachments/assets/b5b1fa31-6488-4588-aabb-f3e25dd9b53d" />
</p>

Ao fazer `navigation_layers` = 1, estamos dizendo ao servidor que queremos um caminho que considere apenas as regiões na camada 1. É exatamente isso o que ele fez.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/738e22e9-a763-4e91-a1d7-4e04ad7b6591" />
</p>

Ao fazer `navigation_layers` = 8 = 1000, estamos ativando apenas o quarto bit, ou seja, apenas a quarta camada de navegação será considerada. Daí temos o caminho abaixo.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/915eaccb-00a7-4caf-9b5b-ac30abe978c1" />
</p>

> PS: É importante saber que, internamente, a engine registra "101" como "0...0101", completando com zeros à esquerda de acordo com o número de camadas.

  - **included_regions:** Lista/array com todos os RIDs das regiões que devem ser incluídas nos cálculos de caminho. As regiões fora dessa lista são excluídas no cálculo automaticamente. Por default essa lista é vazia, e isso significa que todas as regiões são incluídas.
  - **excluded_regions:** Lista/array com todos os RIDs das regiões que devem ser excluídas nos cálculos de caminho. As regiões fora dessa lista são incluídas no cálculo automaticamente. Por default essa lista é vazia, e isso significa que nenhuma região é excluída. Se tiver um RID na `included_regions` e `excluded_regions`, ele é considerado excluído.
    
> PS: Usar `included_regions` e `excluded_regions` pode ser uma maneira mais prática que `navigation_layers` de considerar e descondiderar regiões. Vai depender de cada caso.

- **path_metadata_flags:** Conjunto de metadados que vem junto com o caminho. Você pode decidir receber apenas alguns metadados ou até nenhum. Esta parâmetro é controlado pelas opções descritas abaixo.
      - `PathMetadataFlags PATH_METADATA_INCLUDE_NONE` = 0: Não inclui nenhum metadado adicional sobre o caminho retornado.
      - `PathMetadataFlags PATH_METADATA_INCLUDE_TYPES` = 1: Inclui o tipo de navegação (região ou link) pela qual cada ponto do caminho passa.
      - `PathMetadataFlags PATH_METADATA_INCLUDE_RIDS` = 2: Inclui os RIDs das regiões e dos links pelos quais cada ponto do caminho passa.
      - `PathMetadataFlags PATH_METADATA_INCLUDE_OWNERS` = 4: Inclui os ObjectIDs dos objetos que gerenciam as regiões e os links pelos quais cada ponto do caminho passa.
      - `PathMetadataFlags PATH_METADATA_INCLUDE_ALL` = 7: Inclui todos os metadados disponíveis sobre o caminho retornado.

A parte inicial do código foi ampliada e ficou assim:

<p align="center">
  <img width="470" src="https://github.com/user-attachments/assets/900092e4-9bdf-49b6-bf5b-ea56b4ab9be9" />
  <img width="530" src="https://github.com/user-attachments/assets/dbf679ce-621b-4d96-9084-92a94c1ec81d" />
</p>
