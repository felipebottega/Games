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
  <img width="330" src="https://github.com/user-attachments/assets/f0f2c902-27ae-40e4-b3d7-06905efd6788" />
</p>

A dificuldade deste projeto não é tanto no código, mas no entendimento do que está acontecendo no sistema de coordenadas. Vale a pena dar uma lida nos experimentos 5 e 6 [deste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20third%202D%20shader) para relembrar o básico. 

A primeira coisa que precisa estar clara é que a transformação `uv = uv * 2.0 - 1.0` faz a mudança que está ilustrada abaixo. Como mencionado no experimento 5 do tutorial mencionado acima, em vez de interpretar essa transformação como uma mudança de sistema de coordenadas, pense que a "caixa" do sistema UV é como uma câmera apontada para o espaço 2D. Neste caso nós fizemos um zoom-out para ver 2x mais do que antes e apontamos a câmera para a origem. Esta interpretação é essencial para este projeto, pois passamos a interpretar o conjunto de Mandlebrot como uma objeto estático no plano 2D, e o que se move e faz zoom é a "câmera" implementada pelo sistema UV.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/7b73380a-2700-4be3-b6f1-326c917ebddd" />
</p>

> PS: É importante entender a diferença entre esse zoom simulado e o zoom com o node `Camera2D`. Neste zoom simulado, a resolução da tela é sempre a mesma, então sempre teremos a mesma qualidade de imagem. O zoom do node `Camera2D` é um zoom na tela do jogo de fato, ele se aproxima e se distancia dos pixels, alterando a resolução do que está sendo visto na tela.

Posicionar o sistema da maneira como foi feita acima não é obrigatório, pode-se considerar que isso é uma normalização, de modo a facilitar a interação com os parâmetros de zoom (variável uniform `zoom`) e deslocamento (variável uniform `center`). Veremos como isso funciona.

Logo após a normalização do sistema, o próximo comando é o `uv *= zoom`. Esta variável vem do exterior, através da interação do usuário com o scroll do mouse. Se for $> 1$, o range do sistema UV se expande, o que significa um zoom-out, se for $< 1$, é um zoom-in.

<p align="center">
  <img width="720" src="https://github.com/user-attachments/assets/71714ace-b5d0-4511-99c7-a3ff56efe7fe" />
</p>

Após a etapa de aplicar o zoom, vem o deslocamento do sistema. Isso é feito com o comando `uv += center`, em que `center` é um `vec2` que vem do exterior também. É o ponto onde o mouse está apontando no momento do zoom. Faz todo sentido que o zoom seja nessa direção.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/b3a521c6-4455-491b-a78c-bd2e37738b1e" />
</p>

Depois dessa etapa já com a computação das iterações de Mandelbro. Note que as computações serão baseadas nessa caixa delimitada pelo novo sistema UV. Pegando o exemplo da imagem acima, as iterações de Mandelbrot seriam computadas para $[-2+a, 2+a] \times [-2+b, 2+b]$. Isso equivale a fazer um zoom-out e apontar a câmera para o ponto $(a, b)$. No entanto, nenhuma câmera foi usada na cena, isso é tudo manipulação de sistema de coordenadas.

## GDScript

Acredito que até aqui tudo está bem claro. Esse tipo de manipulação com shaders não é um tópico super avançado. Com um pouco de prática isso passa a ser natural. 

Um pouco mais de dificuldade se encontra no lado do script da Godot. Este script deve passar os parâmetros uniform corretamente para o shader, de maneira dinâmica. Queremos que o zoom seja controlado pelo scroll do mouse e o centro seja a posição do mouse no momento em que o scroll é feito. Além disso, queremos poder clicar e arrastar a imagem, o que essencialmente é alterar o centro da imagem também.

A primeira coisa que acontece na função de input (a função nativa `_input`) é a detecção do tamanho da tela ($800 \times 800$ nesse exemplo) e a posição do mouse na tela em coordenadas da tela. Isso é feito com os comandos `get_viewport().get_visible_rect().size` e `get_viewport().get_mouse_position()`, respectivamente. Neste código, temos as variáveis da instância abaixo. Elas definem o zoom inicial, velocidade de alteração do zoom e o centro inicial, respectivamente.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/9c90c972-44ad-4ba4-a507-013dc2788e44" />
</p>

### Zoom-in

Ao fazer um zoom-in, a primeira coisa que o programa faz é extrair a posição do centro do sistema UV atual, antes de qualquer alteração. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/59fa3775-898f-4247-8808-20bddde1ff4c" />
</p>
