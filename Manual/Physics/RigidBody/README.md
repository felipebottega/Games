# RigidBody

`RigidBody2D` (`RigidBody3D`) são corpos que você não manipula diretamente, eles apenas respondem à engine física. É possível sim forçar valores na posição, velocidade, aceleração, etc. Porém, o corpo pode reagir de maneiras imprevisíveis, uma vez que ele está tentando atender a física da engine e as alterações forçadas que você impôs sobre ele. Para evitar comportamentos imprevisíveis e bugs, prefira sempre aplicar forças sobre o corpo. Se você realmente quer manipular o objeto de maneira forçada, talvez o `RigidBody2D` não seja o objeto que você quer usar.

Se quiser ver sobre as propriedades do *Physics Material*, visite o tutorial de [introdução](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-material) à engine física.

## Propriedades

- **Mass:** É a massa do corpo, em kg. Esas propriedade só tem utilidade em um contexto que existam outros corpos com outras massas.
- **Gravity Scale:** Múltiplo da gravidade default sobre um corpo. Se for igual a $2$, por exemplo, isso significa uma gravidade $2$ vezes mais intensa que o default. Esta gravidade default é de $980$ pixels por segundo, como mostra a figura abaixo.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/8ee22d58-481e-49ac-93eb-eff0f9694233" />
</p>

- **Mass Distribution/Center of Mass Mode:** Define o método para determinar o centro de massa de um corpo. O default *Auto* significa que a engine irá calcular automaticamente a partir dos shapes que compõe o corpo. Se você escolher *Custom*, você deve escolher as coordenadas *x, y* do centro de massa. Esas coordenada é a posição do centro de massa em relação à origem do corpo.
- **Mass Distribution/Inertia:** Determina quanto de torque é necessário para girar o corpo. É como se fosse uma "massa", mas para rotação.
- **Deactivation/Sleeping:** Quando um corpo está em repouso e não se move por um tempo, ele entra em estado de *sleep*. Quando um corpo está em modo *sleep*, suas forças não são calculadas pela engine, mas coisas como gravidade e colisões ainda são calculadas. O corpo só desperta quando certas forças forem aplicadas, seja por uma colisão ou por código. 
- **Deactivation/Can Sleep:** Quando esta opção está habilitada (default), o corpo é capaz de entrar em modo *sleep*. Caso contrário, ele nunca entra neste estado.
- **Deactivation/Lock Rotation:** Quando esta opção está habilitada, o corpo não é capaz de rotacionar. As forças diferentes de rotação ainda se aplicam normalmente.
- **Deactivation/Freeze:** É um estado mais extremo que o *sleep*, pois nem a gravidade nem colisões afetam o corpo. Ele é quase inteiramente ignorado pela engine física, basicamente virou um `StaticBody` e só funciona como obstáculo de colisão para outros corpos.
- **Deactivation/Freeze Mode:** Um corpo pode entrar no modo *freeze* de duas maneiras diferentes. O primeiro é o modo *static*. Caso você precise mover o objeto neste modo, ele não vai colidir com os outros corpos enquanto se move. O segundo é o modo *kinematic*, cuja única diferença é que ele pode se colidir com outros corpos enquanto se move. É importante ressaltar que este movimento não é por aplicação de forças, mas sim algo forçado, pois o corpo não reage mais a forças.

> PS: Se você for criar um `RigidBody` que estará sempre no modo *freeze*, prefira criar um `StaticBody`. É mais simples.

