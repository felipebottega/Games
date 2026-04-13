# Shading language

Godot usa uma linguagem de shader semelhante ao [GLSL ES 3.0](https://registry.khronos.org/OpenGL/specs/es/3.0/GLSL_ES_Specification_3.00.pdf) (API gráfica). A maioria dos tipos de dados e funções são suportados.

## Tipos de dados

| Tipo              | Descrição                                                                                         |
|------------------|---------------------------------------------------------------------------------------------------|
| void             | Tipo vazio, útil apenas para funções que não retornam valor.                                      |
| bool             | Tipo booleano, pode conter apenas true ou false.                                                   |
| bvec2            | Vetor de dois componentes booleanos.                                                              |
| bvec3            | Vetor de três componentes booleanos.                                                              |
| bvec4            | Vetor de quatro componentes booleanos.                                                            |
| int              | Inteiro escalar com sinal de 32 bits.                                                             |
| ivec2            | Vetor de dois inteiros com sinal.                                                                 |
| ivec3            | Vetor de três inteiros com sinal.                                                                 |
| ivec4            | Vetor de quatro inteiros com sinal.                                                               |
| uint             | Inteiro escalar sem sinal; não pode conter valores negativos.                                     |
| uvec2            | Vetor de dois inteiros sem sinal.                                                                 |
| uvec3            | Vetor de três inteiros sem sinal.                                                                 |
| uvec4            | Vetor de quatro inteiros sem sinal.                                                               |
| float            | Número escalar de ponto flutuante de 32 bits.                                                     |
| vec2             | Vetor de dois componentes de ponto flutuante.                                                     |
| vec3             | Vetor de três componentes de ponto flutuante.                                                     |
| vec4             | Vetor de quatro componentes de ponto flutuante.                                                   |
| mat2             | Matriz 2x2, em ordem de colunas (column-major).                                                   |
| mat3             | Matriz 3x3, em ordem de colunas (column-major).                                                   |
| mat4             | Matriz 4x4, em ordem de colunas (column-major).                                                   |
| sampler2D        | Tipo sampler para texturas 2D, lidas como valores float.                                          |
| isampler2D       | Tipo sampler para texturas 2D, lidas como inteiros com sinal.                                     |
| usampler2D       | Tipo sampler para texturas 2D, lidas como inteiros sem sinal.                                     |
| sampler2DArray   | Tipo sampler para arrays de texturas 2D, lidas como float.                                        |
| isampler2DArray  | Tipo sampler para arrays de texturas 2D, lidas como inteiros com sinal.                           |
| usampler2DArray  | Tipo sampler para arrays de texturas 2D, lidas como inteiros sem sinal.                           |
| sampler3D        | Tipo sampler para texturas 3D, lidas como float.                                                  |
| isampler3D       | Tipo sampler para texturas 3D, lidas como inteiros com sinal.                                     |
| usampler3D       | Tipo sampler para texturas 3D, lidas como inteiros sem sinal.                                     |
| samplerCube      | Tipo sampler para Cubemaps, lidos como float.                                                     |
| samplerCubeArray | Tipo sampler para arrays de Cubemaps, lidos como float. Suportado apenas em Forward+ e Mobile.    |
| samplerExternalOES | Tipo sampler externo. Suportado apenas na plataforma Android (modo Compatibility).              |

> PS: O *sampler* é uma interface especial da GPU pra leitura de textura. Ele não é a textura em si, é tipo um acesso à textura.

⚠️ **Atenção:** As variáveis ​​locais não são inicializadas com um valor padrão, como $0.0$. Se você usar uma variável sem atribuir um valor a ela primeiro, ela vai inicializar com qualquer valor que já estiver presente naquele endereço de memória, e falhas visuais imprevisíveis poderão aparecer. No entanto, as variáveis ​​`uniform` (veremos adiante) ​​são inicializadas com um valor padrão.

### Comentários

A linguagem de shader suporta a mesma sintaxe de comentários usada em glsl e C++, usando `//` para comentários de linha única e `/* */` para comentários de várias linhas.

```glsl
// Single-line comment.
int a = 2;  // Another single-line comment.

/*
Multi-line comment.
The comment ends when the ending delimiter is found
(here, it's on the line below).
*/
int b = 3;
```

Você pode usar comentários de documentação que são exibidos no *Inspector* ao passar o mouse sobre um parâmetro de shader. Os comentários de documentação são suportados atualmente apenas quando colocados imediatamente acima de uma declaração de `uniform`. Esses comentários de documentação suportam apenas a sintaxe de comentário multilinha (mesmo se usados ​​em uma única linha) e devem começar com dois asteriscos (/**) em vez de apenas um (/*).

```glsl
/**
 * This is a documentation comment.
 * These lines will appear in the inspector when hovering the shader parameter
 * named "Something".
 * You can use [b]BBCode[/b] [i]formatting[/i] in the comment.
 */
uniform int something = 1;

/** This is a single-line documentation comment. */
uniform float something_else = 1.0;
```

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/dcf9d941-1b9e-4b6c-b99e-c2149cca29c5" />
  <img width="1100" src="https://github.com/user-attachments/assets/7473e66b-6c28-4a7d-b80a-508cc7ee418b" />
</p>

### Casting

O casting é semelhante ao Python, mas um pouco mais rígido.

```glsl
float a = 2; // invalid
float a = 2.0; // valid
float a = float(2); // valid
```

Inteiros por padrão sempre são com sinal, portanto, é sempre necessário fazer um cast para convertê-los em `uint`.

```glsl
int a = 2; // valid
uint a = 2; // invalid
uint a = uint(2); // valid
```

### Elementos de vetores e matrizes

Os membros escalares individuais de tipos vetoriais são acessados ​​através dos membros `x`, `y`, `z` e `w`. Alternativamente, usar `r`, `g`, `b` e `a` também funciona e é equivalente. Use o que melhor se adequar às suas necessidades.

Para matrizes, use a sintaxe de indexação `m[coluna][linha]` para acessar cada escalar, ou `m[coluna]` para acessar um vetor por coluna. Por exemplo, para acessar a componente $y$ da quarta coluna de uma matriz `m` (4ª coluna, 2ª linha), você usa `m[3][1]` ou `m[3].y`.

### Construção de vetores e matrizes

Para construir um vetor, você deve sempre passar os valores, mas há diversas maneiras válidas de se fazer isso.

```glsl
vec4 a = vec4(0.0, 1.0, 2.0, 3.0); // (0.0, 1.0, 2.0, 3.0)
vec4 a = vec4(vec2(0.0, 1.0), vec2(2.0, 3.0)); // (0.0, 1.0, 2.0, 3.0)
vec4 a = vec4(vec3(0.0, 1.0, 2.0), 3.0); // (0.0, 1.0, 2.0, 3.0)
vec4 a = vec4(0.0); // (0.0, 0.0, 0.0, 0.0)
```

A construção de tipos de matrizes requer vetores da mesma dimensão da matriz, interpretados como colunas. Você também pode construir uma matriz diagonal usando a sintaxe `matx(float)`. Assim, `mat4(1.0)` é uma matriz identidade.

```glsl
mat2 m2 = mat2(vec2(1.0, 0.0), vec2(0.0, 1.0));
mat3 m3 = mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0), vec3(0.0, 0.0, 1.0));
mat4 identity = mat4(1.0);
```

Matrizes também podem ser construídas a partir de uma matriz de outra dimensão. Se uma matriz maior for construída a partir de uma matriz menor, as linhas e colunas adicionais assumem os valores que teriam em uma matriz identidade. Se uma matriz menor for construída a partir de uma matriz maior, a submatriz superior esquerda da matriz maior é utilizada.

```glsl
// Pega a matriz 4x4 (MODEL_MATRIX) e extrai a submatriz superior esquerda 3x3
// Ou seja, descarta a última linha e última coluna
//
// Se MODEL_MATRIX fosse:
//
// [ a b c d ]
// [ e f g h ]
// [ i j k l ]
// [ m n o p ]
//
// Então basis vira:
//
// [ a b c ]
// [ e f g ]
// [ i j k ]
mat3 basis = mat3(MODEL_MATRIX);

