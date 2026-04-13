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
| `vec_type`      | `max(vec_type a, vec_type b)`                                          | Maior valor entre a e b.                                         |
| `vec_bool_type` | `isnan(vec_type x)`                                                    | Retorna true se algum componente for NaN.                        |
| `vec_bool_type` | `isinf(vec_type x)`                                                    | Retorna true se algum componente for infinito (INF).             |

> PS: As funções `min` e `max` na verdade valem para muitos outros tipos, mas deixamos apenas o `vec_type` na lista para evitar repetições.

## Funções geométricas

| Tipo de Retorno | Função                                           | Descrição / Valor retornado                                  |
|-----------------|--------------------------------------------------|--------------------------------------------------------------|
| `float`         | `length(vec_type x)`                             | Comprimento do vetor.                                        |
| `float`         | `distance(vec_type a, vec_type b)`               | Distância entre vetores, ou seja, length(a - b).             |
| `float`         | `dot(vec_type a, vec_type b)`                    | Produto escalar.                                             |
| `vec3`          | `cross(vec3 a, vec3 b)`                          | Produto vetorial.                                            |
| `vec_type`      | `normalize(vec_type x)`                          | Normaliza para comprimento unitário.                         |
| `vec3`          | `reflect(vec3 I, vec3 N)`                        | Reflexão.                                                    |
| `vec3`          | `refract(vec3 I, vec3 N, float eta)`             | Refração.                                                    |
| `vec_type`      | `faceforward(vec_type N, vec_type I, vec_type Nref)` | Se dot(Nref, I) < 0, retorna N, caso contrário -N.      |
| `mat_type`      | `matrixCompMult(mat_type x, mat_type y)`         | Multiplicação componente a componente de matrizes.           |
| `mat_type`      | `outerProduct(vec_type column, vec_type row)`    | Produto externo de matriz.                                   |
| `mat_type`      | `transpose(mat_type m)`                          | Transposta da matriz.                                        |
| `float`         | `determinant(mat_type m)`                        | Determinante da matriz.                                      |
| `mat_type`      | `inverse(mat_type m)`                            | Inversa da matriz.                                           |

## Funções de comparação

| Tipo de Retorno | Função                                      | Descrição / Valor retornado                                      |
|-----------------|---------------------------------------------|------------------------------------------------------------------|
| `vec_bool_type` | `lessThan(vec_type x, vec_type y)`          | Comparação vetorial booleana usando < em vetores int/uint/float. |
| `vec_bool_type` | `greaterThan(vec_type x, vec_type y)`       | Comparação vetorial booleana usando > em vetores int/uint/float. |
| `vec_bool_type` | `lessThanEqual(vec_type x, vec_type y)`     | Comparação vetorial booleana usando <= em vetores int/uint/float.|
| `vec_bool_type` | `greaterThanEqual(vec_type x, vec_type y)`  | Comparação vetorial booleana usando >= em vetores int/uint/float.|
| `vec_bool_type` | `equal(vec_type x, vec_type y)`             | Comparação vetorial booleana usando == em vetores int/uint/float.|
| `vec_bool_type` | `notEqual(vec_type x, vec_type y)`          | Comparação vetorial booleana usando != em vetores int/uint/float.|
| `bool`          | `any(vec_bool_type x)`                      | Retorna true se algum componente for true, senão false.          |
| `bool`          | `all(vec_bool_type x)`                      | Retorna true se todos os componentes forem true, senão false.    |
| `vec_bool_type` | `not(vec_bool_type x)`                      | Inverte o vetor booleano.                                        |

## Funções de textura

