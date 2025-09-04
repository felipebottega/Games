# Importing images

Como vimos no [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Assets%20pipeline/Import%20process), há diversas opções de configuração para fazer um reimport. Vamos ver como elas são no caso de imagens. Neste tutorial, vamos apenas descrever as opções disponíveis de maneira objetiva, sem gastar tempo em análises qualitativas.

## alterando o tipo

  - **BitMap:** Textura monocromática de 1 bit (destinada a ser usada como máscara de clique em `TextureButton` e `TouchScreenButton`). Este tipo de recurso não pode ser exibido diretamente em nós 2D ou 3D, mas os valores de pixel podem ser consultados em um script usando `get_bit`.
  - **Cubemap:** Importa a textura como um cubemap de 6 lados, com interpolação entre os lados do cubemap (cubemaps contínuos), que podem ser amostrados em shaders personalizados.
  - **CubemapArray:** Importe a textura como uma coleção de cubemaps de 6 lados, que podem ser amostrados em shaders personalizados. Este tipo de recurso só pode ser exibido ao usar os renderizadores *Forward+* ou *Mobile*, não o renderizador de *Compatibility*.
  - **Font Data:** Importa a imagem como uma fonte bitmap com todos os caracteres com a mesma largura.
  - **Image:** Importa a imagem original. Este tipo de recurso não pode ser exibido diretamente em nós 2D ou 3D, mas os valores de pixel podem ser consultados em um script usando `get_pixel`.
  - **Texture2D:** Importa a imagem como uma textura bidimensional, adequada para exibição em superfícies 2D e 3D. Este é o modo de importação padrão.
  - **Texture2DArray:** Importe a imagem como uma coleção de texturas bidimensionais. *Texture2DArray* é semelhante a uma textura tridimensional, mas sem interpolação entre camadas. Os shaders 2D e 3D integrados não podem exibir matrizes de textura, portanto, você deve criar um shader personalizado em 2D ou 3D para exibir uma textura a partir de um array de texturas.
  - **Texture3D:** Importa a imagem como uma textura tridimensional. Esta não é uma textura 2D aplicada a uma superfície 3D. O *Texture3D* é semelhante a um array de texturas, mas com interpolação entre camadas. 
  - **TextureAtlas:** Importa a imagem como um atlas de diferentes texturas. Pode ser usado para reduzir o uso de memória para sprites 2D animados. Suportado apenas em 2D devido à falta de suporte nos shaders 3D integrados.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/31848cec-cd4d-4dfc-90ad-850deb27fe39" />
</p>
