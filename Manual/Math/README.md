# Math

Acredito que a parte de matemática de qualquer engine tenha muito mais a ver com a experiência com matemática e menos com tutoriais. Então não acho fazer exemplos de aplicações com matemática vão agregar muito. No fim do dia, o que vai contar são as experiências que o dev terá ao longo de sua jornada. Vou me limitar a listar algumas funcionalidades aqui.

## Vetores

A função `Vector2` cria um vetor de duas coordenadas do tipo float. VocÊ também pode criar um vetor de coordenadas inteiras com a função `Vector2i`. Temos também as funções análogas para 3 e 4 dimensões. Para dimensões além dessas é melhor criar um array, que é basicamente uma lista, que nem listas de Python, e segue a mesma sintaxe. As operações entre vetores e vetores e escalares é simples, com notação análoga à Numpy.

Um exemplo simples, porém importante, é o de mover um ponto em direção a outro ponto no plano 2D. Cada ponto é determinado por um vetor 2D. Sendo $A$ o primeiro vetor e $B$ o segundo, o vator $B - A$ é um vetor que a partir de $A$ aponta para $B$. A imagem abaixo (tirada do [tutorial oficial](https://docs.godotengine.org/en/stable/tutorials/math/vector_math.html)) ilustra esta explicação.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/e09615b2-b4aa-4027-9e47-a455f1b918ee" />
</p>

Dado um vetor $A$ em Godot, a função `A.normalized()` retorna a versão normalizada deste vetor, isto é, o vetor com a mesma direção e sentido mas magnitude igual a $1$.
