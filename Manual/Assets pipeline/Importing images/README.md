# Importing images

Como vimos no [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Assets%20pipeline/Import%20process), há diversas opções de configuração para fazer um reimport. Vamos ver como elas são no caso de imagens. Neste tutorial, vamos apenas descrever as opções disponíveis de maneira objetiva, sem gastar tempo em análises qualitativas.

## Alterando o tipo

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

## Opções de import

### Compress/Model

Images are one of the largest assets in a game. To handle them efficiently, they need to be compressed. Godot offers several compression methods, depending on the use case.

  - **Lossless:** Este é o modo de compressão padrão e mais comum para assets 2D. Ele mostra assets sem nenhum tipo de artefato, e a compressão de disco é decente. No entanto, ele usará consideravelmente mais memória de vídeo do que a *VRAM Compression*. Esta também é a configuração recomendada para pixel art.
  - **Lossy:** Esta é uma boa opção para grandes assets 2D. Possui alguns artefatos, mas menos do que a compactação VRAM, e o tamanho do arquivo é várias vezes menor em comparação com o modo *Lossless* ou *VRAM Uncompressed*. 
  - **VRAM Compressed:** Este é o modo de compressão padrão e mais comum para assets 3D. O tamanho do disco é reduzido e o uso da memória de vídeo também diminui consideravelmente. Este modo deve ser evitado para 2D, pois exibe artefatos perceptíveis, especialmente para texturas de baixa resolução.
  - **VRAM Uncompressed:** Útil somente para formatos que não podem ser compactados, como imagens brutas de ponto flutuante.
  - **Basis Universal:** Este modo alternativo de compressão VRAM codifica a textura em um formato que pode ser transcodificado para a maioria dos formatos compactados por GPU no momento do carregamento. Isso gera arquivos muito pequenos que utilizam compressão VRAM, mas com qualidade inferior em comparação com a *VRAM Compresse* e tempos de compressão mais lentos. O uso de VRAM geralmente é o mesmo que o da *VRAM Compressed*. O *Basis Universal* não suporta formatos de imagem de ponto flutuante.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/bc07c13e-a23e-4b4b-a403-97cc73847659" />
</p>

### Compress/Channel Pack

  - **sRGB Friendly:** Impede que o formato de cor RG seja usado, pois não suporta cores sRGB.
  - **Optimized:** Permite que o formato de cor RG seja usado se a textura não usar o canal azul.

### Mipmaps/Generate

Se habilitado, versões menores da textura serão geradas na importação. Por exemplo, uma textura de $64 \times 64$ gerará 6 mipmaps ($32 \times 32, 16 \times 16, 8 \times 8, 4 \times 4, 2 \times 2, 1 \times 1$). Isso traz vários benefícios:

  - As texturas não ficarão granuladas à distância (em 3D) ou se forem reduzidas devido ao zoom da câmera ou à escala do `CanvasItem` (em 2D).
  - O desempenho melhorará se a textura for exibida à distância, já que a amostragem de versões menores da textura original é mais rápida e requer menos largura de banda de memória.

A desvantagem dos mipmaps é que eles aumentam o uso de memória em cerca de $33\%$. É recomendável habilitar os mipmaps em 3D. No entanto, em 2D, isso só deve ser habilitado se o seu projeto se beneficiar visivelmente da ativação dos mipmaps. Se a câmera nunca diminuir o zoom significativamente, não haverá benefício em habilitar mipmaps, mas o uso de memória aumentará.

> PS: Habilitar mipmaps pode fazer com que as texturas pareçam mais desfocadas, mas você pode optar por torná-las mais nítidas (ao custo de alguma granulação) definindo *Project → Project Settings → Rendering → Textures → Default Filters → Texture Mipmap Bias* para um valor negativo. 

### Roughness

  - **Mode:** O canal de cor a ser considerado como um mapa de rugosidade (roughness) nesta textura. Somente efetivo se *Roughness/Src Normal* não estiver vazio.
  - **Src Normal:** O caminho para a textura a ser considerado como um mapa normal para filtragem de rugosidade (roughness) na importação. Especificar isso pode ajudar a reduzir ligeiramente o aliasing especular em 3D.
  
  > PS: A filtragem de rugosidade (roughness) na importação é usada apenas em renderização 3D, não em 2D.

### Process 

  - **Fix Alpha Border:** Coloca pixels da mesma cor circundante em transição de áreas transparentes para opacas. Para texturas exibidas com filtro bilinear, isso ajuda a atenuar o efeito de contorno ao exportar imagens de um editor de imagens. É recomendado deixar essa opção ativada (default), a menos que isso cause problemas para uma imagem específica.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/27a742c7-8695-4235-93d2-27333b67d8e0" />
</p>

  - **Premult Alpha:** Uma alternativa para corrigir bordas escurecidas com *Fix Alpha Border* é usar o alfa pré-multiplicado. Ao habilitar esta opção, a textura será convertida para este formato. Uma textura alfa pré-multiplicada requer materiais específicos para ser exibida corretamente.
  - **Normal Map Invert Y:** A Godot exige que o mapa normal use as coordenadas X+, Y+ e Z+, o que é conhecido como um mapa normal no estilo OpenGL. Se você importou um material criado para ser usado em outra engine, ele pode estar no estilo DirectX. Nesse caso, o mapa normal precisa ser convertido habilitando a opção de importação *Normal Map Invert Y*.
  - **HDR as sRGB:** Algumas imagens HDR que você encontra online podem estar corrompidas e conter dados de cores sRGB (em vez de dados de cores lineares). É aconselhável não usar esses arquivos. Se for absolutamente necessário, ativar esta opção fará com que pareçam corretas.

> PS: Habilitar HDR como sRGB em imagens HDR bem formatadas fará com que a imagem resultante pareça muito escura, então deixe essa opção desabilitada se não tiver certeza.
  - **HDR Clamp Exposure:** Algumas imagens panorâmicas HDR que você encontra online podem conter pixels extremamente brilhantes, por terem sido tiradas de fontes reais sem qualquer corte. Ativar a opção *HDR Clamp Exposure* pode resolver esse problema usando uma fórmula que não introduz clipping visível.
  - **Size Limit:** Se definido como um valor maior que 0, o tamanho da textura será limitado a um valor menor ou igual ao valor especificado aqui. Para texturas não quadradas, o limite de tamanho afeta a dimensão maior, com a dimensão menor sendo dimensionada para preservar a proporção. O redimensionamento é realizado usando interpolação cúbica. Isso pode ser usado para reduzir o uso de memória sem afetar as imagens de origem ou evitar problemas com texturas que não são exibidas em plataformas móveis/web (já que estas geralmente não conseguem exibir texturas maiores que $4096 \times 4096$).

### Detect 3D 
  - **Compress To:** Isso altera a opção *Compress/Mode*, usada quando uma textura é detectada como sendo usada em 3D. Alterar esta opção para *Disabled* e, em seguida, reimportar, não alterará o modo de compressão existente em uma textura (se for detectado que ela está sendo usada em 3D), mas escolher *VRAM Compressed* or *Basis Universal* alterará.
