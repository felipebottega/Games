# Saving games

Este tutorial será mais extenso que o normal, pois vou mostrar as etapas da criação de um próximo jogo. Além de ser interessante a ideia de salvar e carregar em jogo (em vez de um exemplo avulso), também é um bom momento para colocar em prática tudo o que aprendemos e refrescar a memória.

## Cenário inicial

A ideia é fazer um jogo voltado para a dinâmica de pulos. O personagem principal, que é um gafanhoo, deve chegar até um local, e só é possível fazero caminho pulando. 

Vamos utilizar os assets [sunnyland-tall-forest-environment](https://opengameart.org/content/sunnyland-tall-forest-environment) para o cenário inicial do jogo. Este conjunto de assets possui um pequeno TileSet e alguns sprites. 

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/575c675d-31cb-437e-be3b-01493c1cee05" />
</p>

Como certos sprites serão colocados em muitas partes do cenário, é mais interessante utilizá-los como tiles. Apesar do TileSet ser $16 \times 16$, precisamos customizar os tamanhos dos sprites, que são diferentes. Para isso, altere o valor de *Texture Region Size* até ficar adequado. Ao fazer isso, há uma chance de quadrados vazios serem marcados no tilemap. Você deve removê-los indo nos três pontinhos indicados na figura abaixo e selecionar *Remove Tiles Outside the Texture*.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/b21f85d1-8526-4268-9781-93a71a4a024b" />
</p>

Depois disso é só questão de editar os sprites e montar o cenário do jeito que achar melhor. Por enquanto está assim.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/c38deabf-846a-4647-ad2a-ee9af523477e" />
</p>

## Personagem

O jogo se baseia em um gafanhoto pulante, então começamos a cena com um `CharacterBody2D` do gafanhoto. Em relação ao seu `CollisionShape2D`, note que ele diminui quando o personagem está no ar. A ideia é aumentar a dificuldade do jogo ao exigir mais precisão do jogador ao parar nas plataformas. Pelo script, você pode ver que a gravidade é acentuada nas quedas também. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/14bde098-6876-4db7-8b55-00edbe24bf7d" />
  <img width="300" src="https://github.com/user-attachments/assets/d612e0ad-162c-4572-a583-0ddb60d32fd1" />
</p>

Começamos utilizando o script default que vem com `CharacterBody2D` e inserindo as animações no `AnimatedSprite2D`, mas agora vamos mudar isso, pois iremos usar as ferramentas de `AnimationPlayer`. Seguindo os passos do [tutorial de animação](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Introduction%20to%20the%20animation%20features), adicionamos um node `AnimationPlayer` e começamos criando uma nova animação, chamada *idle*.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/f8385592-ae12-4e53-aa70-b7e43f47927f" />
</p>

Agora vamos seguir a seção [AnimationPlayer com diversas spritesheets](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Using%20AnimationTree#animationplayer-com-diversas-spritesheets) de um tutorial de animação para gerar a animação no `AnimationPlayer` a partir do `AnimatedSprite2D`. Adicione uma track e selecione o Property Track sobre a propriedade *animation* do AnimatedSprite2D. Agora insira um keyframe no instante inicial com o valor "idle". Adicione mais uma *Property Track*, desta vez será a propriedade *frame* do `AnimatedSprite2D`. Insira um keyframe no instante inicial com o valor 0 e depois insira o último no dim da animação e coloque o *Update Mode* para contínuo. Assim, ele vai variar entre todos os frames no intervalo. Feito isso, repetimos o procedimento para as outras animações. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/cefd5c7b-588d-471a-a607-9ab2593ca144" />
</p>

Vamos para a parte funcional do personagem. Adicione um AnimationTree como filho do `CharacterBody2D`. A ideia será criar um *AnimationNodeBlendTree contendo um node *State Machine*. Comece associando o `AnimationTree` ao `AnimationPlayer` através da propriedade *Anim Player*, como mostrado abaixo.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/fe65f362-3605-43e2-9acf-14009a548016" />
</p>

No *State Machine*, clique em *Open Editor* para começar a edição. Dentro do *State Machine*, adicione um node do tipo *BlendSpace2D* e clique para começar a edição dentro dele. Crie 6 pontos, um para cada animação (*idle_left, idle_right, jump_left, jump_right, walk_left, walk_right*). Coloque o modo blend como discreto e se certifique de que a conexão entre o *Start* e o *BlendSpace2D* do *State Machine* é do tipo *Immediate*.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/4cbf2bfe-2835-49cd-9444-847ceed4a73b" />
  <img width="900" src="https://github.com/user-attachments/assets/d1d24e36-369e-45ec-a390-a3b6e57f8e5a" />
  <img width="900" src="https://github.com/user-attachments/assets/dd2df39f-3fd1-43bb-8804-adeda42d5e29" />
</p>

Depois disso, atualizamos o script de acordo. O scritp mostrado abaixo é uma primeira versão funcional. Ele ainda passará por mais mudanças.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/a6e96d2f-8a2f-491b-ab52-99d32d094758" />
</p>

Agora precisamos voltar ao *State Machine* para definir como sair do Start. Selecione a transição entre o *Start* e o *BlendSpace2D* e em *Inspector → advance → Expression* coloque a expressão `get_parent().velocity.length() > 0`. Devemos colocar este `get_parent()` na frente pois a velocidade não é do `AnimationTree` e sim do seu pai. Não conecte nada ao *End*, senão ele vai encerrar a *State Machine*. A ideia é que fique no *BlendSpace2D* durante o jogo inteiro.

Assim como fizemos [neste tutorial](https://github.com/felipebottega/Games/blob/gh-pages/Manual/Animation/Using%20AnimationTree/README.md), vamos introduzir uma variável auxiliar no script para memorizar a última direção não-nula. A partir disso, direcionamos as animações baseado na última direção não-nula do jogador. É importante ter em mente que isso não vale para a movimentação, apenas para a animação. Depois de vários ajustes, chegamos no código final.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/19d4a212-469f-471f-ae26-5b3848443cad" />
</p>

## Paralaxe

Queremos adicionar um efeito paralaxe no background de floresta mostrado anteriormente. A ideia é que ele está bem distante, então enquanto o player vai subindo, o fundo se move pouco para cima. Para obter este efeito, colocamos o background como filho do node `Paralaxe2D` e alteramos a propriedade *Scroll Scale.y* para $0.07$. Note que deixamos o *Scroll Scale.x* igual a $1$. Isso significa que lateralmente o sprite não se move junto com a câmera. Fizemos isso pois essa cena inicial ocupa uma única tela lateralmente e não será usada em outros lugares.

<p align="center">
  <img width="150" src="https://github.com/user-attachments/assets/1e21b7e1-976d-4c0b-a9ee-e2ca2eeb1572" />
  <img width="200" src="https://github.com/user-attachments/assets/15c4db16-1028-4334-bc5d-3f97b8417c5e" />
</p>

## Segundo cenário

Para a continuação do jogo, utilizaremos os assets [fort-of-illusion](https://opengameart.org/content/fort-of-illusion). Não tem nada de muito especial nessa cena, são duas camadas de tilemaps.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/40b442bc-5cd0-4e5f-853c-0a21267dcaf8" />
</p>

Vale a pena chamar a atenção para uma técnica utilizada. Nós colocamos as figueiras em um nível mais à frente que tudo no jogo. Isso aumenta a sensação de profundidade no jogo. Para obter este efeito, alteramos a propriedade *Z Index* no *Inspector*. Por default, todas os nodes ficam no nível 0, então um node com um número maior fica mais à frente da câmera. Vimos um pouco deste assunto [neste tutorial]().

<p align="center">
  <img width="200" alt="image" src="https://github.com/user-attachments/assets/57f2e406-f1dc-4302-92a6-8ebea76330d3" />
</p>

## Background geral

A parte da floresta teve o seu background próprio co efeito de paralaxe, mas assim que saímos da floresta temos um background do céu. A ideia é que este seja um único background para o restante do jogo todo. Ele começa com um céu azul e montanhas ao fundo e, conforme vamos subindo, ele escurece, estrelas aparecem, e termina com uma Lua cheia no topo. Este grande background também possui efeito paralaxe, se movendo pouco tanto na direção horizontal quanto vertical conforme o jogador se locomove pelo cenário. 

A resolução do jogo é $500 \times 600$. Vamos nos contentar em fazer um background de $1200$ pixels de largura (supondo que o dobro será rolado pelo paralaxe). A altura precisa ser mais extensa. O background da floresta tem $800$ pixels de altura e conseguiu dar conta de $4000$ pixels através da paralaxe. Estimo que o jogo terá uns $18000$ pixels de altura. Isso significa que esse background geral precisará de $18000/5 = 3600$ pixels de altura. 

> PS: Por ser uma imagem grande, toda vez que eu a editava no GIMP, a engine não atualizava e acusava que não tinha conseguido carregar a imagem. Faça o *Reimport* para esses casos.

No fim das contas, a cena do background é um `Node2D` contendo paralaxes. Ambas as paralaxes tem os mesmos *Scroll Scales*, de acordo com as contas feitas acima. A diferença é que o *ParallaxClouds* tem um efeito adicional, o *Autoscroll*. Vimos sobre este parâmetro no [tutorial de paralaxe](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20Parallax). Além dos sprites acompanharem a tela (com um certo efeito de atraso do *Scroll Scale*), eles também se movimentam a uma taxa constante na direção $x$. Isso simula perfeitamente nuvens distantes que estão se movendo. As nuvens e as árvores vieram do [seamless-hd-landscape-in-parts](https://opengameart.org/content/seamless-hd-landscape-in-parts).   

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/6fa2bbb7-c7e5-49c8-9294-af47a0011020" />
</p>

Poderia ter paralaxe nas árvores também, mas como elas estão muito secundárias no background, não valeu o esforço.

## Terceiro cenário

A tore vem logo após a parte da ponte e é constituída dos mesmos tiles utilizados para o cenário da ponte. 

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/c50adf74-2aaf-4905-a12d-2364902bfafe" />
</p>

À primeira vista, não está muito claro porque utilizamos 3 TileSets. Mostramos abaixo os 3 separados. O primeiro TileSet (da esquerda) corresponde ao que deve ficar mais ao fundo, é nele também que estão as plataformas com colisão. O segundo TileSet é constituído dos ornamentos da cena, e devem ficar mais à frente do primeiro TileSet. O terceiro é constituído das paredes verticais da torre. Estas paredes não possuem colisão, são apenas para dar um efeito de profundidade ao personagem passar por trás delas no jogo (tivemos que *Z Index* $=1$ para isso). Toda a colisão vem de uma outra parede por trás que veio do primeiro TileSet.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/09f2d86b-816d-48d6-9a7e-9ec0a6331136" />
  <img width="300" src="https://github.com/user-attachments/assets/de3f6327-56e7-46e4-8f33-34896c018ab3" />
  <img width="300" src="https://github.com/user-attachments/assets/5676919c-7126-4749-b18a-e9f19c1cad6c" />
</p>

Note que o chão possui colisão, mas logo acima na parede temos o mesmo tile do chão saparecendo novamente, só que sem colisão. Para conseguir isso basta criar tiles alternativos e não colocar colisão neles.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/3465bebc-5cc1-4baa-9b6a-4e5cbaf93644" />
</p>

## Último cenário

Uma coisa que eu não comentei antes e é relevante é que você copiar nodes de outras cenas dando o segundo clique do mouse e selecionado para copiar. Depois vá para a cena onde você quer colocar o node e seleciona para colar. Também pode simplesmente fazer o famoso *Ctrl+C* *Ctrl+V*. Inclusive eu fiz isso no cenário da torre, uma vez que estava reutilizando o node de tiles da cena da ponte.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/d8bd6d57-0012-45cc-aa97-2f3b2edc3992" />
  <img width="300" src="https://github.com/user-attachments/assets/de21a3dd-62ca-48d7-af0b-3fbba5f06f3f" />
</p>

> PS: Essa cópia vai trazer junto toda a sua montagem de tiles. Você pode deletá-los sem medo, o node original não está associado a este novo.

Depois de passar por algumas plataformas, o jogador vai se deparar com uma área que possui partículas e um node `Area2D` que detecta quando o jogador entra na área. A ideia é que esta esta região envia um sinal para a cena do jogo, e lá o jogo vai acrescentar uma velocidade vertical para o jogador. Ao ser impulsionado para cima, ele vai se deparar com as plataformas finais do jogo.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/e5bb88c9-113c-4e0b-952e-f2c7b0d69658" />
</p>

Para criar este sinal, vamos utilizar o aprendizado do [tutorial 3 de sinais](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Using%20signals/Signals%203). Começamos criando um script no node raíz da cena. Como variável global do script, definimos `signal area`. No node `Area2D`, vamos para o *Inspector → Node → body_entered* para criar a função que se ativa quando um corpo entra na área. Dentro desta função apenas adicionamos a linha `area.emit()`. Isso vai emitir um sinal que será recebido pelo node pai do jogo (*level*) que contém essa cena do céu. É na cena pai que iremos aplicar as forças.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/3da9f23f-04b6-4acf-bda8-0694e64c2ac0" />
</p>

Agora na cena do jogo (*level*), podemos ver que o node filho *Sky* possui o sinal customizado *area*. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/a191c87d-f17e-44cd-a5e2-7b3f5c937a3a" />
</p>

## Queda no abismo

### Problemas ao inserir novas animações no AnimatedSprite2D

Ao tentar inserir mais uma animação no `AnimatedSprite2D`, eu só consegui inserir o objeto mas não consegui manipular a animação nova. Isso pode acontecer quando se está trabalhando com o `AnimationPlayer` junto. Nesses casos, tente fechar e abrir a engine, e tente mudar as animações do `AnimationPlayer`, terminando na RESET. Isso também foi mencionado na seção de AnimationNodeStateMachine [deste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Using%20AnimationTree).

### Animação nova

Depois de inserir a animação nova no `AnimatedSprite2D`, é hora de ir para o `AnimationPlayer`. Adicione essa animação nova que nem foi com as anteriores. Quando ele cai no abismo, exibimos essa animação nova de explosão de sangue. A animação só ocorre uma vez, sem loops. Porém, o `AnimationPlayer` trava no último frame até a animação se alterar. Existem várias maneiras de se resolver isso. Nós utilizamos o método mostrado abaixo. Ele consiste de animar a propriedade *modulate* também, no método discreto. Nós repetimos o último frame da animação, mas apenas neste último o alpha do *modulate* é alterado para deixar o frame invisível. Então é como se a animação toda tivesse rolado normalmente e depois sumido.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/d741e437-c2c6-427e-a71a-ef411aa67500" />
</p>

### Transição para o cenário inicial

Depois que o personagem caiu no abismo e explodiu, queremos um efeito de *fade-out fade-in* em preto. Ou seja, escurecer a tela e depois voltar, com o personagem no cenário do início do jogo. 

Para ter a animação dentro da nossa *State Machine*, adicionamos um node de animação e o conectamos com o *BlendSpace2D* que já havia antes. Para ir do *BlendSpace2D* para a animação, a condição `get_parent().position.x > 650 and get_parent().position.y > -750` deve ser satisfeita. Para ir da animação de volta ao ao *BlendSpace2D*, usamos a transição do tipo *At End*, pois essa espera a animação acabar para fazer a transição.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/9c7b6df0-e163-46ff-9a0d-a34b4334163d" />
  <img width="300" src="https://github.com/user-attachments/assets/67621d24-1ed3-4a65-af68-c48f8a799e9c" />
</p>

No script do player, adicionamos um bloco para lidar com essa animação. Note que ele trava aposição $y$ em $-750$ pixels de altura e zera a velocidade. Isso é necessário para cancelar os efeitos da física e gerar a animação na mesma posição. Depois disso ele emite um sinal. Este sinal é captado pelo node do jogo, que vai então executar o script de *fade-out fade-in*. Fizemos este efeito com código, mas seria possível também ter um `AnimationPlayer` animando o *modulate* da cena do jogo.  

<p align="center">
  <img width="350" height="188" alt="image" src="https://github.com/user-attachments/assets/2caae1f2-bcca-4e4f-8248-42263c5ed089" />
</p>

## NPCs e checkpoints

Este jogo contém 3 NPCs, cada um dando dicas sobre como prosseguir e  às vezes soltando algumas falas engraçadas. Além das dicas, cada NPC é um ponto a ser marcado como checkpoint no jogo. Caso você caia no abismo, volta para o último checkpoint registrado, ao lado do respectivo NPC. As falas dos NPCs são feitas com nodes `Label`, e seu gerenciamento se dá através de variáveis globais no autoload.

O script pertence ao arquivo *manager.gd* do autoload, que está associado à cena *Manager*, também no autoload. Ele informa ao jogo os NPCs que já foram vistos (variável que será usada para os checkpoints), se o jogador deve ficar imobilizado ou não (durante conversas) e se ele está perto de algum NPC ou não (para ser capaz de começar uma conversa com o botão de ação).

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/4f6ccb4f-44d3-479e-87d7-6ce39d6cb0c2" />
</p>

Podemos ver abaixo como se dá a troca de informação entre o script do jogo, *level.gd*, e o do autoload, no que diz respeito a distância entre o jogador e os NPCs. Caso a distância seja menor que $200$ pixels, consideramos que o jogador está perto o suficiente do NPC, então ele pode falar com este NPC.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/7260823d-19eb-4997-b1eb-9dd37d9f3543" />
</p>

Para a questão dos checkpoints, há uma função que reposiciona o jogador sempre que ele cai no abismo. Note que esta função escolhe a posição baseado na variável *status*, que é justamente a variável que diz qual o último NPC com o qual o jogador interagiu.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/e3ecf2d5-32a8-4bd8-b9d1-1738dc4db195" />
</p>

Os NPCs do jogo vieram destas fontes: 

https://monopixelart.itch.io/forest-monsters-pixel-art 

https://penzilla.itch.io/free-animated-protagonist 

https://penzilla.itch.io/animated-protagonist)

## Save game

Para praticar o save game e load game, estes checkpoints também serão salvos de maneira permanente. A ideia é que o menu terá a possibilidade de começar o jogo a partir de algum checkpoint (*Parte I - Floresta, Parte II - Ponte, Parte III - Torre*). Para isso ser possível, é necessário salvar os checkpoints quando passamos pelos respectivos NPCs.

O método de save que iremos ver apenas salva propriedades/atributos de nodes. Existem outros métodos de salvar mas este é o mais seguro. Devemos criar um grupo, colocar os nodes desejados neste grupo, e então salvamos as propriedades que queremos através de uma função em cada node do grupo. As informações destas propriedades ficam armazenadas em um arquivo localizado na pasta do `user://`. Vimos osbre isso no tutorial [File paths in Godot projects](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/File%20paths%20in%20Godot%20projects). 

Neste exemplo, queremos apenas salvar algumas variáveis do *Manager* (lembrando que apenas dados de cenas podem ser salvas). Criamos um node global novo para gerenciar os saves e loads. Este gerenciamento em teoria pode ser feito por qualquer cena, desde que ela não seja uma das cenas salvas (isto dá conflito, pois a cena é deletada antes de ser carregada a nova).

<p align="center">
  <img width="950" src="https://github.com/user-attachments/assets/26ec53c8-a613-4bd4-8676-f8e6eb8f7527" />
</p>

Crie um grupo global e coloque as cenas que quer salvar no grupo. Na hora de salvar, a função vai passar por todas as cenas deste grupo. 

<p align="center">
  <img width="150" src="https://github.com/user-attachments/assets/3a77effa-b46a-4c90-a637-18df184ead4a" />
</p>

Apesar do sistema de save ser igual para todos, há dois tipos de grupos para diferenciar na hora do load. Em resumo, os nodes das cenas normais são removidos e depois colocados de volta na cena, com as propriedades do load carregadas, enquanto que nodes das cenas do autoload apenas tem suas propriedades atualizadas. Não se pode remover nada de autoload e carregar depois novamente.

A função geral de save percorre todos os nodes do grupo e extrai as propriedades que deverão ser salvas. Ela é independente de caminho e local de onde foi chamada. A única coisa que os nodes a serem salvos precisam é de uma função `save` retornando o dicionário das propriedades a serem salvas. É interessante chamar a função de save nos pontos de save de fato. Isso ocorre quando o jogo encontra um NPC e incrementa a variável global *state*. Abaixo segue a função geral de save.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/77053c2e-3e3f-4ec4-816e-007380aaa15d" />
</p>

Abaixo segue a função que retorna o dicionário das propriedades a serem salvas. Ressaltamos que as propriedades *filename*, *parent* e *index* são obrigatórias. A função `save_game` acima só precisa estar em um script. A função `save` abaixo tem que estar em todos os nodes do grupo, pois a função `save_game` vai varrer este grupo para buscar estes dicionários.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/06bc2dc6-71f6-4c5f-bf67-86fb60406e49" />
</p>

## Load game

Como mencionamos anteriormente, há dois grupos: "Save" e "SaveAutoload". O primeiro se refere aos nodes que serão carregados de maneira normal, enquanto que o segundo se refere aos nodes no autoload. Mostramos abaixo as duas funções de load.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/abe2780b-9d30-41fb-bc78-29bfca7f8b1f" />
  <img width="700" src="https://github.com/user-attachments/assets/a0252deb-6bd8-4c08-8c33-f17f906f2094" />
</p>

> ⚠️ Aviso: Não coloque a função de load game em uma cena que será atualizada com o load. Se fizer isso, vai entrar em um loop infinito. O mais adequado é colocar a função na cena *SaveLoad*, que foi feita especificamente para gerenciar estas coisas e não depende delas.


## Final do jogo

O jogo acaba quando o jogador pega o cálice do céu. Aliás, este cálice é um asset de [free-pirate-stuff-pixel-art-icons](https://craftpix.net/freebies/free-pirate-stuff-pixel-art-icons/). Neste instante, o script abaixo é executado. Ele pausa todo o movimento do jogador e toca a animação de créditos.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/b6424ebf-635b-4618-9d4a-12c0d3276064" />
</p>

A animação tocada é o `AnimationPlayer` mostrado abaixo. A primera track é um *modulate* na cena do jogo que espera $2$ segundos sem fazer nada e depois começa a escurecer a tela. Este escurecimento é só no vermellho e verde, mantendo o azul intacto. Isto tem o efeito de deixar o personagem escurecido contra a luz a Lua, o que dá um efeito bonito. As tracks seguintes manipulam propriedades da cena dos créditos, que é um `CanvasLayer`. A propriedade *transform* é a mesma discutida no [tutorial de Canvas Layer](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Viewport%20and%20canvas%20transforms), é aquela matriz $\left[ e_1, e_2, v_o \right]$. Para este jogo nós animamos apenas a variável $y$ do $v_o$, para fazer subir o texto contendo os créditos. É importante lembrar que um node `CanvasLayer` nunca "funciona" nas coordenadas globais. Ele não tem posição no mundo, mas sim na tela diretamente. A outra propriedade que manipulamos foi a de deixar visível os créditos, pois eles entram invisíveis na cena do jogo.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/aea5768e-e3e4-44c1-a56d-e9a76177f1ac" />
  <img width="500" src="https://github.com/user-attachments/assets/40a98016-faf4-425a-a1cc-3bff3c3a1141" />
</p>

## Menu

O nosso menu é apenas um `Sprite2D` com botões e efeito de partículas para ficar bonitinho. O interessante aqui é a parte de load game, que é o aprendizado que queríamos aplicar desde o início.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/772451d6-2224-4d8b-a453-b3100f9ec101" />
</p>
