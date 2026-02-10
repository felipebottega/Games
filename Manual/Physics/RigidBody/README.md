# RigidBody

`RigidBody2D` (`RigidBody3D`) são corpos que você não manipula diretamente, eles apenas respondem à engine física. Apesar disso, é possível aplicar forças sobre o corpo, e a engine física calcula como ele deve reagir. Vale ressaltar que você pode sim alterar a posição, velocidade, aceleração, etc., do corpo, mas ele pode reagir de maneiras imprevisíveis, uma vez que ele está tentando atender a física da engine e as alterações forçadas que você impôs sobre ele. Para evitar comportamentos imprevisíveis e bugs, prefira sempre aplicar forças sobre o corpo. Se você realmente quer manipular o objeto de maneira forçada, talvez o `RigidBody2D` não seja o objeto que você quer usar.

Se quiser ver sobre as propriedades do *Physics Material*, visite o tutorial de [introdução](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-material) à engine física.

## Propriedades

  - **Mass:** É a massa do corpo, em kg. Esas propriedade só tem utilidade em um contexto que exustam outros corpos com outras massas.
  - **Gravity Scale:** Múltiplo da gravidade da Terra sobre um corpo. Se for 2, por exemplo, é uma gravidade 2 vezes mais intensa que a do planeta Terra.
  - **Mass Distribution/Center of Mass Mode:** Define o método para determinar o centro de massa de um corpo. O default *Auto* significa que a engine irá calcular automaticamente a partir das shapes que compõe o corpo. Se você escolher *Custom*, você deve escolher a coordenada *x, y* onde é o centro de massa. Esas coordenada é a posição do centro de massa em relação à origem do corpo.
  - **Mass Distribution/Inertia:** Determina quanto de torque é necessário para girar o corpo. É como se fosse uma "massa", mas para rotação.
  - **Deactivation/Sleeping:** Quando um corpo está em repouso e não se move por um tempo, ele entra em estado de *sleep*. Quando um corpo está em modo *sleep*, suas forças não são calculadas pela engine, mas coisas como gravidade e colisões ainda são calculadas. O corpo só desperta quando certas forças forem aplicadas, seja por uma colisão ou por código. 
  - **Deactivation/Can Sleep:** Quando esta opção está habilitada (default), o corpo é capaz de entrar em modo *sleep*. Caso contrário, ele nunca entra neste estado.
  - **Deactivation/Lock Rotation:** Quando esta opção está habilitada, o corpo não é capaz de rotacionar. AS forças diferentes de rotação ainda se aplicam normalmente.
  - **Deactivation/Freeze:** É um estado mais extremo que o *sleep*, pois nem a gravidade nem colisões mais afetam o corpo. Ele é quase inteiramente ignorado pela engine física, basicamente virou um `StaticBody` e só funciona como obstáculo de colisão para outros corpos.

> PS: Se você for criar um `RigidBody` que estará sempre no modo *freeze*, prefira criar um `StaticBody`. É mais simples.

  - **Deactivation/Freeze Mode:** Um corpo pode entrar no modo *freeze* de duas maneiras diferentes. O primeiro é o modo *static*. Caso você precise mover o objeto neste modo, ele não vai colidir com os outros corpos enquanto se move. O segundo é o modo *kinematic*, cuja única diferença é que ele pode se colidir com outros corpos enquanto se move. É importante ressaltar que este movimento não é por aplicação de forças, mas sim algo forçado, pois o corpo não reage mais a forças.
