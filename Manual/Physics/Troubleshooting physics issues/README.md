# Troubleshooting physics issues

Este tutorial apresenta soluções para problemas clássicos que costumam ocorrer com a física. Na maioria dos casos, a solução é simplesmente ir em *Project → Project Settings → General → Physics → Common* e colocar a propriedade *Physics Ticks per Second* para um valor mais alto, sempre múltiplo de 60 (120, 180 ou 240). Caso você encontre algum problema na física do jogo e não sabe o que fazer, tente isso primeiro.

## Objetos passando através de outros em alta velocidade

Este problema é conhecido como "tunneling". Ocorre quando o objeto é tão rápido que seu deslocamento vai além dos ticks físicos, então em um frame físico o objeto está de um lado do obstáculo e no próximo frame físico ele já está do outro lado. A engine física nunca teve chance de detectar nenhuma colisão. Abaixo seguem alguma alternativas que você pode testar para solucionar este problema.

  1. Habilitar a propriedade *Continuous CD* se for um `RigidBody`. Esta propriedade foi explicada [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/RigidBody#propriedades).
  2. Aumente a espessura dos shapes de colisão. Por exemplo, se você tiver um chão fino que o jogador não pode atravessar, você pode aumentar a espessura do colisor em relação à representação visual do chão.
  3. Modifique o shape da colisão do seu objeto em movimento rápido de acordo com a sua velocidade. Quanto mais rápido o objeto se move, maior deve ser a área de colisão ao redor do objeto para garantir que ele possa colidir com paredes finas de forma mais confiável.
  4. Aumente a taxa de ticks de física por segundo nas configurações do projeto.

## Objetos físicos empilhados ficam instáveis

Apesar de parecer um problema simples, a simulação de corpos rígidos com objetos empilhados é difícil de implementar na engine física. Isso ocorre devido à integração de forças opostas. Quanto mais objetos empilhados, mais fortes serão as forças opostas. Eventualmente, isso faz com que a simulação fique instável, impedindo que os objetos se mantenham em equilíbrio uns sobre os outros. A solução para isso é aumentar a taxa de ticks de física por segundo nas configurações do projeto.

## Corpos físicos com mudança de escala não colidem corretamente

Este problema já foi mencionado anteriormente [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#mudan%C3%A7a-de-escala-e-f%C3%ADsica) e [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Collision%20shapes%202D#mudan%C3%A7a-de-escala-e-f%C3%ADsica). Simplesmente não altere a escala de objetos físicos. Em vez disso, você pode ir no painel do espaço 2D e alterar por ali o tamanho do objeto.

## Simulações de veículos são instáveis

Isso ocorre principalmente quando os veículos estão em alta velocidade. A solução para isso é aumentar a taxa de ticks de física por segundo nas configurações do projeto.

## A colisão resulta em solavancos quando um objeto se move sobre os ladrilhos/tiles

Este é um problema conhecido causado pelo objeto colidindo com as bordas do shape. Isso pode ocorrer tanto em 2D quanto em 3D. Uma solução para isso é não colocar colisões nos tiles, mas sim colocar as colisões posteriormente de maneira manual.

## O FPS cai demais repentinamente após uma certa quantidade de simulação física

Isso ocorre porque a física não consegue acompanhar a taxa de simulação esperada. Nesse caso, o FPS começará a cair, mas o mecanismo só pode simular um certo número de etapas de física por frame renderizado. Isso se transforma em uma situação em que a taxa de frames continua caindo até atingir um valor muito baixo (normalmente 1-2 FPS), o que é chamado de espiral da morte da física.

Para evitar isso, você deve verificar se há situações em seu projeto que possam causar um número excessivo de simulações de física simultâneas (ou com colisão excessivamente complexas). Se essas situações não puderem ser evitadas, você pode aumentar a configuração *Max Physics Steps per Frame* do projeto ou reduzir o *Physics Ticks per Second* para atenuar o problema.

## A simulação física é instável quando se está longe da origem do mundo

Isso é causado por erros de precisão de ponto flutuante, que se tornam mais pronunciados à medida que a simulação física ocorre mais longe da origem do mundo (coordenada $(0, 0)$ ). Esse problema também afeta a renderização, resultando em movimentos instáveis ​​da câmera quando se está longe da origem do mundo.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20Interpolation">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Platform-specific">Próximo ➡</a>
</p>
