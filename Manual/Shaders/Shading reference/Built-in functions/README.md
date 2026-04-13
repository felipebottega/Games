# Built-in functions

O shader da Godot suporta muitas funções em conformidade com o GLSL. A quantidade de funções disponíveis é enorme, então vou listar aqui apenas as que eu costumo usar mais. Recomendo ler a [documentação oficial](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/shader_functions.html) para ver a lista completa.

## Nomenclatura

A documentação do GLSL usa alias para certos conjuntos de variáveis. Isto é para evitar repetição de declaração de função por causa de tipos diferentes, porém semelhantes. Deixamos abaixo a tabela geral. Estaremos usando esses aliases nas descrições das funções aqui também.

| alias            | actual types                                        | glsl documentation alias |
|------------------|-----------------------------------------------------|----------------------------|
| `vec_type`       | `float`, `vec2`, `vec3`, `vec4`                     | `genType`                  |
| `vec_int_type`   | `int`, `ivec2`, `ivec3`, `ivec4`                    | `genIType`                 |
| `vec_uint_type`  | `uint`, `uvec2`, `uvec3`, `uvec4`                   | `genUType`                 |
| `vec_bool_type`  | `bool`, `bvec2`, `bvec3`, `bvec4`                   | `genBType`                 |
| `mat_type`       | `mat2`, `mat3`, `mat4`                              | `mat`                      |
| `gvec4_type`     | `vec4`, `ivec4`, `uvec4`                            | `gvec4`                    |
| `gsampler2D`     | `sampler2D`, `isampler2D`, `uSampler2D`             | `gsampler2D`               |
| `gsampler2DArray`| `sampler2DArray`, `isampler2DArray`, `uSampler2DArray` | `gsampler2DArray`       |
| `gsampler3D`     | `sampler3D`, `isampler3D`, `uSampler3D`             | `gsampler3D`               |

Muitas funções aceitam um ou mais vetores/matrizes como argumentos. Na maior parte dos casos, a função fará a computação *component-wise*, isto é, vai aplicar a função elemento por elemento. As exceções são as operações óbvias como multiplicação entre matrizes, multiplicação entre matriz e vetor, etc. Segue abaixo alguns exemplos concretos para ajudar no entendimento.

| Operação                                 | Operação escalar equivalente                                   |
|------------------------------------------|----------------------------------------------------------------|
| `sqrt(vec2(4, 64))`                      | `vec2(sqrt(4), sqrt(64))`                                      |
| `min(vec2(3, 4), 1)`                     | `vec2(min(3, 1), min(4, 1))`                                   |
| `min(vec3(1, 2, 3), vec3(5, 1, 3))`      | `vec3(min(1, 5), min(2, 1), min(3, 3))`                        |
| `pow(vec3(3, 8, 5), 2)`                  | `vec3(pow(3, 2), pow(8, 2), pow(5, 2))`                        |
| `pow(vec3(3, 8, 5), vec3(1, 2, 4))`      | `vec3(pow(3, 1), pow(8, 2), pow(5, 4))`                        |

## Funções matemáticas

| Tipo de Retorno | Função                         | Descrição / Valor retornado              |
|-----------------|--------------------------------|------------------------------------------|
| `vec_type`      | `radians(vec_type degrees)`    | Converte graus para radianos.            |
| `vec_type`      | `degrees(vec_type radians)`    | Converte radianos para graus.            |
| `vec_type`      | `sin(vec_type x)`              | Seno.                                    |
| `vec_type`      | `cos(vec_type x)`              | Cosseno.                                 |
| `vec_type`      | `tan(vec_type x)`              | Tangente.                                |
| `vec_type`      | `pow(vec_type x, vec_type y)`                                          | Potência (indefinido se x < 0 ou se x == 0 e y <= 0).            |
| `vec_type`      | `exp(vec_type x)`                                                      | Exponencial de base e.                                           |
| `vec_type`      | `exp2(vec_type x)`                                                     | Exponencial de base 2.                                           |
| `vec_type`      | `log(vec_type x)`                                                      | Logaritmo natural (base e).                                      |
| `vec_type`      | `log2(vec_type x)`                                                     | Logaritmo de base 2.                                             |
| `vec_type`      | `sqrt(vec_type x)`                                                     | Raiz quadrada.                                                   |
| `vec_type`      | `inversesqrt(vec_type x)`                                              | Inverso da raiz quadrada.                                        |
| `vec_type`      | `abs(vec_type x)`                                                      | Valor absoluto (retorna positivo se for negativo).               |
| `vec_int_type`  | `abs(vec_int_type x)`                                                  | Valor absoluto (retorna positivo se for negativo).               |
| `vec_type`      | `sign(vec_type x)`                                                     | Retorna 1.0 se positivo, -1.0 se negativo, 0.0 caso contrário.   |
| `vec_int_type`  | `sign(vec_int_type x)`                                                 | Retorna 1 se positivo, -1 se negativo, 0 caso contrário.         |
| `vec_type`      | `floor(vec_type x)`                                                    | Arredonda para baixo.                                            |
| `vec_type`      | `round(vec_type x)`                                                    | Arredonda para o inteiro mais próximo.                           |
| `vec_type`      | `trunc(vec_type x)`                                                    | Truncamento.                                                     |
| `vec_type`      | `ceil(vec_type x)`                                                     | Arredonda para cima.                                             |
| `vec_type`      | `fract(vec_type x)`                                                    | Parte fracionária (retorna x - floor(x)).                        |
| `vec_type`      | `mod(vec_type x, vec_type y)`                                          | Módulo (resto da divisão).                                       |
| `vec_type`      | `modf(vec_type x, out vec_type i)`                                     | Parte fracionária de x, com i como parte inteira.                |
| `vec_type`      | `min(vec_type a, vec_type b)`                                          | Menor valor entre a e b.                                         |
| `vec_type`      | `min(vec_type a, float b)`                                             | Menor valor entre a e b.                                         |
| `vec_int_type`  | `min(vec_int_type a, vec_int_type b)`                                  | Menor valor entre a e b.                                         |
| `vec_int_type`  | `min(vec_int_type a, int b)`                                           | Menor valor entre a e b.                                         |
| `vec_uint_type` | `min(vec_uint_type a, vec_uint_type b)`                                | Menor valor entre a e b.                                         |
| `vec_uint_type` | `min(vec_uint_type a, uint b)`                                         | Menor valor entre a e b.                                         |
| `vec_type`      | `max(vec_type a, vec_type b)`                                          | Maior valor entre a e b.                                         |
| `vec_type`      | `max(vec_type a, float b)`                                             | Maior valor entre a e b.                                         |
| `vec_int_type`  | `max(vec_int_type a, vec_int_type b)`                                  | Maior valor entre a e b.                                         |
| `vec_int_type`  | `max(vec_int_type a, int b)`                                           | Maior valor entre a e b.                                         |
| `vec_uint_type` | `max(vec_uint_type a, vec_uint_type b)`                                | Maior valor entre a e b.                                         |
| `vec_uint_type` | `max(vec_uint_type a, uint b)`                                         | Maior valor entre a e b.                                         |
| `vec_bool_type` | `isnan(vec_type x)`                                                    | Retorna true se algum componente for NaN.                        |
| `vec_bool_type` | `isinf(vec_type x)`                                                    | Retorna true se algum componente for infinito (INF).             |

## 
