# Using NavigationMaps

Um `NavigationMap` é um mundo de navegação abstrato no `NavigationServer` (2D ou 3D), identificado por um RID do `NavigationServer`. Um `NavigationMap` pode conter e conectar um número quase infinito de regiões de navegação com áreas transitáveis. Vale lembrar que `NavigationServer` e `NavigationMap` são objetos internos da engine, não são nodes.

Diferentes `NavigationMap` são completamente isolados uns dos outros, mas as regiões de navegação e os *agentes de evasão* (veremos sobre isso mais adiante) podem alternar entre eles. Ressaltamos que eles só podem fazer parte de um `NavigationMap`. Então ao trocar de mapa, eles deixam de fazer parte do antigo mapa.

## Default navigation maps

Por default, já existe um `NavigationMap` onde estão as regiões e agentes criados. Você pode obter o RID deste mapa default com o comando `get_world_2d().get_navigation_map()`. Caso queira criar outro `NavigationMap`, utilize o comando `var new_navigation_map: RID = NavigationServer2D.map_create()` para criar o novo mapa e depois `NavigationServer2D.map_set_active(new_navigation_map, true)` para ativar este mapa. 

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationServer">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationRegions">Próximo ➡</a>
</p>
