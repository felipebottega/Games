# Using NavigationServer

Neste tutorial, vamos nos concentrar no `NavigationServer2D`, pois as funcionalidades do `NavigationServer3D` são praticamente equivalentes, apenas com as devidas adaptações para o número de dimensões. 

`NavigationServer2D` é o sistema de navegação de baixo nível da Godot. Ele funciona separado da árvore de nós (Scene Tree) e é responsável por construir mapas de navegação, gerenciar regiões de navegação, calcular caminhos, controlar agentes de navegação, resolver colisões dinâmicas entre agentes (via RVO), entre outros. Os nodes que você usa na cena (`NavigationRegion2D`, `NavigationAgent2D`, etc.) são apenas interfaces, pois o trabalho real é feito dentro do servidor. 

## RIDs

Sempre que um node de navegação é criado, o `NavigationServer2D` cria um objeto interno correspondente. A ligação é feita através de um RID (*Resource ID*), que é um número único que identifica o objeto dentro do servidor. Você pode interpretar o RID como um "ID do banco de dados" dos objetos dentro do servidor (backend) e o node como o frontend.

Nodes possuem métodos como `get_rid()` para expor o RID do objeto. Por exemplo, se você tiver um node `NavigationRegion2D` chamado *navregion* na sua cena, você pode usar o método `$navregion.get_rid()` para obter o RID deste objeto no `NavigationServer2D`.