// Constrói uma 4x4 a partir da 3x3
// A parte 3x3 é preservada, e o resto vira identidade
//
// Resultado:
//
// [ a b c 0 ]
// [ e f g 0 ]
// [ i j k 0 ]
// [ 0 0 0 1 ]
mat4 m4 = mat4(basis);

// Pega a submatriz superior esquerda 2x2 da 4x4
//
// Resultado:
//
// [ a b ]
// [ e f ]
mat2 m2 = mat2(m4);
```

> PS: `MODEL_MATRIX` é uma variável built-in (interna do shader), fornecida pela engine. É uma matriz que transforma coordenadas do espaço local do objeto para o espaço de mundo.

### Swizzling

É possível obter qualquer combinação de componentes em qualquer ordem, desde que o resultado seja outro tipo de vetor (ou escalar). Isso é mais fácil de demonstrar do que de explicar.

```glsl
vec4 a = vec4(0.0, 1.0, 2.0, 3.0);
vec3 b = a.rgb; // Creates a vec3 with vec4 components.
vec3 b = a.ggg; // Also valid; creates a vec3 and fills it with a single vec4 component.
vec3 b = a.bgr; // "b" will be vec3(2.0, 1.0, 0.0).
vec3 b = a.xyz; // Also rgba, xyzw are equivalent.
vec3 b = a.stp; // And stpq (for texture coordinates).
float c = b.w; // Invalid, because "w" is not present in vec3 b.
vec3 c = b.xrt; // Invalid, mixing different styles is forbidden.
b.rrr = a.rgb; // Invalid, assignment with duplication.
b.bgr = a.rgb; // Valid assignment. "b"'s "blue" component will be "a"'s "red" and vice versa.
```

## Arrays

Arrays em shaders são containers para dados de tipo similar. Veremos a seguir como funciona.

### Arrays locais

Arrays locais são declarados em funções (como a função `vertex()` ou `fragment()`). Eles podem usar todos os tipos de dados permitidos, exceto os samplers. A sintaxe é no estilo de C.

```glsl
void fragment() {
    float arr[3];
    float float_arr[3] = float[3] (1.0, 0.5, 0.0);
    int int_arr[3] = int[] (2, 1, 0);
    vec2 vec2_arr[3] = {vec2(1.0, 1.0), vec2(0.5, 0.5), vec2(0.0, 0.0)};
    bool bool_arr[] = {true, true, false}; // size is defined automatically from the element count
}
```

O comando `float arr[3]` define um array de tipo `float` e tamanho de 3 elementos. O comando `float[3] (1.0, 0.5, 0.0)` é um "construtor", ele cria um array `float` com as entradas `(1.0, 0.5, 0.0)`. Este array por si só não é nenhuma variável, é só um array "voando" no código. Ele passa a ser uma variável com a declaração `float arr[3] = float[3] (1.0, 0.5, 0.0)`. Isso é equivalente à `float arr[3] = {1.0, 0.5, 0.0}`, inclusive esse segundo comando é o mais usual.

Você pode declarar vários arrays (mesmo com tamanhos diferentes) em uma única expressão. Neste caso o `float` vale para todas as declarações.

```glsl
float a[3] = float[3] (1.0, 0.5, 0.0), b[2] = {1.0, 0.5}, c[] = {0.7}, d = 0.0, e[5];
```

Se quiser mais legibilidade, pode usar quebra de linha com indentação. É importante ficar atento pois indentação não é uma coisa obrigatória nessa linguagem. Então é a vírgula como separador que vai indicar se os elementos são da mesma expressão ou não. Quando a expressão termina, se indica isso com o ponto-vírgula (;).

```glsl
float a[3] = float[3] (1.0, 0.5, 0.0),
    b[2] = {1.0, 0.5},
    c[] = {0.7},
    d = 0.0,
    e[5];
