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
