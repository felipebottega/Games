# Camera 2D

A utilização do node `Camera2D` é bem simples, basta adicionar como filho do node que a câmera deve seguir. Pronto, você já tem uma câmera funcional. Mas claro, existem parâmetros para customizar, e alguns detalhes para prestar atenção. Vamos criar uma cena para exemplificar.

## Montando a cena para o uso da Camera2D

A cena será um player em um cenário no estilo top-down. Ela irá se mover no estilo point-and-click e a câmera vai acompanhá-lo. Começamos importando os assets para [tiles](https://craftpix.net/freebies/free-village-pixel-tileset-for-top-down-defense/) e [sprite animado](https://craftpix.net/freebies/city-man-pixel-art-character-sprite-sheets/).

Defina uma resolução de viewport bem grande para o projeto. Isso é necessário para que o zoom-out não perca qualidade. Ou seja, começaremos o jogo com algum zoom-in, usando menos pixels do que temos à disposição. Caso seja feito um zoom-out, ele consegue manter a qualidade da imagem. Se não fosse assim, o zoom-out iria causar uma perda de qualidade, pois o jogo tentaria mostrar mais coisas, que ocupam mais pixels do que se teria à disposição. Também é aconselhável colocar para o modo *Maximized*, pois uma resolução alta dessas vai criar uma janela além da sua tela, enquanto que no *Maximized* ele fica completo dentro da tela.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/766b97b9-dda8-4b60-80e6-2356ef05f38b" />
</p>

Criamos um TileSet onde cada tile tem tamanho $8 \times 8$. Na verdade cada tile nessa tilesheet tem um tamanho maior, mas escolhemos trabalhar em menores pedaços para poder te mais variedade no chão de pedra.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/4e876293-31e9-4015-887e-08e500594a60" />
</p>

Em vez de pintar por tiles, decidimos escolher alguns blocos e criar *Patterns* com eles. Daí utilizamos a pintura por área retangular com aleatoriedade sobre estes padrões.

<p align="center">
  <img width="500" rc="https://github.com/user-attachments/assets/08992aa7-1025-452b-9f76-ad279c3827bc" />
</p>

Após isso, criamos um novo TileSet, para os objetos pequenos acima do chão. É necessário que seja outro TileSet um nível abaixo da árvore de nodes, pois queremos pintar estes tiles sem apagar os do nível acima. Note que escolhemos um tamanho bem pequeno para os tiles, pois todas as imagens são bem pequenas. Porém, note que nenhuma delas é um tile de fato, então precisamos repetir o método de criar padrões.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/c41de79c-24df-4a37-96eb-5d2015fd6060" />
  <img width="500" src="https://github.com/user-attachments/assets/7daee3bf-2cf6-41f1-9373-2cf4f15f5086" />
</p>

Criamos mais um nível de tiles, agora para os tiles das casas. Novamente, são sprites comuns e não tiles. Por isso o método de criar padrões deverá ser feito mais uma vez.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/0f4303f5-6ee8-4763-aacb-2be4b948493f" />
</p>

Feito isso, você tem as ferramentas prontas para desenhar o cenário do jeito que preferir.
