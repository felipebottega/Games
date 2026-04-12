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

A linguagem de shader suporta a mesma sintaxe de comentários usada em C# e C++, usando `//` para comentários de linha única e `/* */` para comentários de várias linhas.

```c#
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

```c#
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

```c#
float a = 2; // invalid
float a = 2.0; // valid
float a = float(2); // valid
```

Inteiros por padrão sempre são com sinal, portanto, é sempre necessário fazer um cast para convertê-los em `uint`.

```c#
int a = 2; // valid
uint a = 2; // invalid
uint a = uint(2); // valid
```

### Elementos de vetores e matrizes

Os membros escalares individuais de tipos vetoriais são acessados ​​através dos membros `x`, `y`, `z` e `w`. Alternativamente, usar `r`, `g`, `b` e `a` também funciona e é equivalente. Use o que melhor se adequar às suas necessidades.

Para matrizes, use a sintaxe de indexação `m[coluna][linha]` para acessar cada escalar, ou `m[coluna]` para acessar um vetor por coluna. Por exemplo, para acessar a componente $y$ da quarta coluna de uma matriz `m` (4ª coluna, 2ª linha), você usa `m[3][1]` ou `m[3].y`.

### Construção de vetores e matrizes

Para construir um vetor, você deve sempre passar os valores, mas há diversas maneiras válidas de se fazer isso.

```c#
vec4 a = vec4(0.0, 1.0, 2.0, 3.0); // (0.0, 1.0, 2.0, 3.0)
vec4 a = vec4(vec2(0.0, 1.0), vec2(2.0, 3.0)); // (0.0, 1.0, 2.0, 3.0)
vec4 a = vec4(vec3(0.0, 1.0, 2.0), 3.0); // (0.0, 1.0, 2.0, 3.0)
vec4 a = vec4(0.0); // (0.0, 0.0, 0.0, 0.0)
```

A construção de tipos de matrizes requer vetores da mesma dimensão da matriz, interpretados como colunas. Você também pode construir uma matriz diagonal usando a sintaxe `matx(float)`. Assim, `mat4(1.0)` é uma matriz identidade.

```c#
mat2 m2 = mat2(vec2(1.0, 0.0), vec2(0.0, 1.0));
mat3 m3 = mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0), vec3(0.0, 0.0, 1.0));
mat4 identity = mat4(1.0);
```

Matrizes também podem ser construídas a partir de uma matriz de outra dimensão. Se uma matriz maior for construída a partir de uma matriz menor, as linhas e colunas adicionais assumem os valores que teriam em uma matriz identidade. Se uma matriz menor for construída a partir de uma matriz maior, a submatriz superior esquerda da matriz maior é utilizada.

```c#
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

```c#
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