```

Para acessar um elemento de um array, utilize a sintaxe de indexação.

```glsl
float arr[3];

arr[0] = 1.0;

COLOR.r = arr[0]; 
```

Arrays também possuem a função `.length()`. Ela não aceita nenhum parâmetro e retorna o tamanho do array. 

```glsl
float arr[3];

int n = arr.length();
```

É importante ressaltar que `arr.length()` é apenas um atalho de sintaxe para acessar esta função. Não existem classes e objetos no contexto de shaders.

### Arrays globais

Você pode declarar arrays globais declarando como `const` ou `uniform`.

```glsl
shader_type canvas_item;

const vec3 v[1] = vec3[1] (vec3(0, 0, 1));
uniform vec3 w[1];

void fragment() {
  COLOR = vec4(v[0] + w[0], 1.0);
}
```

## Constantes

Use a keyword `const` antes da declaração da variável para torná-la imutável, o que significa que ela não pode ser modificada. Todos os tipos básicos, exceto os samplers, podem ser declarados como constantes. Acessar e usar um valor constante é ligeiramente mais rápido do que usar um valor `uniform`. As constantes devem ser inicializadas para algum valor no momento da declaração. Você pode declarar constantes no escopo global ou dentro de funções.

```glsl
const vec2 a = vec2(0.0, 1.0);
vec2 b;

