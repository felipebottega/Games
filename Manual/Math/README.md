# Math

Acredito que a parte de matemática de qualquer engine tenha muito mais a ver com a experiência com matemática e menos com tutoriais. Então não acho fazer exemplos de aplicações com matemática vão agregar muito. No fim do dia, o que vai contar são as experiências que o dev terá ao longo de sua jornada. Vou me limitar a listar algumas funcionalidades aqui.

## Vetores

A função `Vector2` cria um vetor de duas coordenadas do tipo float. Você também pode criar um vetor de coordenadas inteiras com a função `Vector2i`. Temos também as funções análogas para 3 e 4 dimensões. Para dimensões além dessas é melhor criar um array, que é basicamente uma lista, que nem listas de Python, e segue a mesma sintaxe. As operações entre vetores e vetores e escalares é simples, com notação análoga à Numpy.

Um exemplo simples, porém importante, é o de mover um ponto em direção a outro ponto no plano 2D. Cada ponto é determinado por um vetor 2D. Sendo $A$ o primeiro vetor e $B$ o segundo, o vator $B - A$ é um vetor que a partir de $A$ aponta para $B$. A imagem abaixo (tirada do [tutorial oficial](https://docs.godotengine.org/en/stable/tutorials/math/vector_math.html)) ilustra esta explicação.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/e09615b2-b4aa-4027-9e47-a455f1b918ee" />
</p>

Dado um vetor $A$ em Godot, o método `A.normalized()` retorna a versão normalizada deste vetor, isto é, o vetor com a mesma direção e sentido mas magnitude igual a $1$. O método `A.length()` retorna a o comprimento (norma Euclideana) do vetor. Dados dois vetores $A$ e $B$, o método `A.dot(B)` retorna o produto escalar entre eles. Dados dois vetores $A$ e $B$ de 3 dimensões, o método `A.cross(B)` retorna o produto vetorial entre eles.

A Godot apresenta alguns vetores especiais nativos:

  - `Vector2.DOWN` $=(0, 1)$
  - `Vector2.UP` $=(0, -1)$
  - `Vector2.RIGHT` $=(1, 0)$
  - `Vector2.LEFT` $=(-1, 0)$
  - `Vector2.ONE` $=(1, 1)$
  - `Vector2.ZERO` $=(0, 0)$
  - `Vector2.INF` $=(inf, inf)$

## Funções matemáticas

A Godot já tem implementadas algumas funções matemáticas básicas, de escopo global. Algumas delas são `cos, sin, tan, min, max, log, exp, floor, ceil, sqrt, abs`. Para ver a listagem geral, acesse [este link](https://docs.godotengine.org/en/stable/classes/class_@globalscope.html). O uso destas funções é bem direto, então não vou me aprofundar nisto.

## Interpolação

Dados dois vetores $A$ e $B$, e um escalar $t \in [0, 1]$ o método `A.lerp(B, t)` retorna a interpolação linear $(1-t) \cdot A + t \cdot B$. Nós já vimos [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Introduction%20to%20the%20animation%20features) que é possível movimentar objetos no jogo manipulando parâmetros com animação. Em alguns momentos pode ser mais prático fazer isto com código. 

O exemplo abaixo mostra uma aplicação da interpolação linear entre vetores. Note que podemos manipular o parâmetro $t$ antes de entrar na função para que a interpolação fique mais suave (e menos linear).

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/e0252442-ed5a-4b4e-a163-80190007a25e" />
</p>

## Geração de números aleatórios