- **Solver/Custom Integrator:** Quando esta opção está ativada, a engine física para de calcular todo tipo de força que pode gerar movimentos no corpo (gravidade, damping, etc.). A única coisa que a engine ainda faz é calcular colisões, mas a própria força da colisão não gera mais movimento. Ao ativar esta opção, você está dizendo à engine que a partir de agora você mesmo vai dar conta dos cálculos de força. O único modo de fazer algo é através da função `_integrate_forces()` (veremos mais sobre ela adiante).
- **Solver/Continuous CD:** Esta propriedade se chama *Continuous Collision Detection*. Ela determina o método de detecção de colisão da engine. Por default vem desligada, isso significa que a detecção é simplesmente verificar se há sobreposição/penetração entre corpos e ajustar isso, uma vez por frame físico. O ponto fraco deste approach é que ele pode "não enxergar" colisões quando os objetos estão se movendo muito rapidamente. Os outros dois métodos de detecção de colisão são o *cast ray* e o *cast shape*. Ambos são capazes de prever quando um corpo vai colidir com outro, mesmo que os corpos estejam se movendo muito rápido. O método *cast ray* é mais pesado que o default mas é mais leve que o *cast shape*. Porém, o *cast shape* é o mais preciso de todos.
- **Solver/Contact Monitor:** Por default, nenhum `RigidBody` reporta informação de colisão, eles apenas reagem à ela. Caso você queira tabalhar com sinais de colisão, é necessário ativar essa propriedade. Ao ativar, a propriedade *Max Contacts Reported* vai aparecer logo abaixo. Essa propriedade representa o número máximo de colisões reportadas por este corpo a cada frame físico.

> PS: A primeira vez que vimos a propriedade de *Contact Monitor* foi no nosso [primeiro tutorial de animação ](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Coding%20the%20player/Animation%201#tomando-dano). Naquele tempo eu fazia o personagem do jogo usando `RigidBody2D`.

- **Linear/Velocity:** Define a velocidade linear do corpo. Como já foi mencionado, o indicado é mover corpos rígidos através da aplicação de forças. Use esta propriedade apenas quando realmente for necessário.
- **Linear/Damp:** O damping/amortecimento causa uma resistência aos movimentos do corpo. Este parâmetro controla a intensidade deste amortecimento.
- **Linear/Damp Mode:** Existem os modos *Combine* e *Replace*. No primeiro, o damping deste corpo é adicionado ao damp de uma área que aplique damping linear no corpo. No segundo, o damping do corpo é o que sempre será utilizado.
- **Angular/Velocity, Damp, Damp mode:** Todas as propriedades daqui são análogas às três anteriores, mas para rotação.
- **Constant Forces/Force:** Você define um vetor e a engine aplica uma força sobre o corpo constantemente, na direção do vetor.
- **Constant Forces/Torque:** Você define uma força rotacional e a engine aplica uma força de rotação sobre o corpo constantemente. 

## Sinais

- **body_entered:** Emitido quando um corpo ou TileMap colide com o corpo. TileMaps são detectados se o seu TileSet tiver shapes de colisão configuradas.
- **body_exited:** Emitido quando a colisão com o corpo termina.
- **body_shape_entered:** Emitido quando uma parte do corpo colide com uma parte de outro corpo ou TileMap. Este sinal é mais detalhado e mais indicado quando o corpo possui diversas shapes de colisão distintas e você precisa monitorá-las individualmente.
- **body_shape_exited:** Emitido quando a colisão de uma parte do corpo termina (relativo ao *body_shape_entered*).
- **sleeping_state_changed:** Emitido quando o estado de *sleep* do corpo muda. Só funciona quando a mudança vem da engine, não por mudança manual no estado.

## _integrate_forces

Se precisar alterar alguma das propriedades relacionadas à física, você deve usar a função nativa `_integrate_forces` em vez de `_physics_process`. Ela sempre é chamada antes das aplicações de forças, mas a propriedade *Custom Integrator* permite desativar estas aplicações de forças. Assim, você pode realizar aplicações de forças de maneira totalmente personalizada para um corpo.

Neste tutorial nós não falaremos sobre os métodos de aplicação de força em um corpo, mas você pode encontrar todos [neste link](https://docs.godotengine.org/en/stable/classes/class_rigidbody2d.html#class-rigidbody2d-private-method-integrate-forces).

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/StaticBody">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Area">Próximo ➡</a>
</p>
