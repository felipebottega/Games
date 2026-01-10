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

### 
