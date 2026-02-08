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

