# Your third 2D shader

Este tutorial é o último da série *Your ith shader*. Parte dele é baseado neste [video do youtube](https://www.youtube.com/watch?v=f4s1h2YETNY) que é muito bom para entender a dinâmica de shaders, assumindo que você já entende de [GLSL](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Introduction%20to%20shaders#introduction-to-shaders).

No tutorial anterior, eu apenas comentei sobre um dos efeitos e deixei o restante para a pessoa testar e acessar o código para ler e entender. Como esse aqui trata de efeitos mais básicos, faço questão de explicar um por um. No total, vamos passar por 14 efeitos. Porém, alguns deles são sequenciais, ou seja, pega um efeito anterior e acrescenta uma coisa pequena por cima. Está bem didático.

## Leitura da texturas do frame anterior no shader

Antes mesmo de falar dos experimentos, precisamos falar de uma técnica importante para certos tipos de shader. Existem casos em que o shader trabalha de forma iterativa, ou seja, ele não é apenas um efeito que atua sobre uma textura estática (todos os shaders do [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20second%202D%20shader) foram assim), mas sim um efeito que atua sobre o output do próprio efeito na textura no frame anterior. Isso significa que, a cada frame, a textura com o efeito do shader precisa ser armazenada na memória e repassada para a GPU no frame seguinte. Note que isso necessita de passar a textura completa entre CPU e GPU 2 vezes por frame. 

> PS: Dependendo do tipo de shader a ser aplicado, pode não ser necessário passar a textura completa entre CPU e GPU a cada frame. Vamos adotar o approach menos otimizado por ser rápido o suficiente para as nossas aplicações e também por ser mais simples.

Em todos os experimentos, a estrutura principal da árvore é a mostrada abaixo. Precisamos do `SubViewport` pois é esse node que nos permite salvar a textura. A função `snapshot` recebe o node `SubViewport`, extrai a sua textura com o método `get_texture().get_image()` e salva essa textura como imagem, usando o comando `ImageTexture.create_from_image()`. Note que, sempre antes de chamar a função, devemos usar o `await RenderingServer.frame_post_draw` para esperar a renderização terminar. Nenhuma dessas chamadas foi abordada nos tutoriais, recomendo consultar a documentação para um melhor entendimento. Depois que textura está salva, a próxima iteração usa a chamada `set_shader_parameter()` para enviar essa textura para o shader. Esta última chamada foi abordada no [Your first 2D shader](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20first%202D%20shader#interagindo-com-o-shader-por-c%C3%B3digo).

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/0dde028f-71ba-4766-bd75-b31fb95b68ae" />
  <img width="520" src="https://github.com/user-attachments/assets/72ec061d-2987-4d5c-9c61-d455bb217982" />
</p>

No shader, utiliza-se o comando `texture(input_texture, uv)` para extrair a cor do pixel da posição `uv` da textura `input_texture`. Como essa textura veio de um uniform, que veio do exterior, podemos sempre armazenar extenamente a textura de um frame e passá-la para o frame seguinte. 

## Experimento 1


Abaixo temos o código do primeiro shader. Na primeira iteração (`iter == 0`) o shader desenha uma linha diagonal preta em um fundo branco. A espessura dessa linha corresponde a 2% do tamanho da tela (UV). Basicamente 1% acima da diagonal e 1% abaixo da diagonal, é isso que a condição `abs(uv.x - uv.y) < 0.01` significa.

Depois dessa primeira iteração, as outras fazem sempre a mesma coisa. Primeiro verifica se a coordenada $y$ está longe o suficiente do topo, devendo estar distante do topo em pelo menos 1% da altura total (condição `uv.y >= 0.01`). Se a condição não for satisfeita, pinta o pixel de branco. Ou seja, os primeiros 1% do topo da imagem sempre serão brancos. Se a condição for satisfeita, a coordenada $y$ muda para a que está 1% do total da altura acima (`uv.y -= 0.01`). Depois disso, o shader extrai a cor correspondente do pixel `uv` em relação à textura do frame anterior (comando `texture(input_texture, uv)`). Essa cor é usada para atualizar a cor do pixel atual ao atribuir este valor para `COLOR`.

<p align="center">
  <img width="320" src="https://github.com/user-attachments/assets/90f33327-690b-4970-b94b-3a3763bb6e44" />
</p>

A figura abaixo ilustra o processo. Quando o shader ler o pixel `uv` = $(\texttt{uv}_x, \texttt{uv}_y)$, ele vai atualizar este pixel de modo que a cor dele seja igual a do pixel $(\texttt{uv}_x, \texttt{uv}_y - 0.01)$, que está um pouco acima. Se o pixel de cima for branco, nada muda. Se for um pixel da diagonal, ele será preto. Então a cor do pixel um pouco abaixo será preto também. O efeito disso é que, aos poucos, a diagonal vai descendo na tela verticalmente. A regra de sempre deixar os primeiros 1% brancos é para evitar que estes pixel tentem atualizar para valores fora da textura.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/e85f2825-d52f-42d4-8b96-823d6356ceca" />
</p>

## Experimento 2

Assim que você olha a animação que esse shader produz, consegue notar que a diagonal fica meio borrada assim que começa a descer. Isso acontece porque o deslocamento dela não é em pixels, mas sim em um percentual da altura. Como as coordenadas UV são contínuas, não existe a discretização de pixel e movimento por grade. O borrado acontece porque o cor entregue bate em subpixels, o que acarreta numa cor interpolada entre as vizinhas. Então além de preto ou branco, acabamos obtendo tons de cinza também.

O fato de UV serem as coordenadas usuais para shader, não significa que é impossível trabalhar em coordenadas de pixels. Vamos ver neste experimento como se faz isso. Este experimento é um réplica do anterior, com a diferença que o movimento da diagonal será por passos baseados em pixels em vez de percentual da altura. Antes mesmo de começar a explicar o código, deixamos os dois códigos lado a lado: o código anterior (baseado em UV, à esquerda) e o código atual (baseado em pixels, à direita).

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/86b39d8f-eeee-461e-8b65-7e115a94394b" />
</p>

A primeira coisa que fazemos é obter as coordenadas em pixels do ponto. O [valor nativo](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/CanvasItem%20shaders#valores-nativos-do-fragment) `FRAGCOORD` faz esse trabalho. Nesse caso, basta extrair as coordenadas $xy$ deste vetor. Vale ressaltar que o espaço original não é discreto, esse valor representa o centro do pixel correspondente. 

O valor nativo `SCREEN_PIXEL_SIZE` te entrega um vetor 2D, contendo o tamanho do pixel em coordenadas UV. Não é necessariamente verdade que o pixel será um quadrado neste sistema de coordenadas. Vale também ressaltar que este approach te entrega os pixels em coordenadas locais do node, começando do canto superior esquerdo até o canto inferior direito. Por conta desta propriedade, podemos obter o tamanho da textura com o comando `vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE`, como foi feito no exemplo.

As condicionais e operações feitas são análogas à do exemplo anterior, mas em termos de pixels. Vale notar que o valor de 10 pixels é arbitrário, apenas para testes. 

No approach default, a coordenada do ponto é o vetor nativo `UV`, que nunca deve ser alterado diretamente. Você pode notar que sempre declaramos `vec2 uv = UV` e trabalhamos com o vetor `uv`. No caso de pixels, apesar de não ser obrigatório, tratamos o vetor `p` como o `UV`. Até usamos o `p` para as verificações, mas no momento de definir um novo ponto, usamos o `new_p`, que faz o papel análogo do `uv`.

Por fim, no momento de atualizar o `COLOR`, é necessário normalizar o ponto `new_p` para o sistema UV, pois a função `texture()` só trabalha nas coordenadas usuais do shader. Essa normalização é feita com o comando `vec2 uv = new_p / screen_size`, e depois a atualização `COLOR = texture(input_texture, uv)` é a usual.

Apenas para ter algo concreto em números, considere uma textura $10 \times 10$ e suponha que será atualizado o pixel da última coordenada (canto inferior direito), o pixel em $(9.5, 9.5)$. Ele está nessa posição quebrada pois este é o centro do último pixel. Sendo assim, temos que 

$$ \texttt{uv} = \frac{\texttt{new p}}{\texttt{screen size}} = \left(\frac{\texttt{new p}_x}{\texttt{screen width}}, \frac{\texttt{new p}_y}{\texttt{screen heigth}}\right).$$

## Experimento 3

Este experimento é apenas para confirmar que aprendemos a trabalhar em coordenadas de pixels. O objetivo aqui é criar um padrão de tabuleiro de xadrez, com pixels se alternando em preto e branco. Desta vez não há nenhuma textura externa sendo atualizada. O shader apenas renderiza o padrão e mais nada se altera, é uma imagem fixa.

Para esse caso, alteramos para um sistema de coordenadas de inteiros. O tipo de vetor `ivec2` trunca os valores. Isso significa que cada coordenada não está mais associada ao centro do pixel, mas sim ao seu canto superior esquerdo. Seria totalmente possível trabalhar com floats e os centros dos pixels, mas essa conversão foi criada justamente para mostrar que é possível um sistema de coordenada de inteiros.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/525d05ba-991f-45ed-9880-4b9dd21fb9bc" />
</p>

## Experimento 4

Este experimento pode ser visto como uma continuação do anterior. Dessa vez, em vez de alterar todos os pixels da textura (que tem sido o logo da Godot desde o primeiro experimento), o shader altera apenas alguns. A cor se modifica dependendo de do valor da coordenada $x$ ou $y$ do pixel em $\texttt{mod}\ 5$. A cor nova depende da coordenada testada, o que cria um efeito gradiente na imagem final.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7c0ce8ff-cf26-4643-bcbb-21686dc51f7f" />
  <img width="440" src="https://github.com/user-attachments/assets/8629699c-7ac1-4f40-9372-55968f80f71e" />
</p>

Este exemplo também possui um código GDScript que altera a escala da figura com o passar do tempo, aumentando e diminuindo de maneira oscilatória. Meu objetivo com esse teste foi o de confirmar que o sistema de coordenada UV escala junto com a textura, o que de fato é verdade. Não importa se aplicamos escala, rotacionamos ou transladamos a figura, o sistema UV se altera junto e os efeitos do shader são aplicados corretamente.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/712d6027-c166-4405-930c-e9f64f5c6357" />
</p>

## Experimento 5

Esse começa fazendo subtraindo `uv` por $0.5$. Desta vez a subtração não é feita para extrair a cor do pixel em outra posição, o que está acontencendo agora é uma mudança de coordenadas. O modo mais usual de interpretar isso é imaginar que o sistema `UV` é uma "caixa" no plano 2D (com o eixo $y$ invertido em relação ao tradicional) e, ao fazer um shift, movemos a caixa de posição.

<p align="center">
  <img width="306" src="https://github.com/user-attachments/assets/1707017c-06e5-42c9-b74a-1cc192236213" />
  <img width="300" src="https://github.com/user-attachments/assets/8f6e4a05-f9ab-45d7-8781-500fd4f1b09b" />
  <img width="800" src="https://github.com/user-attachments/assets/2268f2a0-a35a-49fc-953b-3817a156442b" />
</p>

Após a mudança de coordenadas, a função `length()` calcula a norma Euclideana do vetor `uv`. Como o sistema está centrado na origem, esta norma coincide com a distância do pixel ao centro da imagem. Usando essa informação, a atualização `COLOR.r = pow(1.0 - uv_size, 2)` faz com que pontos mais próximos do centro tenham vermelhos mais intensos que os distantes. A condicão `int(TIME) % 2 == 0` faz com que a atualização só ocorra em segundos pares. Ou seja, atualiza uma vez a cada 2 segundos. Isso dá um efeito de luz vermelha de alerta. 

## Experimento 6

Agora que a mudança de sistema de coordenadas está entendida, vai ser mais fácil entender este shader e os seguintes. 

Primeiro o shader aumenta a escala da caixa ao multiplicar o UV por 2. Como queremos que este também fique centrado na origem, devemos subtrair tudo por 1. Novamente, calculamos a norma do vetor (distância ao centro da imagem). Agora fazemos algo diferente, subtraímos $-0.5$ deste valor. Isso significa que os pontos com distância $0.5$ ou menos do centro passam a ter uma distância fictícia que é menor ou igual a zero. Com isso, criamos uma região diferenciada de raio $0.5$ em torno do centro. Agora o shader aplica o valor absoluto nessa distância. O tratamento diferenciado muda, agora quanto mais próximos do centro, maior fica o valor da distância, indo de zero (na borda) até $0.5$ (no centro). Esse valor é usado para definir a cor `vec4(d, d, d, 1.0)`. 

<p align="center">
  <img width="480" src="https://github.com/user-attachments/assets/ad78828b-c844-474b-a0e8-c51a9419b95a" />
</p>

Como intepretamos isso? Primeiro note que, pelo fato das componentes da cor terem o mesmo valor, estamos trabalhando na escala de cinza. Pontos mais distantes são mais claros, tendendo ao branco. Conforme se aproximam da borda de distância $0.5$ do centro, vão escurecendo. Depois dessa borda houve uma inversão de intensidade por causa das manipulações discutidas acima. Então no centro temos o branco máximo e a cor vai escurecendo conforme o ponto se distancia do centro e se aproxima da borda de distância $0.5$ do centro. A figura resultante está mostrada abaixo para ajudar a visualizar o que está acontecendo.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/345425df-93e8-47e0-bb5e-5fbda1cba040" />
</p>

## Experimento 7

Este experimento é basicamente uma repetição do anterior, mas aplicando uma função extra antes de definir a cor nova. Esta função é a `step()`, que está definida no tutorial de [função do shader](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/Built-in%20functions#fun%C3%A7%C3%B5es-matem%C3%A1ticas). O comando `step(0.1, d)` é bem simples, se $0.1 > \texttt{d}$, retorna $0$, caso contrário retorna $1$. Ou seja, se `d` for pequeno o suficiente (menor que $0.1$), vira a cor preta, senão é cor branca. 

<p align="center">
  <img width="580" src="https://github.com/user-attachments/assets/e25651c1-40e8-468c-98e8-f878606dc63c" />
</p>

Em relação à imagem mostrada no experimento anterior, isso significa que ela será convertida para preto e branco, com o threshold de $0.1$ para definir o que é preto e o que é branco.

<p align="center">
  <img width="460" src="https://github.com/user-attachments/assets/31423b5f-76ec-4288-a6da-15d9ad14c844" />
</p>

## Experimento 8

Idêntico ao anterior, só foi alterado o tipo de função step. Nesse caso foi usada a função `smoothstep()`, que também está definida no tutorial de [função do shader](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/Built-in%20functions#fun%C3%A7%C3%B5es-matem%C3%A1ticas). Ela é parecida com a função `step()`, mas em vez de ter uma decisão booleana baseada em $0.1 > \texttt{d}$, temos o seguinte:

- $0$ quando $d <= 0.1$,
- $1$ quando $d >= 0.2$,
- Entre $0.1$ e $0.2$ faz uma transição suave.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/191aee57-b126-471d-b02a-b916566c68ff" />
</p>

Segue abaixo o resultado dessa mudança.

<p align="center">
  <img width="460" src="https://github.com/user-attachments/assets/a7fea77c-7ca1-485a-9635-8aa6edd9a6c1" />
</p>

## Experimento 9

Este experimento é uma continuação dos anteriores, agora incluindo o tempo no código. Quase sempre que um código usa o `TIME`, haverá animação. Esse é o caso agora.

Agora temos as variáveis `frequency = 5.0` e `speed = 1.5`, que são aplicadas na fórmula da distância `d = sin(d * frequency + TIME * speed)`. A frequência controla quantos círculos teremos e a velocidade controla a velocidade com que esses círculos se movem.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/2e1a3d99-0887-4faa-9f8f-9db4f7607aa8" />
</p>

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/261a6932-c0f7-4a2e-908e-8a8559c6687b" />
</p>

Neste experimento, eu fiz uma versão alternativa onde o comando `d = 0.05/d` é aplicado antes de atualizar a cor. Vale mencionar que valores negativos são "truncados" para $0$ na hora de calcular a cor, e valores maiores que $1$ são truncados para $1$. O efeito desta fórmula é deixar bem claro os escuros próximos de zero e escurecer os claros. Note que os pretos negativos se mantém pretos por convenção. O efeito final é a figura abaixo à esquerda.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/c86153cf-9323-49f9-9504-3e66a29ab94f" />
</p>

> PS: Essa regra pode acarretar em divisão por zero. Neste caso, a convenção do shader é que $\frac{0.05}{0.0} = + \inf$, o que é "truncado" para $1.0$.

## Experimento 10

Esse é quase o mesmo de antes. A diferença é que agora adicionamos uma paleta de cores. A fórmula dessa paleta não tem nada de especial é só uma bagunça mesmo. O interessante é o fato do `TIME` estar sendo usado como argumento de entrada na paleta. Isso significa que a cor agora não é apenas determinada pela distância, mas ela varia com o tempo. Isso deixa a animação com muito mais dinâmica. Recomendo testar esse experimento removendo o `TIME` na chamada `COLOR = vec4(palette(d + TIME * speed), 1.0)`.

<p align="center">
  <img width="590" src="https://github.com/user-attachments/assets/b03b2054-c318-4242-b9e0-c0753756dba1" />
</p>

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/3411db6d-9d34-4f42-a4e3-92b5f0228048" />
</p>

## Experimento 11

Pode-se dizer que o primeiro método avançado é o deste experimento. Vamos aprender como repetir a imagem múltiplas vezes na tela através do shader.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/2c149dc8-8fc5-403e-81cc-35c031ae84d7" />
</p>

Só o que muda neste código é o comando `uv = fract(uv)` que vem logo após definir `uv` e fazer a mudança do sistema de coordenadas (agora centrado na origem e indo de $(-1, -1)$ até $(1, 1)$. A função `fract()` retorna a parte fracionária do número (descarta sinal negativo também). Por exemplo, `fract(1.52) = 0.52`. 

Por exemplo, todos os 4 pontos $(1.52,\ y), (0.52,\ y), (-0.52,\ y), (-1.52,\ y)$ possuem a mesma cor, que é a cor do $(0.52,\ y)$. Como consequência, apenas o quadrante inferior direito $[0, 1) \times [0, 1)$ que importa, os outros só copiam deste. Daí sai o efeito de repetição de imagens.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/0bdf2140-8ff7-451d-b36b-7940d18e6dd0" />
</p>

## Experimento 12

No experimento anterior havia 4 blocos porque as únicas partes inteiras para serem descartadas eram os números $1, -1, 0, -0$. É totalmente possível aumentar a escala da UV por um fator maior e incluir mais inteiros. Isso vai gerar mais blocos da mesma imagem na tela. 

Se quisermos uma grid $3 \times 3$ de imagens repetidas, usamos $n = 3$ no código abaixo. Com isso, a mudança de escala vai gerar uma UV indo de $(0, 0)$ a $(3, 3)$. Neste caso, devemos subtrair por $1.5$ para deixar o centro na origem (sempre subtrair por $n/2$). Após isso, a função `fract()` vai gerar a grid $3 \times 3$ de imagens repetidas, como desejado.

Uma possível melhoria seria a de deixar o centro de cada bloco coincidindo com o centro do círculo, assim como era antes do experimento 11. Para isso, basta subtrair por $0.5$ que tudo está resolvido. Para entender o porquê, pense no bloco canônico do sistema UV, ele faz parte da grid. Todos os outros blocos copiam deste. Como esta bloco vai de $(0, 0)$ a $(1, 1)$ e o centro do círculo está no canto superior esquerdo, subtrair a coordenada $x$ e $y$ por $0.5$ vai levar aquele ponto para o centro do bloco. Com isso, esse bloco fica ajustado para o padrão que queremos. E como todos os outros blocos copiam deste, tudo fica corrigido.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/ca0d60b9-ade6-4669-b515-7ec67d208e3d" />
</p>

Um pequeno detalhe interessante mas que enriquece a animação é a variável `d0` no código. Antes da `fract()` ser chamada, esta variável armazena a distância original do pixel ao centro. Esse valor é usado na paleta para obter uma coloração baseada na distância original. Graças a isso, as cópias tem uma leve variação na coloração, o que acrescenta mais dinâmica à animação.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/dba44343-ef0d-4fc3-b2b1-f5531d096821" />
</p>

⚠️ **Atenção:** Apenas de ser possível atribuir um valor inicial ao uniform (como foi feito neste código), esse tipo de variável deve ser alterado pelo *Inspector*. Isso foi mencionado no [guia de referência](https://github.com/felipebottega/Games/blob/gh-pages/Manual/Shaders/Shading%20reference/Shading%20language/README.md#uniforms). Caso você tente alterar pelo código shader, não vai conseguir ver a mudança ocorrendo. Fique atento a isso.

## Experimento 13

Ainda continuando o experimento anterior, mas colocando um efeito extra. No código abaixo,a cada iteração do loop, temos um `uv` diferente, o que acarreta em estar repetindo	o padrão em outro ponto. Este comportamento repetido cria uma estrutura com aspectos fractais.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/8cff2ce5-e253-4f29-9e28-feeb482e3698" />
  <img width="400" src="https://github.com/user-attachments/assets/36435e27-3d1f-4469-886a-645fddef220c" />
</p>

## Experimento 14

Finalmente, o último experimento. Esse aqui é uma continuação do anterior. Apenas temos mais variáveis uniform para testar pelo *Inspector*, e agora alguns valores intermediários passam por mais funções matemáticas, com o intuito de obter efeitos novos. A partir daqui é questão de experimentação, não existe um caminho certo. 

Apenas vou deixar uma imagem de um frame da animação deste shader. Vale a pena conferir!

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/07157d78-14e8-4627-9c09-2acaec38d59d" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20second%202D%20shader">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Game%20of%20Life">Próximo ➡</a>
</p>