a = b; // invalid
b = a; // valid
```

Múltiplas constantes podem ser declaradas de uma vez.

```glsl
const vec2 V1 = vec2(1, 1), V2 = vec2(2, 2);
```

Arrays também podem ser constantes.

```glsl
const float arr[] = {1.0, 0.5, 0.0};

arr[0] = 1.0; // invalid

COLOR.r = arr[0]; // valid
```

## Structs

Structs são parecidos com dicionários, mas possuem tamanho fixo e nomes fixos. Eles são usados para agrupar variáveis relacionadas em shaders. Você pode declarar um struct no escopo global como mostra o exemplo abaixo.

```glsl
struct PointLight {
    vec3 position;
    vec3 color;
    float intensity;
};
```

Depois é possível instanciá-lo nas funções.

```glsl
void fragment(){
    PointLight light;
    light.position = vec3(0.0);
    light.color = vec3(1.0, 0.0, 0.0);
    light.intensity = 0.5;
}
```

A ordem dos elementos importa na definição de um struct (outra diferença entre dicionários). Você pode usar isso para instanciar um struct através de um construtor, de maneira análoga ao construtor de classes.

```glsl
struct PointLight {vec3 position; vec3 color; float intensity;}; // Initializing the struct on a single line to highlight the order of the elements.

void fragment() {
    PointLight light = PointLight(vec3(0.0), vec3(1.0, 0.0, 0.0), 0.5);
}
```

## Operadores

| Precedência      | Classe                     | Operadores           |
|------------------|----------------------------|----------------------|
| 1 (mais alta)    | agrupamento com parênteses | `()`                 |
| 2                | unário                     | `+`, `-`, `!`, `~`   |
| 3                | multiplicativo             | `/`, `*`, `%`        |
| 4                | aditivo                    | `+`, `-`             |
| 5                | deslocamento bit a bit     | `<<`, `>>`           |
| 6                | relacional                 | `<`, `>`, `<=`, `>=` |
| 7                | igualdade                  | `==`, `!=`           |
| 8                | E bit a bit (AND)          | `&`                  |
| 9                | OU exclusivo bit a bit     | `^`                  |
| 10               | OU inclusivo bit a bit     | `\|`                 |
| 11               | AND lógico                 | `&&`                 |
| 12 (mais baixa)  | OU lógico inclusivo        | `\|\|`               |

## Controle de fluxo

A linguagem de shaders suporta os tipos mais comuns de controle de fluxo. Note que o `switch` funciona como o `match` de GDScript (mas o `match` é mais poderoso).

```glsl
// `if`, `else if` and `else`.
if (cond) {
}
else if (other_cond) {
}
else {
}

// Ternary operator.
// If `cond` evaluates to `true`, `result` will be `9`. Otherwise, `result` will be `5`.
int result = cond ? 9 : 5;

// `switch`.
switch (i) { // `i` should be a signed integer expression.
    case -1:
        break;
    case 0:
        return; // `break` or `return` to avoid running the next `case`.
    case 1: // Fallthrough (no `break` or `return`): will run the next `case`.
    case 2:
        break;
    //...
    default: // Only run if no `case` above matches. Optional.
        break;
}

