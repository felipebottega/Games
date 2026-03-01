# Physics Interpolation

Introduzimos o asssunto dos frames físicos (também chamados de "iterações físicas" ou "ticks físicos") no tutorial de introdução sobre a [física da engine](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-process). O default é termos 60 frames físicos por segundo (60 Hz). Muitos monitores operam a 60 Hz ou até a taxas maiores. Isso significa que eles são capazes de detectar as mudanças de renderização. Lembre-se que os frames físicos são cálculos internos, enquanto que a renderização é o que é desenhado na tela, e é a taxa de renderização que determina op FPS do jogo. Pode acontecer dos frames físicos atualizarem a uma taxa mais lenta que o FPS, o que vai causar distorções no jogo semelhantes à um lag ou stutter (ver [esse tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/General%20optimization%20tips) para lembrar das diferenças).

Para ver o efeito de ter a frame físico mais lento que o FPS, você pode ir em *Project → Project Settings → General → Physics → Common* e colocar a propriedade *Physics Ticks per Second* para um valor pequeno. No exemplo abaixo, comparamos o caso normal com o caso onde esta propriedade está igual a 4. A diferença é evidente.

https://github.com/user-attachments/assets/2ca3f8f6-e1c0-48f9-9ce4-e246f0250b9b