| Tipo de Retorno | Função | Descrição / Valor retornado |
|-----------------|--------|-----------------------------|
| `ivec2` | `textureSize(gsampler2D s, int lod)` | Obtém o tamanho da textura. Por desempenho, esta função deve ser evitada, pois sempre faz uma leitura completa da textura. Quando possível, passe o tamanho da textura como um uniform. |
| `ivec2` | `textureSize(samplerCube s, int lod)` | Obtém o tamanho da textura. Por desempenho, esta função deve ser evitada, pois sempre faz uma leitura completa da textura. Quando possível, passe o tamanho da textura como um uniform. |
| `ivec2` | `textureSize(samplerCubeArray s, int lod)` | Obtém o tamanho da textura. Por desempenho, esta função deve ser evitada, pois sempre faz uma leitura completa da textura. Quando possível, passe o tamanho da textura como um uniform. |
| `ivec3` | `textureSize(gsampler2DArray s, int lod)` | Obtém o tamanho da textura. Por desempenho, esta função deve ser evitada, pois sempre faz uma leitura completa da textura. Quando possível, passe o tamanho da textura como um uniform. |
| `ivec3` | `textureSize(gsampler3D s, int lod)` | Obtém o tamanho da textura. Por desempenho, esta função deve ser evitada, pois sempre faz uma leitura completa da textura. Quando possível, passe o tamanho da textura como um uniform. |
| `vec2` | `textureQueryLod(gsampler2D s, vec2 p)` | Calcula o nível de detalhe (LOD) que seria usado para amostrar uma textura. |
| `vec3` | `textureQueryLod(gsampler2DArray s, vec2 p)` | Calcula o nível de detalhe (LOD) que seria usado para amostrar uma textura. |
| `vec2` | `textureQueryLod(gsampler3D s, vec3 p)` | Calcula o nível de detalhe (LOD) que seria usado para amostrar uma textura. |
| `vec2` | `textureQueryLod(samplerCube s, vec3 p)` | Calcula o nível de detalhe (LOD) que seria usado para amostrar uma textura. |
| `int` | `textureQueryLevels(gsampler2D s)` | Obtém a quantidade de níveis de mipmap acessíveis de uma textura. |
| `int` | `textureQueryLevels(gsampler2DArray s)` | Obtém a quantidade de níveis de mipmap acessíveis de uma textura. |
| `int` | `textureQueryLevels(gsampler3D s)` | Obtém a quantidade de níveis de mipmap acessíveis de uma textura. |
| `int` | `textureQueryLevels(samplerCube s)` | Obtém a quantidade de níveis de mipmap acessíveis de uma textura. |
| `gvec4_type` | `texture(gsampler2D s, vec2 p [, float bias])` | Realiza uma leitura de textura. |
| `gvec4_type` | `texture(gsampler2DArray s, vec3 p [, float bias])` | Realiza uma leitura de textura. |
| `gvec4_type` | `texture(gsampler3D s, vec3 p [, float bias])` | Realiza uma leitura de textura. |
| `vec4` | `texture(samplerCube s, vec3 p [, float bias])` | Realiza uma leitura de textura. |
| `vec4` | `texture(samplerCubeArray s, vec4 p [, float bias])` | Realiza uma leitura de textura. |
| `vec4` | `texture(samplerExternalOES s, vec2 p [, float bias])` | Realiza uma leitura de textura. |
| `gvec4_type` | `textureProj(gsampler2D s, vec3 p [, float bias])` | Realiza uma leitura de textura com projeção. |
| `gvec4_type` | `textureProj(gsampler2D s, vec4 p [, float bias])` | Realiza uma leitura de textura com projeção. |
| `gvec4_type` | `textureProj(gsampler3D s, vec4 p [, float bias])` | Realiza uma leitura de textura com projeção. |
| `gvec4_type` | `textureLod(gsampler2D s, vec2 p, float lod)` | Realiza uma leitura de textura com mipmap personalizado. |
| `gvec4_type` | `textureLod(gsampler2DArray s, vec3 p, float lod)` | Realiza uma leitura de textura com mipmap personalizado. |
| `gvec4_type` | `textureLod(gsampler3D s, vec3 p, float lod)` | Realiza uma leitura de textura com mipmap personalizado. |
| `vec4` | `textureLod(samplerCube s, vec3 p, float lod)` | Realiza uma leitura de textura com mipmap personalizado. |
| `vec4` | `textureLod(samplerCubeArray s, vec4 p, float lod)` | Realiza uma leitura de textura com mipmap personalizado. |
| `gvec4_type` | `textureProjLod(gsampler2D s, vec3 p, float lod)` | Realiza uma leitura de textura com projeção e LOD. |
| `gvec4_type` | `textureProjLod(gsampler2D s, vec4 p, float lod)` | Realiza uma leitura de textura com projeção e LOD. |
| `gvec4_type` | `textureProjLod(gsampler3D s, vec4 p, float lod)` | Realiza uma leitura de textura com projeção e LOD. |
| `gvec4_type` | `textureGrad(gsampler2D s, vec2 p, vec2 dPdx, vec2 dPdy)` | Realiza uma leitura de textura com gradientes explícitos. |
| `gvec4_type` | `textureGrad(gsampler2DArray s, vec3 p, vec2 dPdx, vec2 dPdy)` | Realiza uma leitura de textura com gradientes explícitos. |
| `gvec4_type` | `textureGrad(gsampler3D s, vec3 p, vec2 dPdx, vec2 dPdy)` | Realiza uma leitura de textura com gradientes explícitos. |
| `vec4` | `textureGrad(samplerCube s, vec3 p, vec3 dPdx, vec3 dPdy)` | Realiza uma leitura de textura com gradientes explícitos. |
| `vec4` | `textureGrad(samplerCubeArray s, vec3 p, vec3 dPdx, vec3 dPdy)` | Realiza uma leitura de textura com gradientes explícitos. |
| `gvec4_type` | `textureProjGrad(gsampler2D s, vec3 p, vec2 dPdx, vec2 dPdy)` | Realiza uma leitura de textura com projeção, LOD e gradientes explícitos. |
| `gvec4_type` | `textureProjGrad(gsampler2D s, vec4 p, vec2 dPdx, vec2 dPdy)` | Realiza uma leitura de textura com projeção, LOD e gradientes explícitos. |
| `gvec4_type` | `textureProjGrad(gsampler3D s, vec4 p, vec3 dPdx, vec3 dPdy)` | Realiza uma leitura de textura com projeção, LOD e gradientes explícitos. |
| `gvec4_type` | `texelFetch(gsampler2D s, ivec2 p, int lod)` | Obtém um único texel usando coordenadas inteiras. |
| `gvec4_type` | `texelFetch(gsampler2DArray s, ivec3 p, int lod)` | Obtém um único texel usando coordenadas inteiras. |
| `gvec4_type` | `texelFetch(gsampler3D s, ivec3 p, int lod)` | Obtém um único texel usando coordenadas inteiras. |
| `gvec4_type` | `textureGather(gsampler2D s, vec2 p [, int comps])` | Reúne quatro texels de uma textura. |
| `gvec4_type` | `textureGather(gsampler2DArray s, vec3 p [, int comps])` | Reúne quatro texels de uma textura. |
| `vec4` | `textureGather(samplerCube s, vec3 p [, int comps])` | Reúne quatro texels de uma textura. |
| `vec_type` | `dFdx(vec_type p)` | Derivada em relação à coordenada x da janela, granularidade automática. |
| `vec_type` | `dFdxCoarse(vec_type p)` | Derivada em relação à coordenada x da janela, granularidade grosseira. |
| `vec_type` | `dFdxFine(vec_type p)` | Derivada em relação à coordenada x da janela, granularidade fina. |
| `vec_type` | `dFdy(vec_type p)` | Derivada em relação à coordenada y da janela, granularidade automática. |
| `vec_type` | `dFdyCoarse(vec_type p)` | Derivada em relação à coordenada y da janela, granularidade grosseira. |
| `vec_type` | `dFdyFine(vec_type p)` | Derivada em relação à coordenada y da janela, granularidade fina. |
| `vec_type` | `fwidth(vec_type p)` | Soma das derivadas absolutas em x e y. |
| `vec_type` | `fwidthCoarse(vec_type p)` | Soma das derivadas absolutas em x e y. |
| `vec_type` | `fwidthFine(vec_type p)` | Soma das derivadas absolutas em x e y. |
