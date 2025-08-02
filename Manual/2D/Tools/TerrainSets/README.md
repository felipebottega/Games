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

Aí você desenhou os dois tiles (figura abaixo) e agora vai clicar para desenhar mais um tile à esquerda. O que acontece?

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/74a84180-134c-4f42-8dc1-0d155f59c729" />
</p>

A engine automaticamente corrige o tile central e desenha o fim do chão com o tile curvado para o lado certo, como gostaríamos. 

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/8f7cd9a5-cdc0-4978-8572-20bd711fb3f7" />
</p>

Quando você clica para desenhar um tile, a engine procura não apenas desenhar o seu tile baseado nos vizinhos, mas ela também verifica se deve alterar algum vizinha para ter o encaixe ótimo. Pela maneira como os peering bits foram configurados, a forma mostrada acima é a melhor solução. Não por acaso, essa configuração é ideal para desenhar chãos. Você pode clicar e arrastar o mouse, a engine vai resolver da maneira correta. Artefatos podem aparecer se você se empolgar demais e sair do esperado, mas ainda assim o processo de desenhar fica muito mais rápido do que fazer manualmente. 

A mesma ideia se aplica aos outros modes. O que muda são os formatos dos peering bits e quantidade. Não tenho a intenção de me aprofundar demais nas diferenças de cada um. Acredito que a melhor maneira para aprender esses pormenores é com a experiência.

## Pintando terrenos

Falamos de pintar terrenos nos tiles e desenhar tiles sem explicar como estas tarefas são feitas. Isto foi proposital, a intenção era entender o conceito primeiro. Agora que ele foi entendido, podemos passar para os processos.

Existem duas maneiras de pintar terrenos nos tiles. Você pode fazer pela aba *Select* ou *Paint*, no *TileSet* do editor.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/4ebbbcf8-c971-464d-a909-5a586964ee57" />
</p>

### Pintando terrenos pelo Select

Antes mesmo de querer começar a pintar terrenos, não se esqueça de ter o atlas já acertado no teu TileSet, e tenha o terreno correto criado dentro do TileSet também. Podemos ver abaixo que tudo já está pronto, só falta dar o próximo passo. Selecione o tile que quer confiugurar e clique em *Terrains*, dentro da janela do *Select*, no editor.

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/1b7b66a9-f51f-45ff-a678-35d4393e96fb" />
</p>

Ao abrir a aba, selecione a ID do Terrain Set e do terreno. Por default, a indexação começa em zero e incrementa de 1 em 1 conforme você adiciona mais Terrains Sets e terrenos. Lembro que um Terrain Set pode possuir diversos terrenos. É importante ter isso em mente no caso de ter mais de um Terrain Set. Pois nessa situação existirão terrenos distintos de IDs iguais, mas que estarão em Terrain Sets diferentes. Uma vez que você escolheu as IDs corretas, está na hora de configurar os peering bits do seu tile. Clique em *Terrains Peering Bits*. A caixa abaixo vai se abrir.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/ee3a1322-a06e-4cce-8e7f-927b7851a17f" />
  <img width="350" src="https://github.com/user-attachments/assets/90861998-938d-4c8e-a6d6-433170254053" />
</p>

Alteramos o valor de cada peering bit para a ID do terreno que queremos. Caso haja mais de um terreno no Terrain Set, é totalmente possível um mesmo tile ter múltiplos terrenos. Note que não é necessário configurar o central bit, pois estamos associado este tile a um terreno, logo, o central bit automaticamente é do mesmo terreno. A configuração deste primeiro é mais fácil, pois sabemos que todos os seus lados podem estar pareando com vizinhos do mesmo tipo de terreno.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/9e458b4b-01a6-4218-9ba8-a4382016f3e4" />
</p>

Abaixo, mostramos de maneira sucinta a configuração dos outros tiles de interesse.

<p align="center">
  <img width="290" src="https://github.com/user-attachments/assets/87d5546d-03ea-4c9a-93f1-9f2057efda29" />
  <img width="340" src="https://github.com/user-attachments/assets/1bb0fb96-581e-4e48-b5b6-363119e8e3b3" />
  <img width="370" src="https://github.com/user-attachments/assets/53341f53-7aa0-4d16-998e-c8e8ae2f9ad1" />
