# RigidBody

`RigidBody2D` (`RigidBody3D`) são corpos que você não manipula diretamente, eles apenas respondem à engine física. Apesar disso, é possível aplicar forças sobre o corpo, e a engine física calcula como ele deve reagir. Vale ressaltar que você pode sim alterar a posição, velocidade, aceleração, etc., do corpo, mas ele pode reagir de maneiras imprevisíveis, uma vez que ele está tentando atender a física da engine e as alterações forçadas que você impôs sobre ele. Para evitar comportamentos imprevisíveis e bugs, prefira sempre aplicar forças sobre o corpo. Se você realmente quer manipular o objeto de maneira forçada, talvez o `RigidBody2D` não seja o objeto que você quer usar.

Se quiser ver sobre as propriedades do *Physics Material*, visite o tutorial de [introdução](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-material) à engine física.

## Propriedades

  - **Mass:** É a massa do corpo, em kg. Esas propriedade só tem utilidade em um contexto que exustam outros corpos com outras massas.
  - **Gravity Scale:** Múltiplo da gravidade da Terra sobre um corpo. Se for 2, por exemplo, é uma gravidade 2 vezes mais intensa que a do planeta Terra.
  - **Mass Distribution/Center of Mass Mode:** Define o método para determinar o centro de massa de um corpo. O default *Auto* significa que a engine irá calcular automaticamente a partir das shapes que compõe o corpo. Se você escolher *Custom*, você deve escolher a coordenada *x, y* onde é o centro de massa. Esas coordenada é a posição do centro de massa em relação à origem do corpo.
  - **Mass Distribution/Inertia:** Determina quanto de torque é necessário para girar o corpo. É como se fosse uma "massa", mas para rotação.
  - **Deactivation/Sleeping:** 
