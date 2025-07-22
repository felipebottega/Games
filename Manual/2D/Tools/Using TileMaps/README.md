# Using TileMaps & TileSets

Este tutorial é consituído dos tutoriais [Using TileMaps](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html) e [Using TileSets](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilesets.html). Eu resolvi colocá-los juntos pois me pareceu mais natural assim do que o jeito que fizeram no oficial. A ordem dos tópicos também será um pouco diferente, visando mais a ordem do que ocorre na prática do que uma ordenação teórica. 

## Definições básicas 

- **Tiles:** Pode ser traduzido como "ladrilhos". São basicamente sprites, mas que são alocados repetidamente nos cenários, podendo ser os blocos que formam o chão, paredes, parede, objetos de decoração, entre outros. Por ter esse caráter de ser um objeto que aparece repetidamente, ele pode ser tratado na engine de maneira coletiva. Isso possibilita algumas otimizações e facilidades que não existe com o sprite, pois este último é tratado como um objeto único e diferenciado do restante.
- **Tilemap:** É uma grid de tiles.
- **Tileset:** É um conjunto de tiles que pode ser colocado no tilemap do jogo.
- **Tilesheet:** É uma imagem contendo vários tiles. A tilesheet é utilizada para criar o objeto tileset, que então é utilizado para compor o tilemap do jogo.
- **Atlas:** É o tilesheet com a divisão quadriculada já pronta.

## Criando um tileset

Começamos baixando o tilesheet [Kenney's "Abstract Platformer" pack](https://kenney.nl/assets/abstract-platformer) que é de licença free. Descompacte o arquivo e coloque a imagem na pasta do seu projeto. Feito isso, crie um node `TileMapLayer` e no Inspector vá em *TileSet → NewTileSet*. Clique novamente neste ícone para abrir as opções e coloque o *Tile Size* para $64 \times 64$. Neste caso estas são as dimensões de cada tile, vocÊ vai ter que saber isso antes de proceder.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/382a4ec0-e0e7-48fc-bd11-26992f270058" />
</p>

Depois clique em *TileSet* no editor abaixo do canvas (rodapé da imagem abaixo), selecione o tilesheet em *FileSystem* e arraste o tilesheet para o espaço vazio. Vai abrir uma mensagem perguntando se você quer gerar automaticamente o atlas, selecione sim. Raramente você vai precisar fazer o atlas na mão. O resultado deverá ser parecido com o da figura abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/10935ae9-3276-495c-8a52-7f239fa9ca31" />
</p>