// `for` loop. Best used when the number of elements to iterate on
// is known in advance.
for (int i = 0; i < 10; i++) {
}

// `while` loop. Best used when the number of elements to iterate on is not known in advance.
while (cond) {
}

// `do while`. Like `while`, but always runs at least once even if `cond` never evaluates to `true`.
do {
} while (cond);
```

⚠️ **Atenção:**
1. Lembre-se de que, em GPUs modernas, um loop infinito pode ocorrer e congelar seu aplicativo (incluindo o editor). O Godot não pode protegê-lo disso, portanto, tome cuidado para não cometer esse erro!
2. Ao comparar valores de ponto flutuante com um número, certifique-se de compará-los com um intervalo em vez de um número exato. Por exemplo, uma comparação como `if (value == 0.3)` pode não resultar em verdadeiro. A matemática de ponto flutuante geralmente é aproximada e pode desafiar as expectativas. Ela também pode se comportar de maneira diferente dependendo do hardware. Uma maneira mais segura seria usar `if (value >= 0.3 - 0.0001 && value <= 0.3 + 0.0001)`.

## Descarte

É possível usar a keyword `discard` nas funções `fragment()` e `light()`. Se usada, o pixel é descartado e nada é gravado. Tenha cuidado, pois um pixel descartado ainda precisa ser renderizado no vertex shader, o que significa que um shader que usa `discard` em todos os seus pixels ainda é mais custoso de renderizar do que não renderizar nenhum objeto.

## Funções

Além das [funções de processamento](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Introduction%20to%20shaders#processor-functions), também é possível definir as suas próprias funções no shader da Godot. Elas usam a sintaxe mostrada abaixo.

```glsl
return_type func_name(args) {
    return return_type; // if returning a value
}
```

Um exemplo concreto é a função definida abaixo. 

```glsl
int sum2(int a, int b) {
    return a + b;
}
```

Você só pode usar funções que foram definidas acima (mais acima no editor). Os argumentos de entrada da função podem ter qualificadores especiais.

- **in:** Significa que o argumento é apenas para leitura (padrão).
- **out:** Significa que o argumento é apenas para escrita.
- **inout:** Significa que o argumento é totalmente passado por referência.
- **const:** Significa que o argumento é uma constante e não pode ser alterado. pode ser combinado com o qualificador *in*.

Um exemplo concreto de aplicação de qualificadores. Neste exemplo, `result` não é um valor "normal" recebido pela função. Ele é um parâmetro de saída por referência. Isso significa que a função recebe acesso à mesma variável `result` que existe fora dela. Quando a função faz `result = a + b;`, ela está alterando a variável externa diretamente. Devolve um valor sem usar return.

```glsl
void sum2(int a, int b, inout int result) {
    result = a + b;
}
```

Uma vantagem do quaificador por referência, é que o código fica mais limpo e se evita criar cópias dentro da função. Sem isso, poderíamos ter um bloco de código assim:

```glsl
color = process1(color);
color = process2(color);
color = process3(color);
```

Porém, com o qualificador o código pode ser assim:

```glsl
process1(color);
process2(color);
process3(color);
```

## Variáveis interpoladas (Varyings)

Não existe uma tradução óbvia para "varyings", não que eu tenha encontrado. O melhor que temos é "variáveis interpoladas" e vamos seguir com isso. 

Para enviar dados da função de processamento `vertex()` para a `fragment()` ou `light()`, utilizam-se *variáveis interpoladas*. Esses valores são definidos para cada vértice na função `vertex()`, e são interpolados para cada pixel na função `fragment()` ou `light()`.

No exemplo abaixo, está acontecendo o seguinte: `vertex()` roda uma vez por vértice do primitivo 2D. Ali você pega um valor e guarda em `some_color`. Depois a GPU interpola esse valor automaticamente entre os vértices para cada pixel, é exatamente esse o papel de *variáveis interpoladas*. `fragment()` roda para cada pixel desenhado e escreve a cor final em `COLOR`, que é a saída do shader 2D. A iluminação 2D acontece no passe normal de desenho. Se você definir `light()`, ele substitui a função de luz padrão. `LIGHT` é a cor de saída para a classe `Light2D` na Godot. 

```glsl
shader_type canvas_item;

