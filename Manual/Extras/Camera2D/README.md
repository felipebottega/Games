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

Após isso, criamos um novo TileSet, para os objetos pequenos acima do chão (folhas e barris). É necessário que seja outro TileSet um nível abaixo da árvore de cena (SceneTree), pois queremos pintar estes tiles sem apagar os do nível acima. Poderíamos tentar repetir a ideia de cima com um tamanho bem pequeno para os tiles, mas isto acarretaria em problemas de performance. Tiles muito pequenos acarretam em um tilemap muito granular, o que é custoso computacionalmente. Vamos introduzir outro método aqui.

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

Com este setup, você tem um jogo em que a câmera fica sempre centrada no boneco e o segue assim que ele se move. Abaixo, mostramos como é a cena inicial do jogo quando colocamos para rodar. 

## Básico de Camera2D

Logo de cara já percebemos que tem algum problema. A câmera está mostrando trechos do espaço sem textura. Não queremos isso!

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/4af1aa8b-0d0f-4a12-b4f7-612c899820b4" />
</p>

Indo na cena Main, podemos ver claramente a razão disso: o boneco começa no canto da tela, e a câmera tem um campo de visão que acaba indo além disso mesmo. Poderíamos colocar o boneco para começar mais para o centro, mas ele poderia simplesmente andar até aquele ponto novamente. Isso não resolveria o problema. Poderíamos também adicionar mais textura no cenário e criar uma parede invisível no caminho. Isso até resolveria, mas essa parede deveria fazer o boneco travar no meio da tela, nunca no canto. 

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/8ab41b0f-a444-4bae-a162-686439dd45bb" />
</p>  

A solução correta é usar os parâmetros de limitação, *Left, Top, Right, Bottom*. Eles definem coordenadas absolutas de onde a câmera nunca pode passar. Pela imagem acima, podemos concluir que o $x$ nunca deveria ser maior que $3000$ e o $y$ nunca deveria ser maior que $1500$. O que faz sentido, pois é o tamanho da viewport. Também não queremos que a câmera mostre o que tem antes de $x = -3000$ e $y = -400$, pois não há textura além disso.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/876f23cf-613e-4c64-b249-332a6b37aeee" />
</p>

## Intermediário de Camera2D

Saber limitar o que a câmera enxerga é o básico para se ter um jogo que não seja feio, mas dá para obter algumas melhorias. Vamos ver os principais parâmetros aqui.

**Offset:** Força a câmera a se posicionar a alguns pixels de distância da posição default. Tenha em mente que esse parâmetro desrespeita os limites. No exemplo abaixo, colocamos um offset de $y = 200$ pixels. Isso significa que a câmera vai se posicionar $200$ pixels abaixo do que deveria. Com isso, a câmera acaba mostrando a parte sem textura, mesmo com o limite anterior definido.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/56522101-49a0-4a9f-a2ab-9a93430b6ef6" />
  <img width="700" src="https://github.com/user-attachments/assets/2cac7f63-48c1-4eaa-ab63-9cdd9d912199" />
</p>

**Ignore Rotation:** Se houver algum rotação em um node superior, ela não afeta câmera. Com essa opção desabilitada a câmera rotaciona junto.

**Enabled:** Controla se a câmera está ativada ou não.

> PS: Só para lembrar, a câmera desativada significa apenas que a tela não vai se mover junto com o boneco, ela não vai escurecer.

**Zoom:** Como o próprio nome diz, aplica zoom-in ou zoom-out. Se você der zoom em apenas um dos eixos, a imagem vai se distorcer.

**Process Callback:** Escolhe se a câmera deve ser atualiza via `_process` ou `_physics_process`.

## Avançado de Camera2D

### Drag

Para começar, ative as opções *Draw Limits* e *Draw Drag Margin* no *Inspector*.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/63ae4680-086a-466b-aaaa-5a850356087d" />
  <img width="600" src="https://github.com/user-attachments/assets/179022e1-95d5-4658-b662-6e5ca579427c" />
</p>

Já vimos sobre limites anteriormente. A opção marcada deixa evidente na tela onde estão os limites, que são as linhas amarelas. Aquele quadrado verde no meio (talvez azul?) marca os limites do *drag* que já vem por default. Esse quadrado demarca limites horizontais e verticais que servem como triger para a câmera poder se mover. Ou seja, Se o boneco for para a esquerda, a câmera só vai começar a acompanhar quando ele ultrapassar a linha vertical esquerda. Se ele resolver voltar para a direita, a câmera não vai se mover até ele ultrapassar a linha vertical direita. O mesmo raciocínio se aplica a ir para cima ou para baixo na tela. Sem o drag, a câmera fica eternamente se movimentando em resposta a qualquer mínimo movimento do jogador, e nem sempre isso é desejável.

> PS: Sem o drag a câmera pode deixar de se mover também caso o jogador esta perto dos limites. Aí a câmera trava na posição do limite.

Para ativar o drag vertical ou horizontal, devemos marcar as opções *Drag → Vertical Enabled* e/ou *Drag → Horizontal Enabled*. Depois disso, escolha os valores para *Left Margin, Top Margin, Right Margin, Bottom Margin*. Estes valores representam a distância entre o centro e o final da câmera, em percentual.

### Smoothing

Temos as opções *Position Smoothing* e *Rotation Smoothing* no *Inspector*. Por default elas vem desativadas. Quando você ativa a *Position Smoothing*, a câmera não acompanha o boneco automaticamente. Ela vai atrás dele com um pouco de atraso, parando suavemente. O mesmo vale para a *Rotation Smoothing*, mas em vez de mudar de posição é em relação a rotação. 

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/2024a1cb-fe1f-41e6-b15b-c8f1c10157f8" />
</p>

## Zoom via script

Podemos implementar uma dinâmica onde o jogo começa com um certo zoom e o jogador consegue alterar o zoom pelo scroll do mouse. Isso é possível pelo script abaixo, que deve ser anexado ao node `Camera2D`.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/65e818f8-c58b-4f0c-bb55-0c1b84f41e89" />
</p>