</p>

### Pintando terrenos pelo Paint

Já vimos como o *Paint* funciona [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Tools/Using%20TileMaps#aba-paint), basicamente você escolhe uma propriedade que quer pintar e é só ir pintando ela pelo atlas. Começamos selecionando a propriedade *Terrains*, como mostrado abaixo.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/44d4fe20-a171-4a96-8a72-2e16f8f70835" />
</p>

Selecione o Terrain Set e pinte os tiles que devem estar associados a ele. Não tem um fator visual muito indicativo, os tiles apenas ficam um pouco mais claros.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/003a9257-ab2d-46c6-83d6-698ffd9aaa47" />
</p>

Feitas as seleções de Terain Set, escolha o terreno que quer pintar. Em vez de mostrar a ID, como foi no caso da aba *Select*, aqui o que aparece é o nome do terreno. Neste exemplo nós só criamos um Terrain Set contendo um único terreno, então está fácil.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/6bcb9595-8a8f-4b8e-9379-59ee291507ab" />
</p>

E Agora chegou a hora de pintar. É só passar o mouse pelas regiões e ir pintando de acordo. O método pelo "Paint* é mais dinâmico que o *Select*, mas é bom saber os dois.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/407ace77-dbe2-4667-9d96-dbd32868066d" />
</p>

## Desenhando terrenos

Só o que falta agora é saber como desenhar os terrenos na tela. Na verdade esse é o passo mais fácil de todos. Baste ir em *TileMap*, no editor, e selecionar a aba *Terrains*. Os ícones das ferramentas de desenho vão aparecer e, na janela abaixo, você deve escolher qual Terrain Set e terreno quer desenhar. Em geral, o modo de desenho <img width="30" src="https://github.com/user-attachments/assets/152cf6f2-11fe-4410-95c0-b6180c100e31" /> é o que atende as necessidades mais gerais, enquanto que o <img width="30" src="https://github.com/user-attachments/assets/eb672c15-1c59-4d9f-ae3f-13ca276f022d" /> é mais específico. Não vou entrar nos detalhes das diferenças deles, isso é outra coisa que você deve aprender na prática. Os outros ícones ao lado forçam a desenhar um tile específico do conjunto de tiles do Terrain Set, o que pode ser necessário às vezes (lembrando também que é sempre possível voltar ao modo normal de desenhar tiles, isto é, sem nada de terrenos).

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/c4312216-6ffb-40e0-ab38-c6ceb49eebdc" />
</p>

## Templates

Existem assets de cenários 2D que já levam em conta todas as possíveis configurações de terrenos. Basta configurar os peering bits e você já tem um lindo atlas pronto para fazer seus cenários rapidamente. A questão é a configuração dos peering bits. O template é apenas uma tilesheet normal, não tem nenhum indicativo de onde devem ir os peering bits de cada tile. Por isso existem convenções de como devem vir esses templates. Mostramos abaixos os templates mais comuns, com a estrutura à esquerda e um exemplo real à direita.

**Match Sides**
<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/4890773b-b033-49b9-ad5a-dbdf35aef0df" />
  <img width="360" src="https://github.com/user-attachments/assets/f3ef9771-5f22-4b56-9a7a-976301b19eb5" />
</p>

**Match Corners**
<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/7e7bbbce-666f-47e0-a563-3df9f5226c2a" />
  <img width="350" src="https://github.com/user-attachments/assets/e0f615e1-5e63-4116-a317-e094c3efdbfa" />
</p>

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/71bf2cb3-c2f1-4066-841b-a918295cc5c4" />
  <img width="350" src="https://github.com/user-attachments/assets/77c12f8b-babd-4319-aa9b-7ee9edce0d87" />
</p>

**Match Corners and Sides**

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/d0d2374a-178d-429f-8d8b-6dfc6b2b4b3a" />
  <img width="500" src="https://github.com/user-attachments/assets/bf9782ea-b453-40b2-a907-f7cec9ce59d2" />
</p>