varying vec3 some_color;

void vertex() {
    some_color = vec3(UV, 0.0);
}

void fragment() {
    COLOR = vec4(some_color, 1.0);
}

void light() {
    LIGHT = vec4(some_color * 100.0, 1.0); // opcional
}
```

> PS: O "primitivo 2D" é a forma geométrica básica que está sendo desenhada. No contexto do `canvas_item`, isso pode ser um retângulo (`Sprite2D`, `TextureRect`, etc.), um polígono (`Polygon2D`) ou qualquer malha 2D desenhada.

Essa funcionalidade é bastante usada. Existe uma separação rígida no pipeline: `vertex()` roda nos vértices e `fragment()` roda nos pixels, mas um não enxerga as variáveis locais do outro. *Variáveis interpoladas* é literalmente o único canal padrão pra levar dados de um pro outro.

### Variáveis interpoladas como arrays

*Variável interpolada* não precisam ser só uma variável única. Ele pode ser um vetor, uma cor, ou até um array. No exemplo, o valor é definido no `vertex()` e depois lido no `fragment()`.

```glsl
shader_type canvas_item;

varying float var_arr[3];

void vertex() {
    var_arr[0] = 1.0;
    var_arr[1] = 0.0;
    var_arr[2] = 0.0;
}

void fragment() {
    COLOR = vec4(var_arr[0], var_arr[1], var_arr[2], 1.0);
}
```

### Passar dados do fragment() para light()

O `fragment()` prepara um valor para o `light()` usar depois. Ou seja, você calcula algo na cor base e reaproveita isso na iluminação 2D.

```glsl
shader_type canvas_item;

varying vec3 some_light;

void fragment() {
    some_light = COLOR.rgb * 100.0;
}

void light() {
    LIGHT = vec4(some_light, 1.0);
}
```

### Onde não pode atribuir variável interpolada

Você só pode escrever em *variável interpolada* em certos lugares do pipeline, como `vertex()` ou `fragment()`. Não pode fazer isso em funções auxiliares nem em `light()`.

```glsl
shader_type canvas_item;

varying float test;

void foo() {
    test = 0.0; // erro
}

void vertex() {
    test = 0.0;
}

void light() {
    test = 0.0; // erro
}
```

## Qualificadores de interpolação

Certos valores são interpolados durante o pipeline de renderização. Você pode alterar a forma como essa interpolação acontece usando qualificadores de interpolação.

Os *qualificadores de interpolação* controlam como os valores da *variável interpolada* são distribuídas entre os pixels. O default é o *smooth*. A GPU interpola suavemente os valores entre os vértices, criando transições como gradientes. A outra opção é a *flat*. Não há interpolação, e um único valor é usado para toda a área. Embora seja importante entender que essa interpolação existe, na prática você quase nunca precisa alterar esse comportamento, usando *flat* apenas em casos específicos onde os valores não podem ser misturados.

```glsl
shader_type canvas_item;

varying flat vec3 our_color;

void vertex() {
    our_color = COLOR.rgb;
}

