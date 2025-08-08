# Camera 2D

A utilização do node `Camera2D` é bem simples, basta adicionar como filho do node que a câmera deve seguir. Pronto, você já tem uma câmera funcional. Mas claro, existem parâmetros para customizar, e alguns detalhes para prestar atenção. Vamos criar uma cena para exemplificar.

## Montando a cena para o uso da Camera2D

A cena será um player em um cenário no estilo top-down. Ela irá se mover no estilo point-and-click e a câmera vai acompanhá-lo. Começamos importando os assets para [tiles](https://craftpix.net/freebies/free-village-pixel-tileset-for-top-down-defense/) e [sprite animado](https://craftpix.net/freebies/city-man-pixel-art-character-sprite-sheets/).

Defina uma resolução de viewport bem grande para o projeto. Isso é necessário para que o zoom-out não perca qualidade. Ou seja, começaremos o jogo com algum zoom-in, usando menos pixels do que temos à disposição. Caso seja feito um zoom-out, ele consegue manter a qualidade da imagem. Se não fosse assim, o zoom-out iria causar uma perda de qualidade, pois o jogo tentaria mostrar mais coisas, que ocupam mais pixels do que se teria à disposição. Também é aconselhável colocar para o modo *Maximized*, pois uma resolução alta dessas vai criar uma janela além da sua tela, enquanto que no *Maximized* ele fica completo dentro da tela.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/766b97b9-dda8-4b60-80e6-2356ef05f38b" />
</p>

### Método 1 para lidar com tiles de tamanhos diferentes do TileSet

Criamos um TileSet onde cada tile tem tamanho $8 \times 8$. Na verdade cada tile nessa tilesheet tem um tamanho maior, mas escolhemos trabalhar em menores pedaços para poder ter mais variedade no chão de pedra.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/4e876293-31e9-4015-887e-08e500594a60" />
</p>

Em vez de pintar por tiles, decidimos escolher alguns blocos e criar *Patterns* com eles. Daí utilizamos a pintura por área retangular com aleatoriedade sobre estes padrões.

<p align="center">
  <img width="500" rc="https://github.com/user-attachments/assets/08992aa7-1025-452b-9f76-ad279c3827bc" />
</p>

### Método 2 para lidar com tiles de tamanhos diferentes do TileSet

Após isso, criamos um novo TileSet, para os objetos pequenos acima do chão (folhas e barris). É necessário que seja outro TileSet um nível abaixo da árvore de nodes, pois queremos pintar estes tiles sem apagar os do nível acima. Poderíamos tentar repetir a ideia de cima com um tamanho bem pequeno para os tiles, mas isto acarretaria em problemas de performance. Tiles muito pequenos acarretam em um tilemap muito granular, o que é custoso computacionalmente. Vamos introduzir outro método aqui.

Escolha um tamanho de TileSet que esteja próximo da maioria dos sprites que você deseja colocar. No exemplo, escolhemos $5 \times 8$. Agora adiciona um dos sprites ao TileSet, ele deve entrar cinza pois não se adequou ao formato padrão. Vá em *Setup → Texture Region Size*, coloque o tamanho da imagem e clique na imagem no atlas. Este parâmetro serve justamente para dar conta de tiles com tamanhos diferentes do tamanho padrão. Faça isso para cada uma das figuras. 

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/97721bd0-f8ef-4f71-9712-41df36ecfc86" />
  <img width="700" src="https://github.com/user-attachments/assets/a5a187f1-a084-4ad8-b130-c686364e2834" />
</p>

### Método 3 para lidar com tiles de tamanhos diferentes do TileSet

Criamos mais um nível de tiles, agora para os tiles das casas. Novamente, são sprites comuns e não tiles. Por isso o método de criar padrões deverá ser feito mais uma vez. Note que estamos usando um TileSet com tamanho muito menor para compor as casas. Esse approach é mais indicado quando temos uma tilesheet com vários elementos e alguns são maiores, aí eles acabam sendo um conjunto de tiles. Quando forem sprites isolados, o mais indicado é o método 2. Estamos mostrando aqui diferente apenas para poder passar este conceito.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/0f4303f5-6ee8-4763-aacb-2be4b948493f" />
</p>

Feito isso, você tem todas as ferramentas prontas para desenhar o cenário do jeito que preferir.

### Player com movimento de *clicar e mover*

A última coisa é criar o player. Utilizamos a estrutura clássica de um `CharacterBody2D` contendo a animação e colisão. Também criamos um `Sprite2D` com a sombra debaixo do boneco. Para este exemplo, utilizamos *Motion Mode* igual a *Floating*, que é o indicado para jogos top-down. Se você utilizar o script default da Godot para `CharacterBody2D`, não esqueça de remover a parte da gravidade. Na verdade, aconselho a copiar o script de *Clicar e mover* mostrado no tutorial [2D movement overview]([<p align="center">](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/2D%20movement%20overview#clicar-e-mover).

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/0e61287c-5f65-4f21-aff5-c5833547e4b0" />
  <img width="350" src="https://github.com/user-attachments/assets/ca163035-6b4f-4aef-9444-fb0b393df5d5" />
</p>

## Super básico de Camera2D

Como dissemos no início, basta colocar um node `Camera2D` como filho do player e ele vai segui-lo conforme ele se move na tela. O quadrado rosa indica o que a câmera enxerga, e é bom ressaltar que o tamanho deste quadrado sempre acompanha o tamanho da viewport. O boneco está no centro da câmera, como mostrado mais de perto na segunda imagem.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/2c50495c-c86b-4f0c-9822-9ffc48098c59" />
  <img width="200" src="https://github.com/user-attachments/assets/970d6a23-fe02-4bcc-b09a-48a0e732a8de" />
</p>

Com este setup, você tem um jogo em que a câmera fica sempre centrada no boneco e o segue assim que ele se move. Abaixo, mostramos como é a cena inicial do jogo quando colocamos para rodar. Logo de cara já percebemos que tem algum problema. A câmera está mostrando trechos do espaço sem textura. Não queremos isso!

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/4af1aa8b-0d0f-4a12-b4f7-612c899820b4" />
</p>
