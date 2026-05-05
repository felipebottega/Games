# Using NavigationRegions

Vimos [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview) como funciona `NavigationRegion` na prática. Agora vamos ver alguns detalhes sobre este node que não foram mencionados antes.

## NavigationRegion e global_transform 

A `NavigationRegion` envia automaticamente as alterações de *global_transform* para a região no `NavigationServer`, o que as torna adequadas para plataformas móveis. Porém, vale notar que isso só leva em conta translação e rotação. Mudanças de escala não são consideradas quando se altera uma `NavigationRegion`.

## Criando NavigationRegion por código

No tutorial referenciado acima, mostramos como criar e manipular a `NavigationRegion` pelo editor. Para criar via código, usamos a sequência abaixo. 

```python
var new_region_rid = NavigationServer2D.region_create()
var default_map_rid = get_world_2d().get_navigation_map()
NavigationServer2D.region_set_map(new_region_rid, default_map_rid)
```

Note que estamos criando a `NavigationRegion` no mapa default. Se quisermor trocá-lo de mapa, isto é possível, mas ele deixará de fazer parte do mapa anterior.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationMaps">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20navigation%20meshes">Próximo ➡</a>
</p>
