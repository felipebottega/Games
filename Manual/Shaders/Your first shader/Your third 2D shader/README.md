# Your third 2D shader

Este tutorial é o último da série *Your ith shader*. Parte dele é baseado neste [video do youtube](https://www.youtube.com/watch?v=f4s1h2YETNY) que é muito bom para entender a dinâmica de shaders, assumindo que você já entende de [GLSL](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Introduction%20to%20shaders#introduction-to-shaders).

No tutorial anterior, eu apenas comentei sobre um dos efeitos e deixei o restante para a pessoa testar e acessar o código para ler e entender. Como esse aqui trata de efeitos mais básicos, faço questão de explicar um por um. No total, vamos passar por 14 efeitos. Porém, alguns deles são sequenciais, ou seja, pega um efeito anterior e acrescenta uma coisa pequena por cima. Está bem didático.

## Leitura da texturas do frame anterior no shader

Antes mesmo de falar dos experimentos, precisamos falar de uma técnica importante para certos tipos de shader. Existem casos em que o shader trabalha de forma iterativa, ou seja, ele não é apenas um efeito que atua sobre uma textura estática (todos os shaders do [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20second%202D%20shader) foram assim), mas sim um efeito que atua sobre o output do próprio efeito na textura no frame anterior. Isso significa que, a cada frame, a textura com o efeito do shader precisa se armazenada na memória e passada para a GPU no frame seguinte. Note que isso necessita de passar a textura completa entre CPU e GPU 2 vezes por frame. 

> PS: Dependendo do tipo de shader a ser aplicado, pode não ser necessário passar a textura completa entre CPU e GPU a cada frame. Vamos adotar o approach menos otimizado por ser rápido o suficiente para as nossas aplicações e também por ser mais simples.

Em todos os experimentos, a estrutura principal da árvore é a mostrada abaixo. Precisamos do `SubViewport` pois é esse node que nos permite salvar a textura. A função `snapshot` recebe o node `SubViewport`, extrai a sua textura com o método `get_texture().get_image()` e salva essa textura como imagem, usando o comando `ImageTexture.create_from_image()`. Note que sempre antes de chamar a função devemos usar o `await RenderingServer.frame_post_draw` para esperar a renderização terminar. Nenhuma dessas chamadas foi abordada nos tutoriais, recomendo consultar a documentação para um melhor entendimento. Depois que textura está salva, a próxima iteração usa a chamada `set_shader_parameter()` para enviar essa textura para o shader. Esta última chamada já foi abordada, no [Your first 2D shader](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20first%202D%20shader#interagindo-com-o-shader-por-c%C3%B3digo).

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/0dde028f-71ba-4766-bd75-b31fb95b68ae" />
  <img width="460" src="https://github.com/user-attachments/assets/72ec061d-2987-4d5c-9c61-d455bb217982" />
</p>

No shader, utiliza-se o comando `texture(input_texture, uv)` para extrair a cor do pixel da posição `uv` da textura `input_texture`. Como essa textura veio de um uniform, que veio do exterior, podemos sempre armazenar extenamente a textura de um frame e passá-la para o frame seguinte. 

## Experimento 1


Abaixo temos o código do shader. Na primeira iteração (`iter == 0`) o shader desenha uma linha diagonal preta em um fundo branco. A espessura dessa linha corresponde a 2% do tamanho da tela (UV). Basicamente 1% acima da diagonal e 1% abaixo da diagonal, é isso que a condição `abs(uv.x - uv.y) < 0.01` significa.

Depois dessa primeira iteração, as outras fazem semper a mesma coisa. Primeiro verifica se a coordenada $y$ está longe o suficiente do topo, devendo estar distante do topo em pelo menos 1% da altura total (condição `uv.y >= 0.01`). Se a condição não for satisfeita, pinta o pixel de branco. Ou seja, os primeiros 1% do topo da imagem sempre serão brancos. Se a condição for satisfeita, a coordenada $y$ muda para a que está 1% do total da altura acima (`uv.y -= 0.01;`). Depois disso, o shader extrai a cor correspondente do pixel `uv` em relação à textura do frame anterior (comando `texture(input_texture, uv)`). Essa cor é usada para atualizar a cor do pixel atual ao atribuir este valor para `COLOR`.

<p align="center">
  <img width="320" src="https://github.com/user-attachments/assets/90f33327-690b-4970-b94b-3a3763bb6e44" />
</p>

A figura abaixo ilustra o processo. Quando o shader ler o pixel `uv` = $(\texttt{uv}_x, \texttt{uv}_y)$, ele vai atualizar este pixel de modo que a cor deele seja igual a do pixel $(\texttt{uv}_x, \texttt{uv}_y - 0.01)$, que está um pouco acima. Se o pixel de cima for branco, nada muda. Se for um pixel da diagonal, ele será preto. Então a cor do pixel um pouco abaixo será preto também. O efeito disso é que, aos poucos, a diagonal vai descendo na tela verticalmente. A regra de sempre deixar os primeiros 1% brancos é para evitar que estes pixel tentem atualizar para valores fora da textura.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/e85f2825-d52f-42d4-8b96-823d6356ceca" />
</p>

## Experimento 2

Assim que você olha a animação que esse shader produz, consegue notar que a diagonal fica meio borrada assim que começa a descer. Isso acontece porque o deslocamento dela não é em pixels, mas sim em um percentual da altura. Como as coordenadas UV são contínuas, não existe a discretização de pixel e movimento por grade. O borrado acontece porque o cor entregue bate em subpixels, o que acarreta numa cor interpolada entre as vizinhas. Então além de preto ou branco, acabamos obtendo tons de cinza também.

O fato de UV sererm as coordenadas usuais para shader, não significa que é impossível trabalhar em coordenadas de pixels. Vamos ver neste experimento como se faz isso. Este experimento é um réplica do anterior, com a diferença que o movimento da diagonal será por passos baseados em pixels em vez de percentual da altura. Antes mesmo de começar a explicar o código, deixamos os dois códigos lado a lado: o código anterior (baseado em UV) e o código atual (baseado em pixels).

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/86b39d8f-eeee-461e-8b65-7e115a94394b" />
</p>

A primeira coisa que fazemos é obter as coordenadas em pixels do ponto. O [valor nativo](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/CanvasItem%20shaders#valores-nativos-do-fragment) `FRAGCOORD` faz esse trabalho. Nesse caso, basta extrair as coordenadas $xy$ deste vetor. Vale ressaltar que o espaço original não é discreto, esse valor representa o centro do pixel correspondente. 

O valor nativo `SCREEN_PIXEL_SIZE` te entrega um vetor 2D, contendo o tamanho do pixel. Não é necessariamente verdade que o pixel será um quadrado neste sistema de coordenadas. Vale também ressaltar que este approach te entrega os pixels em coordenadas locais do node, começando do canto superior esquerdo até o canto inferior direito. Por conta desta propriedade, podemos obter o tamanho da textura com o comando `vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;`, como foi feito no exemplo.

As condicionais e operações feitas são análogas a do exemplo anterior, mas em termos de pixels. Vale notar que o valor de 10 pixels é arbitrário, apenas para testes. 

No approach default, a coordenada do ponto é o vetor nativo `UV`, que nunca deve ser alterado diretamente. Você pode notar que sempre declaramos `vec2 uv = UV;` e trabalhamos com o vetor `uv`. No caso de pixels, apesar de não ser obrigatório, tratamos o vetor `p` como o `UV`. Até usamos o `p` para as verificações, mas no momento de definir um novo ponto, usamos o `new_p`, que faz o papel análogo do `uv`.

Por fim, no momento de atualizar o `COLOR`, é necessário normalizar o ponto `new_p` para o sistema `UV`, pois a função `texture()` só trabalha nas coordenadas usuais do shader. Essa normalização é feita com o comando `vec2 uv = new_p / screen_size`, e depois a atualização `COLOR = texture(input_texture, uv);` é a usual.

Apenas para ter algo concreto em números, considere uma textura $10 \times 10$ e suponha que será atualizado o pixel da última coordenada (canto inferior direito), o pixel em $(9.5, 9.5)$. Ele está nessa posição quebrada pois este é o centro do último pixel. Sendo assim, temos que 

$$ \texttt{uv} = \frac{\texttt{new p}}{\texttt{screen size}} = \left(\frac{\texttt{new p}_x}{\texttt{screen width}}, \frac{\texttt{new p}_y}{\texttt{screen heigth}}\right).$$

## Experimento 3

Este experimento é apenas para confirmar que aprendemos a trabalhar em coordenadas de pixels. O objetivo aqui é criar um padrão de tabuleiro de xadrez, com pixels se alternando em preto e branco. Desta vez não há nenhuma textura externa sendo atualizada. O shader apenas renderiza o padrão e mais nada se altera, é uma imagem fixa.

Para esse caso, alteramos para um sistema de coordenadas de inteiros. O tipo de vetor `ivec2` trunca os valores. Isso significa que cada coordenada não está mais associada ao centro do pixel, mas sim ao seu canto superior esquerdo. Seria totalmente possível trabalhar com floats e os centros dos pixels, mas essa conversão foi criada justamente para mostrar que é possível um sistema de coordenada de inteiros.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/525d05ba-991f-45ed-9880-4b9dd21fb9bc" />
</p>

## Experimento 4

Este experimento pode ser visto como uma continuação do anterior. Dessa vez, em vez de alterar todos os pixels da textura (que tem sido o logo da Godot desde o primeiro experimento), o shader altera apenas alguns. A cor se modifica dependendo de do valor da coordenada $x$ ou $y$ do pixel $\mod 5$. A cor nova depende da coordenada testada, o que cria um efeito gradiante na imagem final.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7c0ce8ff-cf26-4643-bcbb-21686dc51f7f" />
  <img width="440" src="https://github.com/user-attachments/assets/8629699c-7ac1-4f40-9372-55968f80f71e" />
</p>


