# Ray-casting

*Ray-casting* nada mais é que um "raio" saindo de um ponto até outro. O objetivo deste raio é detectar colisões no caminho. Pense nele como um sensor de colisões da engine. O uso dele não é aplicável direto no jogo, ele apenas dispara o raio (invisível durante o jogo) e verifica colisões. Você pode usar isso para criar mecânicas como detecção de obstáculos, mira, seleção de objetos com o mouse, visibilidade para IA, etc.

## Criando um ray-casting

O node deste raio se chama `RayCast2D`. Basta adicioná-lo na sua cena e posicioná-lo onde quiser no espaço 2D. Feito isso, vá no *Inspector* e escolha o ponto final do raio através do *Target Position*. Este ponto não é global, ele é relativo à origem do `RayCast2D`.

<p align="center">
  <img width="180" src="https://github.com/user-attachments/assets/fdf4c8de-ee7f-4b71-ae27-73ce1a985b2d" />
  <img width="250" src="https://github.com/user-attachments/assets/d3c8b7bb-2085-4460-868b-42f6dddf75c6" />
  <img width="500" src="https://github.com/user-attachments/assets/46b18d12-f2de-4fb5-bf98-b75108ccecd8" />
</p>

