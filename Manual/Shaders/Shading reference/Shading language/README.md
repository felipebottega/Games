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

## Comentários

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
