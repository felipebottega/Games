# Area2D

O node `Area2D` fornece detecção e influência. Ele pode detectar quando objetos passam na área e pode emitir sinais quando corpos entram ou saem. O `Area2D` também pode ser usado para sobrescrever propriedades físicas (como gravidade) em uma área definida.

## Propriedades

  - **Monitoring:** Se esta propriedade estiver habilitada, a área é capaz de detectar corpos ou outros `Areas2D` que estiverem entrando ou saindo da região do node.
  - **Monitorable:** Se esta propriedade estiver habilitada, outros `Area2D` podem detectar este node.
  - **Priority:** A prioridade deste node para ser detectado por outros `Area2D`. Quanto maior a prioridade, mais é certo deste node ser detectado. De maneira geral, você pode pensar assim: *priority = 0 → área comum, priority > 0 → área mais importante, priority < 0 → área menos importante*.

  - **

