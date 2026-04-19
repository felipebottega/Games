# Mandelbrot Set

Este é o projeto final para solidificar o conhecimento básico (ou intermediário) de shaders. Depois disso o foco volta a ser as funcionalidades da Godot. Implementar o conjunto de Mandelbrot é importante para confirmar o entendimento da manipulação do sistema UV.

A estrutura da árvore á análoga a utilizada no [Game of Life](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Game%20of%20Life), um `SubViewportContainer` contendo um `SubViewport` contendo um `ColorRect`. O `CanvasLayer` é apenas para mostrar UI. Uma diferença relevante é que aqui não teremos `Camera2D`. No tutorial do Game of Life, bastou renderizar tudo até um pixel de detalhe, pois se tratava de um objeto discretizado por pixel. Aqui temos um objeto que varia continuamente e que requer muito mais detalhe além de um pixel. A renderização total do objeto não é possível em uma única passagem, ela deve ser refeita a cada zoom aplicado. 

> PS: Dar zoom com a câmera e mandar renderizar novamente não funcionaria, pois o zoom da câmera é apenas uma amplicação da imagem, então há perda de resolução. O zoom mencionado é de outra natureza. O importante é que não há perda de resolução neste outro zoom. Veremos isso a seguir.

## Matemática

Vou deixar uma explicação breve de como se obtém o conjunto de Mandelbrot. Para uma explicação mais completa, recomendo [este link](https://en.wikipedia.org/wiki/Mandelbrot_set).

Dado um número complexo $c \in \mathbb{C}$, podemos definir a função complexa $f_c(z) = z^2 + c$. A partir desta função, podemos definir a sequência infinita

$$f_c(0),\ \ f_c(f_c(0)),\ \ f_c(f_c(f_c(0))),\ \ \ldots.$$

O conjunto de Mandelbrot é constituído dos números $c$ para os quais esta sequência não diverge.

Um fato importante sobre este conjunto é que, para um dado $c$, ele pertence ao conjuinto se, e somente se todos os elementos da sequência possuem valor absoluto menor ou igual a $2$. Em termos computacionais, isso significa que podemos implementar as iterações e constatar que há divergência assim que um termo da sequência tiver valor absoluto maior que $2$. Como não é possível ficar iterando para sempre para saber se haverá divergência, o usual é definir um número máximo de iterações. Caso a sequência não tenha divergido durante as iterações, se considera que o valor $c$ associado a sequência pertence ao conjunto de Mandelbrot.

A implementação desta lógica no shader não é complicada. O número complexo $z$ é inicializado como `vec2 z = vec2(0.0, 0.0)`. Depois disso a atualização `z = vec2(z.x * z.x - z.y * z.y + c.x, 2.0 * z.x * z.y + c.y)` é efetuada no loop das iterações. Esta atualização vem do seguinte fato:

$$f_c(z) = z^2 + c =  (z_x + iz_y)^2 + c_x + ic_y = z_x^2 + i2z_xz_y - z_y^2 + c_x + ic_y = (z_x^2 - z_y^2 + c_x, \ \ 2z_xz_y + c_y)$$ 

> PS: Para a fórmula acima está sendo utilizada a convenção $Re(z) = z_x$ e $Im(z) = z_y$.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/aad9962c-2418-4024-b628-c0923a3fd623" />
</p>

## Shader

Abaixo temos o código completo do shader, apenas omitindo a paleta e o código da iteração que já foi mostrado acima. Como podemos ver, a função `fragment()` é bem simples.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/f0f2c902-27ae-40e4-b3d7-06905efd6788" />
</p>
