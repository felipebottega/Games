# 2D Meshes

As meshes (malhas) basicamente são um conjunto de triângulos que preenchem o sprite. A triangularização tem aplicações que vão além de determinar o shape da figura.

- Godot desenha sprites grandes com transparência considerando todo o retângulo em que ele está contido. Caso ele tenha uma mesh, apenas o shape da mesh que é considerado, reduzido o custo computacional do processo.
- Diversos efeitos visuais específicos podem ser obtidos usando a mesh e o shader em conjunto. Sem isso você ficaria limitado às transformações simples do `Transform2D`.
- É possível fragmentar um sprite em triângulos quando se tem uma mesh. Deste modo, você consegue efeitos de quebra de objetos, explosão, mexer membros, entre outros.

## Adicionando mesh ao sprite

Crie um `Sprite2D` e vá na opção escrita *Sprite2D* acima da tela (a mesma usada para acesar o shape de sombra). Selecione a opção *Convert to MeshInstance 2D*.

<p align="center">
  <img src="https://github.com/user-attachments/assets/4b1bacba-21ba-4da8-b0dd-e755e4289080" width="800">
</p>

A janela mostrada abaixo irá se abrir. O objetivo desta janela é criar um shape triangularizado de mesh para o seu sprite. A funcionalidade dos parâmetros é a mesma vista na parte de [configuração de sombras](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20lights%20and%20shadows%20-%20Introduction#configurando-sombras) quando estudamos iluminação em Godot.

<p align="center">
  <img src="https://github.com/user-attachments/assets/610e24b6-5c72-4961-8c49-36ccd0098b51" width="700">
</p>
