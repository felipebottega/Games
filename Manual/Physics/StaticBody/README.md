# StaticBody

`StaticBody2D` (`StaticBody3D`) é um corpo que não é movido pela engine física. Ele participa da detecção de colisões, mas não se move em resposta a elas. São frequentemente usados ​​para objetos que fazem parte do ambiente ou que não precisam ter nenhum comportamento dinâmico.

## Propriedades

Como já vimos [antes](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-material), o `StaticBody2D` pode ter seu tipo de material alterado no *Physics material*. Além disso, ele também possui algumas propriedades editáveis no *Inspector*.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/27d083e7-5c57-4c84-bfca-272c6cc7582e" />
</p>

  - **Constant Linear Velocity:** Aplica uma velocidade direcional no corpo que está sobre o objeto.
  - **Constant Angular velocity:** Aplica um velocidade angular no corpo que está sobre o objeto.
