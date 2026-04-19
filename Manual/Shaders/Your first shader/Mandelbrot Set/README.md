# Mandelbrot Set

Este é o projeto final para solidificar o conhecimento básico (ou intermediário) de shaders. Depois disso o foco volta a ser as funcionalidades da Godot. Implementar o conjunto de Mandelbrot é importante para confirmar o entendimento da manipulação do sistema UV.

A estrutura da árvore é análoga a utilizada no [Game of Life](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Game%20of%20Life), um `SubViewportContainer` contendo um `SubViewport` contendo um `ColorRect`. O `CanvasLayer` é apenas para mostrar UI. Uma diferença relevante é que aqui não teremos `Camera2D`. No tutorial do Game of Life, bastou renderizar tudo até um pixel de detalhe, pois se tratava de um objeto discretizado por pixel. Aqui temos um objeto que varia continuamente e que requer muito mais detalhe além de um pixel. A renderização total do objeto não é possível em uma única passagem, ela deve ser refeita a cada zoom aplicado. 

> PS: Dar zoom com a câmera e mandar renderizar novamente não funcionaria, pois o zoom da câmera é apenas uma amplicação da imagem, então há perda de resolução. O outro zoom mencionado acima é de outra natureza. O importante é que não há perda de resolução neste outro zoom. Veremos isso a seguir.

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

Posicionar o sistema da maneira como foi feita acima não é obrigatório, pode-se considerar que isso é uma normalização, de modo a facilitar a atualização dos parâmetros de zoom (variável uniform `zoom`) e deslocamento (variável uniform `center`).

Logo após a normalização do sistema, o próximo comando é o `uv *= zoom`. Esta variável vem do exterior, através da interação do usuário com o scroll do mouse. Se for $> 1$, o range do sistema UV se expande, o que significa um zoom-out, se for $< 1$, é um zoom-in.

<p align="center">
  <img width="720" src="https://github.com/user-attachments/assets/71714ace-b5d0-4511-99c7-a3ff56efe7fe" />
</p>

Após a etapa de aplicar o zoom, vem o deslocamento do sistema. Isso é feito com o comando `uv += center`, em que `center` é um `vec2` que vem do exterior também. É o ponto onde o mouse está apontando no momento do zoom.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/f0fdb263-a5ac-4270-a8e1-463b97046c0e" />
</p>

Note que as computações serão baseadas nessa caixa delimitada pelo novo sistema UV. Pegando o exemplo da imagem acima, as iterações de Mandelbrot seriam computadas para $[-2+a, 2+a] \times [-2+b, 2+b]$. Isso equivale a fazer um zoom-out e apontar a câmera para o ponto $(a, b)$. No entanto, nenhuma câmera foi usada na cena, isso é tudo manipulação de sistema de coordenadas.

## GDScript

Acredito que até aqui tudo está bem claro. Esse tipo de manipulação com shaders não é um tópico super avançado. Com um pouco de prática isso passa a ser natural. 

Um pouco mais de dificuldade se encontra no lado do script da Godot. Este script deve passar os parâmetros uniform corretamente para o shader, de maneira dinâmica. Queremos que o zoom seja controlado pelo scroll do mouse e o centro seja a posição do mouse no momento em que o scroll é feito. Além disso, queremos poder clicar e arrastar a imagem, o que essencialmente é alterar o centro da imagem também.

A primeira coisa que acontece na função de input (a função nativa `_input`) é a detecção do tamanho da tela ($800 \times 800$ nesse exemplo) e a posição do mouse na tela em coordenadas da tela. Isso é feito com os comandos `get_viewport().get_visible_rect().size` e `get_viewport().get_mouse_position()`, respectivamente. Neste código, temos as variáveis da instância abaixo. Elas definem o zoom inicial, velocidade de alteração do zoom e o centro inicial, respectivamente.

<p align="center">
  <img width="260" src="https://github.com/user-attachments/assets/9c90c972-44ad-4ba4-a507-013dc2788e44" />
</p>

### Extraindo a posição do mouse no sistema UV

Ao fazer um zoom, seja zoom-in ou zoom-out, a primeira coisa que o programa faz é extrair a posição do mouse no sistema UV atual. Você pode notar que o código abaixo é uma réplica do que o shader faz. Neste caso, em vez de aplicar a transformação para um pixel, ela é aplicada para posição do mouse em coordenadas UV.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/59fa3775-898f-4247-8808-20bddde1ff4c" />
</p>

### Atualizando zoom e deslocamento

A variável `before` contém para a posição atual do mouse no sistema UV atual. Após este valor ser armazenado, o novo zoom é calculado. Com isso há um novo sistema UV, onde o zoom é diferente. Calcula-se a posição do mouse no sistema UV com esse zoom. A diferença entre essa posição e a calculada anteriormente é usada como "delta" para incrementar a variável `center`, e essa última é que vai para o shader.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/0d933633-247d-4439-81d3-fbd843d46ad8" />
</p>  

Essa abordagem de deslocar o centro desta maneira é para que o comportamento do zoom seja mais adequado. Um modo mais simples de proceder seria simplesmente passar o novo zoom e novo centro para o shader, desconsiderando totalmente o centro anterior, mas o comportamento ficaria do zoom 
"estranho" e o usuário iria notar isso. Durante um zoom, o mouse acaba apontando para outra ponto, e acabaria que o zoom não iria para a direção esperada. O método por incrementos funciona melhor nesse sentido.

### Explicação por diagramas

Abaixo nós temos algumas imagens mostrando cada etapa das operações feitas. Vale notar o ponto `center` no último diagrama é a posição do mouse no frame anterior, e `S` é o montante de zoom do último frame anterior. O ponto $(x'', y'')$ é a posição atual do mouse relativo ao sistema de coordenadas anterior. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/05c946a4-9411-47a8-96b7-b6617cf79873" />
</p>

Depois disso é aplicado o zoom sobre o sistema de coordenadas anterior. Aqui nós o representamos como um fator multiplicativo $T$ sobre as coordenadas, mas no código está separado em zoom-in e zoom-out, sendo um divisão e outro multiplicação. No fim das contas tudo pode ser visto como multiplicação, bastando inverter o valor antes de aplicar a multiplicação. 

De todo modo, após aplicar este zoom, obtemos um novo sistema de coordenadas, onde a posição do mouse na tela se encontra em $(Tx'', Ty'')$. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/ca5e70b1-9ba6-4598-b77a-dc2cde32ae7c" />
</p>

Agora a diferença $\delta = (x'', y'') - (Tx'', Ty'')$ é usada para obter o novo centro, dado por 

$$\texttt{center} = \texttt{old center} + \delta = (a, b) + \delta = (a, b) + (x'', y'') - (Tx'', Ty'').$$

As fórmulas explícitas e cada etapa dos diagramas foram colocados aqui apenas para deixar claro o que acontece por trás dos bastidores, mas na prática você apenas precisa pensar em alterar escala e transladar. Pense geometricamente no que está acontecendo e tudo vai ficar bem, nenhuma dessas fórmulas precisa de fato ser pensada durante o desenvolvimento.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/9475f541-ba97-42e5-9967-6ab0eac19ef0" />
</p>

O meu projeto do conjunto de Mandelbrot pode ser acessado [neste link](https://felipebottega.github.io/Games/Manual/Shaders/Your%20first%20shader/Mandelbrot%20Set/html/).
