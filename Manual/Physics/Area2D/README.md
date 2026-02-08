# Area2D

O node `Area2D` fornece detecção e influência. Ele pode detectar quando objetos passam na área e pode emitir sinais quando corpos entram ou saem. O `Area2D` também pode ser usado para sobrescrever propriedades físicas (como gravidade) em uma área definida. 

## Propriedades

  - **Monitoring:** Se esta propriedade estiver habilitada, a área é capaz de detectar corpos ou outros `Areas2D` que estiverem entrando ou saindo da região do node.
  - **Monitorable:** Se esta propriedade estiver habilitada, outros `Area2D` podem detectar este node.
  - **Priority:** A prioridade deste node para ser detectado por outros `Area2D`. Quanto maior a prioridade, mais é certo deste node ser detectado. De maneira geral, você pode pensar assim: *priority = 0 → área comum, priority > 0 → área mais importante, priority < 0 → área menos importante*.
  - **Gravity/Space Override:** Esta propriedade por default vem desativada. Caso você a ative, alguns parâmetros de gravidade vão aparecer no *Inspector*. Estes parâmetros definem os valores da nova gravidade associada à área do node. Se um corpo passar pela área, ele será afetado por esta nova gravidade. Vale notar que a gravidade não simplesmente sobrescreve a gravidade do jogo, você pode adicionar, pode ou não considerar outras áreas que estejam se sobrepondo na região (levando em conta a prioridade). Tudo depende do modo de sobrescrita que você vai utilizar. Recomendo ler as opções (que são descritas no próprio *Inspector*) e explorar.
  - **Linear Dump/Space Override:** Análogo à gravidade, mas para o dumping/amortecimento linear.
  - **Angular Dump/Space Override:** Análogo à gravidade, mas para o dumping/amortecimento angular.
  - **Audio Bus:** Sobrepõe o canal de aúdio quando entra nesta área. Bom para criar som de ambientação.

## Métodos

Abaixo, seguem alguns métodos relevantes do `Area2D`.

  - **get_overlapping_bodies:** Retorna uma lista com todos os corpos físicos e TileMaps que estejam interceptando a área no momento em que a função é executada.
  - **get_overlapping_areas:** Análogo an anterior, mas retorna apenas a lista de outros `Area2D` que estejam interceptando a área no momento em que a função é executada.

## Sinais

  - **body_entered:** Emitido quando um corpo físico ou TileMap entra na área. TileMaps são detectados se o seu TileSet tiver shapes de colisão configuradas.
  - **body_exited:** Emitido quando o corpo ou TileMap sai na área.
  - **area_entered, area_exited:** Análogo aos de cima, mas para `Area2D`.

> PS: Para os sinais acima funcionarem, é necessário que a propriedade *Monitoring* esteja habilitada. 