void fragment() {
    COLOR = vec4(our_color, 1.0);
}
```

Existem dois qualificadores possíveis:

| Qualificador | Descrição                                                                   |
| ------------ | --------------------------------------------------------------------------- |
| `flat`       | O valor **não é interpolado**.                                              |
| `smooth`     | O valor é interpolado de forma compatível com perspectiva. Este é o default. |

## Uniforms

É possível passar valores externas para o shader usando *uniforms*, que são definidos no escopo global do shader, fora de qualquer função. Quando o shader é atribuído a um material, esses uniforms aparecem como parâmetros editáveis no inspetor do material. Uniforms não podem ser modificados de dentro do shader. Você pode definir uniforms no editor, no *Inspector* de materiais. Alternativamente, você pode defini-los por meio de código.

Por exemplo, você pode declarar uma variável `uniform` no escopo global, como mostrado abaixo.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/f52fd15b-7836-4d93-b057-6fecd4b1a642" />
</p>

Automaticamente, esta variável ficará disponível no *Inspector* de materiais. A partir daí você pode alterar o valor pelo *Inspector* e ver em tempo real como ele afeta a imagem.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/05da628f-2963-4dab-9042-7cd44e9b633a" />
</p>

### Uniform hints

O que se chama de "uniform hints" são keywords especiais para o *Inspector* disponibilizar mais ferramentas para a edição de valor.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/221bc6c2-dff2-48f5-8521-2909526f898e" />
  <img width="350" src="https://github.com/user-attachments/assets/d4d26836-b704-4717-8c7c-1a66ef654d8c" />
</p>

Segue a lista completa abaixo.

| Tipo | Hint | Descrição |
|------|------|------|
| `vec3`, `vec4` | `source_color` | Usado como cor. |
| `int` | `hint_enum("String1", "String2")` | Exibe o valor inteiro como um menu dropdown no editor. |
| `int`, `float` | `hint_range(min, max[, step])` | Restringe os valores a um intervalo (com mínimo/máximo/passo). |
| `sampler2D` | `source_color` | Usado como cor base (albedo). |
| `sampler2D` | `hint_normal` | Usado como mapa de normais. |
| `sampler2D` | `hint_default_white` | Como valor ou cor base, o padrão é branco opaco. |
| `sampler2D` | `hint_default_black` | Como valor ou cor base, o padrão é preto opaco. |
| `sampler2D` | `hint_default_transparent` | Como valor ou cor base, o padrão é preto transparente. |
| `sampler2D` | `hint_anisotropy` | Usado como mapa de fluxo, com padrão apontando para a direita. |
| `sampler2D` | `hint_roughness[_r, _g, _b, _a, _normal, _gray]` | Usado para limitar a rugosidade na importação (reduz aliasing especular). `_normal` usa um mapa de normais para guiar a rugosidade, aumentando em áreas com muitos detalhes. |
| `sampler2D` | `filter[_nearest, _linear][_mipmap][_anisotropic]` | Ativa o tipo de filtragem de textura especificado. |
| `sampler2D` | `repeat[_enable, _disable]` | Ativa ou desativa a repetição da textura. |
| `sampler2D` | `hint_screen_texture` | A textura é a textura da tela. |
| `sampler2D` | `hint_depth_texture` | A textura é a textura de profundidade. |
| `sampler2D` | `hint_normal_roughness_texture` | A textura é de normais + rugosidade (suportado apenas em Forward+). |

### Usando source_color

Texturas de imagem (PNG, JPG) normalmente estão em sRGB, enquanto o shader trabalha em linear. Sem correção, as cores ficam erradas. O `source_color` diz ao shader que aquela textura é de cor, aplicando a conversão correta. Use em albedo ou sprites. Não use em normal map, roughness, metallic, etc.

> PS: sRGB é um padrão de como cores são armazenadas e exibidas em imagens digitais.

### Uniform groups

Para agrupar vários uniforms em um grupo no *Inspector*, você pode usar a keyword `group_uniform`. Primeiro você inicia o bloco com `group_uniforms {MyGroupName}`, coloca os uniforms dentro do bloco, e depois o o fecha com `group_uniforms`.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/0c120479-042e-4841-b3e6-7dddd6ed7aef" />
  <img width="360" src="https://github.com/user-attachments/assets/3fda262f-1248-4af1-85db-cd00151b9789" />
</p>

### Global uniforms

Às vezes, você deseja modificar um parâmetro em vários shaders diferentes simultaneamente. Com um uniform comum, isso exige muito trabalho, pois todos esses shaders precisam ser rastreados e o uniform precisa ser definido para cada um deles. Uniforms globais permitem criar e atualizar uniforms que estarão disponíveis em todos os shaders, em todos os tipos de shader.

> PS: Falamos anteriormente que uniforms são globais no escopo do shader, ou seja, só para um código de shader em específico. O uniform global que estamos tratando nesta seção vai além disso, ele vale para todos os shaders do projeto.

Para criar um shader global, vá em *Project → Project Settings → Globals → Shader Globals*, escolha um nome para o seu uniform global, escolha o tipo, e clique em *+Add*.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/78d743e5-254d-40a9-967b-dfb9653a1a1f" />
</p>
