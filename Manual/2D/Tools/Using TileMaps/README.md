# Using TileMaps & TileSets

Este tutorial é consituído dos tutoriais [Using TileMaps](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html) e [Using TileSets](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilesets.html). Eu resolvi colocá-los juntos pois me pareceu mais natural assim do que o jeito que fizeram no oficial. A ordem dos tópicos também será um pouco diferente, visando mais a ordem do que ocorre na prática do que uma ordenação teórica. 

## Definições básicas 

- **Tiles:** Pode ser traduzido como "ladrilhos". São basicamente sprites, mas que são alocados repetidamente nos cenários, podendo ser os blocos que formam o chão, paredes, parede, objetos de decoração, entre outros. Por ter esse caráter de ser um objeto que aparece repetidamente, ele pode ser tratado na engine de maneira coletiva. Isso possibilita algumas otimizações e facilidades que não existe com o sprite, pois este último é tratado como um objeto único e diferenciado do restante.
- **Tilemap:** É uma grid de tiles pronta para ser colocada no jogo.
- **TileSet:** É um conjunto de tiles que pode ser colocado no tilemap do jogo.
- **Tilesheet:** É uma imagem contendo vários tiles. A tilesheet é utilizada para criar o objeto tileset, que então é utilizado para compor o tilemap do jogo.
- **Atlas:** É o tilesheet com a divisão quadriculada já pronta. Um TileSet pode conter vários atlas diferentes.

## Criando um TileSet

