# Using NavigationPathQueryObjects

Vimos no [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationPaths) que é possível mandar o servidor de navegação gerar caminhos sem passar por nenhum node intermediário. No caso, vimos como utilizar a função `NavigationServer2D.map_get_path` para tal propósito. A verdade é que essa função é um método simplificado do que se pode fazer. Neste tutorial, iremos ver todos os parâmetros utilizados para a geração de caminhos. 

## NavigationPathQueryParameters2D

`NavigationPathQueryParameters2D` é um objeto feito especificamente para armazenar e customizar parâmetros que serão enviados para a query no servidor de navegação. Você pode criar uma instância deste objeto com um comando como `var query_parameters = NavigationPathQueryParameters2D.new()`.

## NavigationPathQueryResult2D

`NavigationPathQueryResult2D` é um objeto feito especificamente para receber as saídas da query de uma requisição de caminho no servidor de navegação. Você pode criar uma instância deste objeto com um comando como `var query_result = NavigationPathQueryResult2D.new()`.
