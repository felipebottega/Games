# 2D Meshes

As meshes (malhas) basicamente são um conjunto de triângulos que preenchem o sprite. A triangularização tem aplicações que vão além de determinar o shape da figura.

- Godot desenha sprites grandes com transparência considerando todo o retângulo em que ele está contida. Cso ele tenha uma mesh, apenas o shape do mesh que é considerado, reduzido o custo computacional do processo.
- Diversos efeitos visuais específicos podem ser obtidos usando o shader em conjunto. Sem isso você ficaria limitado às transformações simples do `Transform2D`.
- É possível fragmentar os triângulos de uma mesh. Deste modo, você consegue efeitos de quebra de objetos, explosão, mexer membros, entre outros.

## Adicionando mesh ao sprite

