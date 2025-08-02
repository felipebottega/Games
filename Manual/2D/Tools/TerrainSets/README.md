# Terrain Sets

Em teoria, não é necessário usar Terrain Sets para gerar os seus cenários com tiles, pois Terrain Sets é apenas uma ferramenta para facilitar e agilizar o processo de desenhar tiles. É uma maneira de automatizar transição entre terrenos diferentes, quinas, final de segmentos, cenários gerados de maneira procedural, entre outros. Considere o Terrain Set como uma ferarmenta especial de Tile Sets. Vamos explicar como funciona na prática. Primeiramente, comece criando um TileSet normalmente. 

## Criando um Terrain Set

Depois de criar um cena com o node `TileMapLayer` e inserir um tilesheet no set TileSet, vá em *Inspector → Terrain Sets → Add Element*. Com isso, você acabou de criar um *Terrain Set*. Depois clique em *Terrains* e no *Add Element* que apareceu dentro da caixa. Você acabou de criar um *terreno* (*terrain*) dentro do seu Terrain Set. Note que é possível adicionar mais terrenos dentro do mesmo Terrain Set.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/25a2969b-b522-4704-a0ae-093d8d09c4d3" />
  <img width="300" src="https://github.com/user-attachments/assets/274b69d1-03d0-47b4-8b43-5e79eb73305f" />
  <img width="300" src="https://github.com/user-attachments/assets/be69b0ac-cba2-4e8a-86ea-db5710c5a5f5" />
</p>

O parâmetro de nome pode ser o que você quiser, é para você ler e identificar rápido que tipo de terreno é este objeto. A cor é para auxiliar a visualização na hora de pintar, veremos mais adiante. Esses dois parâmetros podem ser considerados superficiais, enquanto que o *Mode* é mais relevante. Ele define o modo como um tile pode reconhecer tiles vizinhos. Também veremos mais sobre isso adiante.

Você pode clicar para adicionar mais terrenos, todos dentro do mesmo Terrain Set. Note que cada terreno possui um nome e cor próprios, mas o *Mode* é único para todos os terrenos, ou seja, é uma propriedade do Terrain set. Se quiser, você ter outros Terrain Sets, basta clicar no *Add Element* mais abaixo.

<p align="center">
  <img width="330" src="https://github.com/user-attachments/assets/11eb0b37-7e53-4650-a992-33d1e628d071" />
</p>

## A lógica de terrenos

Cada *mode* significa uma atribuir uma certa subdivisão aos tiles. Cada pedaço dessa subdivisão pode estar, ou não, associado a um dos terrenos que você definiu anteriormente. Essas subdivisões são chamadas de *peering bits*. Todo tile com terreno sempre terá um pedaço central, chamado de *central bit*. Este bit central serve para definir qual o terreno daquele tile. Você pode ter um tile com *peering bits* de vários terrenos misturados, mas é o central que vai determinar qual o terreno "oficial" daquele tile. Mostramos abaixo os três modes de Terrain Sets.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/bdfcc8ee-92f3-48bd-ac4d-4b0a893f55ad" />
</p>

Na figura, apontamos apenas um peering bit como exemplo, mas todos os bits que não são o central são "peering". Em vez de explicar teoricamente, iremos explicar com um exemplo prático. Temos um atlas inteiro à disposição, mas iremos configurar terrenos apenas para os tiles abaixo.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/f02f8e8d-73f2-4563-9dc6-3992a70e23af" />
</p>

Escolhemos o mode *Match Sides* e configuramos os peering bits como mostrado abaixo, apenas para estes tiles do atlas. Todos os pedaços com cor diferenciada pertence a um mesmo terreno. Mas o que isso significa? Ao desenhar os tiles no espaço com o modo terrain, você não precisa definir qual tile vai desenhar, o editor vai inferir isto automaticamente com base nos tiles vizinhos. A ideia é que ele sempre vai tentar dar "match" de acordo com os peering bits. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/ec004e91-d9b0-4a04-8600-64f6e0d45ed0" />
</p>

Por exemplo, se tiver o tile <img width="50" src="https://github.com/user-attachments/assets/41903ebf-f8e0-4c2c-a679-e217c88affe2" /> e você clicar para desenhar outro tile à esquerda deste, automaticamente a engine vai desenhar o tile <img width="50" src="https://github.com/user-attachments/assets/e6145de8-ea30-4b6a-b9fd-95794a0a27b9" />. O principal motivo é porque o peering bit à esquerda do primeiro dá match com o peering bit à direita do segundo. É natural se questionar porque os outros dois tiles são descartados já que eles também possuem peering bits na direita. Note que eles teriam mais peering bits com terreno indo "no vazio" caso eles fossem escolhidos. Então o tile escolhido é escolhido não apenas pelo peering bit que deu match, mas também porque seus peering bits sem terreno foram no vazio, o que conta como um match também. Em outras palavras, todos os peering bits do tile são levados em conta na hora da escolha. 

> PS: Uma maneira simplificada de pensar o que norteia a escolha de tiles: A engine quer dar match de peering bits com o mesmo terreno e não quer peering bits com terreno sendo vizinhos de vazio ou de outros terrenos.