Começamos baixando o tilesheet [Kenney's "Abstract Platformer" pack](https://kenney.nl/assets/abstract-platformer) que é de licença free. Descompacte o arquivo e coloque a imagem na pasta do seu projeto. Feito isso, crie um node `TileMapLayer` e no Inspector vá em *TileSet → NewTileSet*. Clique novamente neste ícone para abrir as opções e coloque o *Tile Size* para $64 \times 64$. Neste caso estas são as dimensões de cada tile, vocÊ vai ter que saber isso antes de proceder.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/382a4ec0-e0e7-48fc-bd11-26992f270058" />
</p>

Depois clique em *TileSet* no editor abaixo do canvas (rodapé da imagem abaixo), selecione o tilesheet em *FileSystem* e arraste o tilesheet para o espaço vazio. Vai abrir uma mensagem perguntando se você quer gerar automaticamente o atlas, selecione sim. Raramente você vai precisar fazer o atlas na mão. O resultado deverá ser parecido com o da figura abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/10935ae9-3276-495c-8a52-7f239fa9ca31" />
</p>

## Coordenadas do tilemap

Uma coisa importante para ficar atento logo de início é que o tilemap possui seu próprio sistema de coordenadas. Como você pode ver pelas imagens abaixo, o $(0, 0)$ está no bloco cujo canto superior esquerdo está no $(0, 0)$ do mundo. Depois disso ele segue o mesmo esquema de $x$ aumentando para a direita e $y$ aumentando para baixo. É altamente recomendado não mover o tilemap da origem pois isto pode deixar as referências espaciais muito confusas depois.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/8a3489b9-7672-4302-85cd-49f167e2eff3" />
</p>

> PS: Note que cada bloco tem $64 \times 64$ pixels, pois este é o tamanho de cada tile, como vimos anteriormente. 

## Desenhando tiles na tela

A principal ferramenta para desenhar com tiles é este pequeno conjunto de opções destacado na imagem abaixo. Só isso já é suficiente para cobrir a maioria das necessidades com tiles. Apenas os primeiros 5 itens são ferramentas de fato, o que vem depois são modificadores das ferramentas. No caso da ferarmenta de seleção (que é a que está sendo usada na imagem), ela não é afetada por nenhum modificador. Vamos passar um por um.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/3efed9b7-4fde-4c96-a332-0f69a64d08ed" />
</p>

- <img width="40" src="https://github.com/user-attachments/assets/c245310f-a5f1-4f4a-8492-47bc3081cb03" /> O lápis é a ferramenta de desenho comum. Basta você selecionar o tile no editor e depois pode ir no canvas para desenhar os tiles como bem entender.

- <img width="40" src="https://github.com/user-attachments/assets/ceb82f16-16c3-40fe-a516-d6d11577a626" /> O traço é a ferramenta para desenhar segmentos de reta com tiles. Você tem que clicar e segurar o botão do mouse no ponto ininial, então basta mover o mouse para decidir o ponto final e soltar o clique.

- <img width="40" src="https://github.com/user-attachments/assets/6a86c611-38a1-4ca6-a3e4-f8e90c1aff81" /> Ferramenta de retângulo preenchido. Também é só questão de clicar e segurar o clique do mouse, depois o mova e solte onde achar melhor.

- <img width="40" src="https://github.com/user-attachments/assets/5097ffe1-2a7d-4ec1-aa16-9e9c0ba1d59a" /> Ferramenta de preenchimento. Basta clicar na região e ela será preenchida com o tile selecionado. Assim que você seleciona essa ferramenta, ao lado aparece um modificador especial só dela. O botão <img width="80" src="https://github.com/user-attachments/assets/695d8e98-f30f-40d7-a7d9-7a39510cf7d8" /> serve para fazer um preenchimento contínuo ou não. Recomendo testar para entender o comportamento, não é difícil.

Agora vamos aos modificadores. É importante ressaltar que você deve selecionar o modificador antes de começar o desenho. A imagem abaixo exemplifica o caso em que selecionamos a ferramenta de desenho junto de um modificador de rotação. Caso fique em dúvida do que vai sair, você sempre pode passar o mouse no canvas e vai aparecer o preview do tile que será desenhado.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/64a77e84-a6ed-472a-8e9d-72bec239f641" />
</p>

- <img width="40" src="https://github.com/user-attachments/assets/dfe793f7-a213-454e-b01f-f25e045811a7" /> Rotaciona o tile para a esquerda em $90^\circ$. Cada vez que você clica no modificador ele faz mais uma rotação.

- <img width="40" src="https://github.com/user-attachments/assets/96de6302-0200-4460-96b1-dd7f4d914d1b" /> Análogo ao anterior, mas rotaciona para a direita.

- <img width="40" src="https://github.com/user-attachments/assets/415773b6-531b-48d8-90ff-178984d30024" /> Aplica um flip horizontal no tile.

- <img width="40" src="https://github.com/user-attachments/assets/ca4903b8-cc21-46bb-8974-bbf00a3d7765" /> Aplica um flip vertical no tile.

- <img width="40" src="https://github.com/user-attachments/assets/0a185904-ee33-464f-9782-c61853a7aed3" /> "Picker tool". Você clica no tile no canvas e ela muda a seleção para este tile. É só uma ferramenta de seleção, mas em vez de catar o tile no atlas, você seleciona direto da cena. Serve para agilizar o trabalho.

- <img width="40" src="https://github.com/user-attachments/assets/3a60ae08-5f7c-491c-ac17-ec9f71ba85c3" /> Você vai apagar tiles de acordo com a maneira de desenhar da ferramenta selecionada. Por exemplo, se estiver com a borracha e a ferramenta de retângulo selecionado, você pode apagar em formatos retângulares de qualquer tamanho.

- <img width="140" src="https://github.com/user-attachments/assets/3a940f6e-00d7-4a13-83b1-e9c6c823b019" /> Pode aplicar ou não a ferramenta de desenho na região selecionada. Quanto maior o *Scattering*, maior a probabilidade de não desenhar. Um exemplo de aplicação seria você fazer uma linha de tiles de árvore, mas você quer que apenas algumas sejam desenhadas, para parecer mais orgânico.

> PS: O parâmetro *Scattering* varia entre 0 (probabilidade 100% de desenhar) até 1000 (probabilidade quase 0% de desenhar). A fórmula é $\frac{1}{1 + Scattering}$ para a probabilidade de desenhar um tile. Apesar de ser uma escala estranha, isso é para ter um controle maior para probabilidades perto de 0%. Em particular, note que para *Scattering* $=1$ a probabilidade é de 50%. 
 
Todas essas funcionalidades não precisam ser aplicadas a uma única seleção de tile. Com a ferramenta de seleção <img width="40" src="https://github.com/user-attachments/assets/222a15e5-dbbd-4e89-864d-56c7e3af3aae" /> você pode ir no atlas e selecionar múltiplos tiles ao mesmo tempo (use o shift para isso). Depois escolha a sua ferramenta de desenho e experimente. No exemplo abaixo nós selecionamos a ferramenta de desenhar segmentos de reta. Note o que a preview mostra, é possível desenhar uma linha reta em diagonal de um conjunto de tiles selecionados. As possibilidades que temos a partir disso são enormes, basta ter criatividade e visão!

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/80194def-9be2-4f4e-a3c3-0d3b96cd8bfd" />
</p>

A ferramenta de seleção não serve apenas para o atlas, você também pode selecionar tiles na cena, e então movês-los, deletá-los, etc. 

## Patterns

Até agora estávamos na aba *Tiles* do editor. Vamos trocar para a aba *Patterns*, logo ao lado. Com a ferramenta de seleção, selecione uma região do tilemap no canvas e pressione ctrl+C. Depois, no editor, faça ctrl+V. A sua seleção vai ficar armazenada na lista do *Patterns*. Fizemos dois exemplo abaixo. O primeiro de uma seleção retangular e o segundo escolhendo ponto a ponto.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/6f18b7de-1c14-41f5-98b1-954d73b66863" />
  <img width="500" src="https://github.com/user-attachments/assets/438fad1d-1cb9-4a70-b3ae-2181d89d051a" />
</p>

O legal disso é que cada um desses padrões escolhidos podem ser utilizados nas mesmas ferramentas descritas anteriormente, como se fossem tiles. Por exemplo, escolhemos o primeiro padrão e a ferramenta de desenho retangular para preencher uma região retangular com este padrão. Veja como ficou o resultado. Na esquerda o original e na direta o resultado com o preenchimento retangular do padrão. Novamente, este é um exemplo abstrato, mas com criatividade e visão você pode fazer muitas coisas legais com isso.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/060034bf-6cfa-48fd-8cf0-dfdd99d2d80b" />
</p>

Só para dar um exemplo concreto, criamos um padrão de quadriculado $2 \times 2$ e usamos a ferramenta de senho retangular para criar um tabuleiro. 

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/d01f9ea9-aab8-41a0-97a5-5471fe0d616c" />
</p>

## TileSets

Vimos bastante sobre como desenhar os tiles na cena, que é manipulação do atlas e suas ferramentas na aba *TileMap* do editor. Porém, note que ao lado dela temos também a aba *TileSet*. Enquanto a *TileMap* trata de desenhar os tiles na cena, a *TileSet* trata de configurar os tiles. Veremos nesta seção que dá para fazer muito coisa sobre os tiles antes dele serem desenhados.

### Propriedades do TileSet no Inspector

Todas as propriedades mostradas na figura dizem respeito ao TileSet. Vamos dar uma olhada no significado delas.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/7ab948b9-f816-4d78-8e74-0c7bbe40da6d" />
</p>

- **Tile Shape:** Até agora só vimos tiles quadrados, mas eles podem ter outros formatos que atendem a outros tipos de layouts de jogos.

- **Tile Layout:** Um segundo nível de layout. Depende da escolha da opção acima.

- **Tile Offset Axis:** Se o layout acima estará orientado pelo eixo $x$ ou $y$. Tem que testar para decidir se vai usar.

- **Tile Size:** Essa nós já vimos anteriormente, são as dimensões do tile na tilesheet, em pixels.

### Aba Setup

Todas as propriedades mostradas na figura dizem respeito ao atlas selecionado. Vamos dar uma olhada no significado delas.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/31584674-9a67-4218-bce5-8f5bb07e981b" />
</p>

- **ID:** Identificador único do atlas. É preferível não mudar e deixar a engine fazer a ordenação automática.

- **Name:** O nome do atlas. O usuário pode escolher o nome que quiser para identificar pelo nome o atlas.
  
- **Texture:** O arquivo do tilesheet.
  
- **Margins:** Desloca toda a divisão quadricular do atlas no eixo $x$ ou $y$. É útil quando ele vem originalmente com margens. 

- **Separation:** Cria um vão entre os tiles, deixando uma camada de transparência entre eles.

- **Texture Region Size:** Tamanho dos tiles no atlas. Em geral este valor será igual ao que você definiu com *Tile Size* (visto acima), mas você pode querer alterar aqui. O *Tile Size* define o atlas, enquanto que este pode ser visto como uma deformação posterior do atlas.

- **Use Texture Padding:** Adiciona um pixel de transparência ao redor de cada tile. Isto ajuda a prevenir o efeito de "texture bleeding", que é quando alguns pixels do tile podem "vazar" para os tiles vizinhos. Isto não acontecerá para tiles fixos vindo de um TileSet bem configurado, mas podem surgir artefatos quando há efeitos de luz, deformação, colisão, entre outros.

Quando estiver mexendo com *Margins, Separation* e *Texture Region Size*, lguns tiles podem desaparecer. Para garantir que isso não aconteça, selecione a opção *Create Tiles in Non-Transparent Texture Regions* mostrada abaixo.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/a1875f5f-90af-4331-bf5a-5ea4c96e5a45" />
</p>

### Fusão de atlas

Você pode vários atlas no mesmo TileSet. Em alguns casos pode ser mais conveniente fundir os atlas em um único. Para isso, selecione a opção *Open Atlas Merging Tool* como mostrado abaixo.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/4dbc82ed-506f-45fa-8488-9bfdd78aa228" />
</p>

Isto vai abrir a janela mostrada abaixo. Agora basta selecionar os atlas que você quer fundir e selecionar uma das opções abaixo. DAlém disso, dependendo de como você configura a opção *Next Line After Column*, os atlas podem ficar alinhados horizontalmente ou verticalmente caso sejam só 2 atlas. Se forem mais atlas, você pode ainda ter um retângulo de atlas. É questão de testar os valores.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/36ded95d-e519-4cbf-a51f-63752f95c8a5" />
</p>

### Aba Select

Na aba *Select* (selecionada em azul, ao lado de *Setup*), temos as propriedades mostradas abaixo. Vamos explicar algumas delas abaixo.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/7c23a17f-ab4e-4c54-b39f-14f8a6a215cf" />
</p>

- **Atlas Coords:** São as *coordenadas do tilemap* que vimos no início deste tutorial. Não é editável.

- **Size in Atlas:** Tamanho do tile em termos das coordenadas do tilemap. Não é editável.

- **Rendering/Texture Origin:** Altera a posição do centro do tile.

-  **Rendering/Modulate:** Altera a coloração do tile.

### Colisão 

Para poder adicionar colisão aos tiles, primeiro você deve criar uma camada de física indo em *Add Element* no *Physics Layers*, como mostrado abaixo. Ao fazer isso, vai aparecer mais coisas, mas você não precisa mexer nelas. 

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/dab1ca88-1997-4481-a432-0b97d4656fc3" />
</p>

Feito isso, vá para a aba *Select* no editor e selecione algum tile. Note que a opção *Physics* está disponível. Agora abra esta aba até encontrar a janela *Polygons*, mostrada abaixo, na imagem à direita. Usando as ferramentas de edição logo acima, você pode criar e editar shapes poligonais de colisão para o tile. O funcionamento destas ferramentas de edição é análogo ao visto em [Polygon2D e CollisionPolygon2D]([https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Path2D](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Path2D)). 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/56d20c52-5766-457e-8bce-a7e13b97fb26" />
  <img width="220" src="https://github.com/user-attachments/assets/15cb3d9c-a702-4438-9bd1-400919843ef9" />
</p>

> Dica: Geralmente é mais conveniente começar já com um quadrado de colisão selecionado, ocupando os 4 vértices do tile. Para isso, basta clicar no tile, dentro da parte de edição, e apertar F.

### Navigation e light occlusion para o TileSet

O modo de adicionar e customizar estas propriedades para os TileSets é inteiramente análogo ao que fizemos para colisão. A maior diferença é o ponto de partida. Enquanto na colisão nós adicionamos física, os outros requerem interação em outras abas.

<p align="center">
  <img width="180" src="https://github.com/user-attachments/assets/1d63b176-7fff-4b58-9afd-31b596c1fce5" />
</p>

### Metadados

É possível adicionar metadados aos tiles individualmente ou em grupo. Por exemplo, poderíamos ter um tile de lava, daí teríamos um metadado tipo *damage* $= 15$. O metadado em si não faz nada, é apenas uma informação para ser acessada. Note que outros nodes, como `Sprite2D`, não possuem isso, então seria necessário criar um dicionário para gerar metadados para estas estruturas. OS tiles possuem tratamento diferenciado pois eles foram feitos para serem tratados em quantidade. Portanto a engine está otimizada para acessar mnetadados de conjuntos grandes de tiles, mas para um conjunto grande de `Sprite2D`, por exemplo, pois cada `Sprite2D` é uma entidade única e separada das outras. 

Para poder adicionar metadados, primeiro clique na aba *Custom Data Layers* e depois em adicionar para ir adicionando cada um dos metadados. Abaixo temos um exemplo simples com a criação de dois metadados. O primeiro é o *damage*, do tipo *int*. O segundo é o *insta_kill*, do tipo *bool*. 

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/e905f17c-a0b7-472a-9fe9-8c2fd25f4583" />
</p>

Note que estes metadados foram criados para o TileSet inteiro. Ou seja, eles serão acessíveis por todos os atlas que você colocar ali. Inclusive, na aba *Select* no editor, você pode reparar que a aba *Custom Data* já apareceu automaticamente, incluindo os metadados que você criou (a engine sempre atribui valores default para cada tipo de variável). No exemplo da imagem abaixo, podemos ver que é possível configurar os metadados para cada tile individualmente. Este valor fica evidenciado no próprio atlas, à direita da imagem.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/63a6df85-d21b-4606-aa08-032a951428b4" />
</p>

### Aba Paint

Esta aba é simples. Basta escolher uma propriedade que você quer "pintar" no atlas. No exemplo abaixo nós escolhemos o metadado *damage*. Vamos supor que queremos inserir *damage* $=25$ em diversos tiles. É só escrever o valor e no próprio atlas você clica com o mouse, se gura o clique, e percorre com o mouse sobre o atlas. Você vai notar que ele começa a "pintar" o valor $25$ por onde você passa com o mouse clicado. Esta é a funcionalidade desta aba.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/465a1466-76e5-402b-af3d-4e276ccb1699" />
</p>

Outra maneira de se fazer múltiplas atribuições de valores é indo na aba *Select*, selecionando vários tiles e alterando o valor para o que você quer. É menos dinâmico que pintar os valores, mas se for um conjunto retangular e grande de tiles, por exemplo, é mais prático. Depende de cada caso qual o modo de atribuição múltipla você vai utilizar.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/70890641-de50-4ee6-8810-1e4904fb5b2d" />
</p>

### Tiles alternativos

Para criar um tile alternativo, basta dar o segundo clique em algum tile e selecionar *Create Alternative Tile*. Feito isso, note que em *Rendering* ele possui algumas propriedades extras que podem ser modificadas.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/19015b3f-2fa8-432b-9d62-f9f7ff700a06" />
  <img width="500" src="https://github.com/user-attachments/assets/06bc2ef7-3afc-4978-8bbf-5bdab6eb1e1d" />
</p>

> PS: Tiles alternativos possuem um ID alternativo, como pode ser visto na imagem. É recomendado não alterar este valor. Deixa o automático da engine dar conta da ordenação.
