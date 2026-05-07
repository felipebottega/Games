# Physics Interpolation

Introduzimos o asssunto dos frames físicos (também chamados de "iterações físicas" ou "ticks físicos") no tutorial de introdução sobre a [física da engine](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-process). O default é termos 60 frames físicos por segundo (60 Hz). Muitos monitores operam a 60 Hz ou até a taxas maiores. Isso significa que eles são capazes de detectar as mudanças de renderização. Lembre-se que os frames físicos são cálculos internos, enquanto que a renderização é o que é desenhado na tela, e é a taxa de renderização que determina o FPS do jogo. Pode acontecer dos frames físicos atualizarem a uma taxa mais lenta que o FPS, o que vai causar distorções no jogo semelhantes à um lag ou stutter (ver [esse tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/General%20optimization%20tips) para lembrar das diferenças).

Para ver o efeito de ter frames físicos mais lentos que o FPS, você pode ir em *Project → Project Settings → General → Physics → Common* e colocar a propriedade *Physics Ticks per Second* para um valor pequeno. No exemplo abaixo, comparamos o caso normal com o caso onde esta propriedade está igual a $4$ frames físicos por segundo. A diferença é evidente.

https://github.com/user-attachments/assets/2ca3f8f6-e1c0-48f9-9ce4-e246f0250b9b

## Interpolação linear

No caso em que o seu jogo está demandando demais da física e os cálculos não estão acompanhando o FSP, uma alternativa é usar *interpolação física*. Você pode ativá-la em *Project → Project Settings → General → Physics → Common*, como mostrado abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/0ee31080-d44f-4fae-a94c-636f270cc3fd" />
</p>

Quando esta opção está habilitada, a engine sempre "fabrica" frames novos de física interpolando os anteriores. É importante ressaltar que a engine não projeto o próximo passo físico com a interpolação, ela sempre preenche o passado. Isso é para evitar projeções de situações fisicamente impossíveis sem querer. Por conta disso, note que os frames físicos sempre esta~rao um pouco atrasados em relação ao que deveriam estar, já que o frame físico atual sempre será uma interpolação para trás no tempo. Como estamos falando de fração de segundo, isso não deve interferir.

> PS: Evite usar interpolação linear física em jogos multiplayer online. Nestes casos é melhor fazer uma interpolação customizada.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Collision%20shapes%202D">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Troubleshooting%20physics%20issues">Próximo ➡</a>
</p>
