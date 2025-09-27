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
  <img width="700" src="https://github.com/user-attachments/assets/a6e96d2f-8a2f-491b-ab52-99d32d094758" />
</p>

Agora precisamos voltar ao *State Machine* para definir como sair do Start. Selecione a transição entre o *Start* e o *BlendSpace2D* e em *Inspector → advance → Expression* coloque a expressão `get_parent().velocity.length() > 0`. Devemos colocar este `get_parent()` na frente pois a velocidade não é do `AnimationTree` e sim do seu pai. Não conecte nada ao *End*, senão ele vai encerrar a *State Machine*. A ideia é que fique no *BlendSpace2D* durante o jogo inteiro.

Assim como fizemos [neste tutorial](https://github.com/felipebottega/Games/blob/gh-pages/Manual/Animation/Using%20AnimationTree/README.md), vamos introduzir uma variável auxiliar no script para memorizar a última direção não-nula. A partir disso, direcionamos as animações baseado na última direção não-nula do jogador. É importante ter em mente que isso não vale para a movimentação, apenas para a animação. Depois de vários ajustes, chegamos no código final.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/19d4a212-469f-471f-ae26-5b3848443cad" />
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
