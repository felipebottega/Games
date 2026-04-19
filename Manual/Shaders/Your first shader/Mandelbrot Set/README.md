# Mandelbrot Set

Este é o projeto final para solidificar o conhecimento básico (ou intermediário) de shaders. Depois disso o foco volta a ser as funcionalidades da Godot. Implementar o conjunto de Mandelbrot é importante para confirmar o entendimento da manipulação do sistema UV.

A estrutura da árvore á análoga a utilizada no [Game of Life](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Game%20of%20Life), um `SubViewportContainer` contendo um `SubViewport` contendo um `ColorRect`. O `CanvasLayer` é apenas para mostrar UI. Uma diferença relevante é que aqui não teremos `Camera2D`. No tutorial do Game of Life, bastou renderizar tudo até um pixel de detalhe, pois se tratava de um objeto discretizado por pixel. Aqui temos um objeto que varia continuamente e que requer muito mais detalhe além de um pixel. A renderização total do objeto não é possível em uma única passagem, ela deve ser refeita a cada zoom aplicado. 

> PS: Dar zoom com a câmera e mandar renderizar novamente não funcionaria, pois o zoom da câmera é apenas uma amplicação da imagem, então há perda de resolução. O zoom mencionado é de outra natureza. O importante é que não há perda de resolução neste outro zoom. Veremos isso a seguir.

## Matemática

Vou deixar uma explicação breve de como se obtém o conjunto de Mandelbrot. Para uma explicação mais completa, recomendo [este link](https://en.wikipedia.org/wiki/Mandelbrot_set).

Dado um número complexo $c \in \mathbb{C}$, podemos definir a função complexa $f_c(z) = z^2 + c$. A partir desta função, podemos definir a sequência infinita

$$f_c(0),\ \ f_c(f_c(0)),\ \ f_c(f_c(f_c(0))),\ \ \ldots.$$

O conjunto de Mandelbrot é constituído dos números $c$ para os quais esta sequência não diverge.

Um fato importante sobre este conjunto é que, para um dado $c$, ele pertence ao conjuinto se, e somente se todos os elementos da sequência possuem valor absoluto menor ou igual a $2$. Em termos computacionais, isso significa que podemos implementar as iterações e constatar que há divergência assim que um termo da sequência tiver valor absoluto maior que $2$. Como não é possível ficar iterando para sempre para saber se haverá divergência, o usual é definir um número máximo de iterações ec, caso a sequência não tenha divergido durante as iterações, se considera que o valor $c$ associado à sequência pertence ao conjunto de Mandelbrot.

## 
