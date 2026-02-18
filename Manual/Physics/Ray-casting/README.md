# Ray-casting

*Ray-casting* nada mais é que um "raio" saindo de um ponto até outro. O objetivo deste raio é detectar colisões no caminho. Pense nele como um sensor de colisões da engine. O uso dele não é aplicável direto no jogo, ele apenas dispara o raio (invisível durante o jogo) e verifica colisões. Você pode usar isso para criar mecânicas como detecção de obstáculos, mira, seleção de objetos com o mouse, visibilidade para IA, etc.

Este raio de fato funciona como um raio físico no sentido da detecção, isto é, ele vai detectar a primeira colisão e parar ali. Por mais que existam outros objetos atrás do primeiro objeto detectado, é como se este objeto estivesse bloqueando o raio.

> PS: Caos vá usar o `RayCast2D` em loop, use ele dentro do `_physics_process`.

## Criando um ray-casting

O node deste raio se chama `RayCast2D` (`RayCast3D`). Basta adicioná-lo na sua cena e posicioná-lo onde quiser no espaço 2D. Feito isso, vá no *Inspector* e escolha o ponto final do raio através do *Target Position*. Este ponto não é global, ele é relativo à origem do `RayCast2D`.

<p align="center">
  <img width="180" src="https://github.com/user-attachments/assets/fdf4c8de-ee7f-4b71-ae27-73ce1a985b2d" />
  <img width="250" src="https://github.com/user-attachments/assets/d3c8b7bb-2085-4460-868b-42f6dddf75c6" />
  <img width="500" src="https://github.com/user-attachments/assets/46b18d12-f2de-4fb5-bf98-b75108ccecd8" />
</p>

Apenas com isso o seu raio de detecção já está pronto para uso. Para obter as respostas de detecção, é necessário acessar alguns métodos do `RayCast2D`. Veremos isso logo abaixo.

## Propriedades

- **Enabled:** Se estiver habilitada, as detecções do raio são levadas em conta pela engine.
- **Exclude Parent:** Se estiver habilitada, o pai do node `RayCast2D` não é levado em conta nas detecções.
- **Target Position:** Ponto final do raio.
- **Collision Mask:** Máscara de colisão do raio. É análoga a todas as masks que já vimos anteriormente.
- **Hit From Inside:** O comportamento padrão do raio é ignorar colisões quando o ponto de início já está dentro de um objeto de colisão. Se esta propriedade estiver habilitada, ele deixa de ignorar isso.
- **Collide With/Areas:** Se estiver habilitada, vai reportar colisões com nodes `Area2D`.
- **Collide With/Bodies:** Se estiver habilitada, vai reportar colisões com nodes `CharacterBody2D`, `RigidBody2D` e `StaticBody2D`.

## Métodos

- **get_collision_point:** Retorna o ponto onde ocorreu a colisão entre o raio e o corpo. É esperado que este ponto sempre esteja na borda do corpo, onde é o primeiro contato entre o raio e o corpo. Essa medição pode ficar levemente incorreta se o raio estiver muito rápido.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/44ff44e4-5523-40d0-93d2-e3b0f021f2df" />
</p>

- **get_collider:** Retorna o (primeiro) objeto que colidiu com o raio.
- **is_colliding:** Retorna *true* se ocorreu alguma colisão, caso contrário retorna *false*.
- **force_raycast_update:** Por default, o `RayCast2D` reporta a colisão no frame físico seguinte. Caso precise desta notificação no mesmo frame em que ocorreu a colisão, use este método.

Existem outros métodos úteis, como exclusão de certos nodes na detecção, extrair RID do corpo que colidiu, extrair vetor normal, etc. Recomendo ver a [documentação oficial](https://docs.godotengine.org/en/stable/classes/class_raycast2d.html#class-raycast2d) caso precise de alguma outra coisa.
