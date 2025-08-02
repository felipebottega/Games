# Terrain Sets

Em teoria, não é necessário usar Terrain Sets para gerar os seus cenários com tiles, pois Terrain Sets é apenas uma ferramenta para facilitar e agilizar o processo de desenhar tiles. É uma maneira de automatizar transição entre terrenos diferentes, quinas, final de segmentos, cenários gerados de maneira procedural, entre outros. Vamos explicar como funciona na prática. Primeiramente, comece criando um TileSet normalmente. 

## Criando um Terrain Set

Depois de criar um cena com o node `TileMapLayer` e insertir um tilesheet no set TileSet, vá em *Inspector → Terrain Seys → Add Element*. Com isso, você acabou de criar um *Terrain Set*, que pode ser visto como um tipo especial de Tile Set. Depois clique em *Terrain* e no *Add Element* que apareceu dentro da caixa. Você acabou de criar um *Terrain* dentro do seu Terrain Set. Note que é possível adicionar mais terrenos dentro do mesmo Terrain Set.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/25a2969b-b522-4704-a0ae-093d8d09c4d3" />
  <img width="300" src="https://github.com/user-attachments/assets/274b69d1-03d0-47b4-8b43-5e79eb73305f" />
  <img width="300" src="https://github.com/user-attachments/assets/be69b0ac-cba2-4e8a-86ea-db5710c5a5f5" />
</p>

O nome pode ser o que você quiser, é para você ler e identificar rápido que tipo de terreno é este objeto. A cor é para auxiliar a visualização na hora de pintar, veremos mais adiante. Esses dois parâmetros podem ser considerados superficiais, enquanto que o *Mode* é muito relevante. Ele define o modo como um tile pode reconhecer tiles vizinhos. Também veremos mais sobre isso adiante.

Você pode clicar para adicionar mais terrenos, todos dentro do mesmo Terrain Set. Note que cada terreno possui um nome e cor próprios, mas o *Mode* é único para todos os terrenos, ou seja, é uma propriedade do Terrain set. Se quiser, você ter outros Terrain Sets, basta clicar no *Add Element* mais abaixo.

<p align="center">
  <img width="330" src="https://github.com/user-attachments/assets/11eb0b37-7e53-4650-a992-33d1e628d071" />
</p>

## A lógica de terrenos

Cada *mode* significa uma atribuir uma certa subdivisão aos tiles. Cada pedaço dessa subdivisão pode estar, ou não, associado a um dos terrenos que você definiu anteriormente. Essas subdivisões são chamadas de *peering bits*. Todo tile com terreno sempre terá um pedaço central, chamado de *central bit*. Este bit central serve para definir qual o terreno daquele tile. Você pode ter um tile com *peering bits* de vários terrenos misturados, mas é o central que vai determinar qual o terreno "oficial" daquele tile. Mostramos abaixo os três modes de Terrain Sets.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/bdfcc8ee-92f3-48bd-ac4d-4b0a893f55ad" />
</p>

Na figura, apontamos apenas um peering bit como exemplo, mas todos os bits que não são o central são "peering". Em vez de explicar teoricamente, iremos explicar com um exemplo prático. 
