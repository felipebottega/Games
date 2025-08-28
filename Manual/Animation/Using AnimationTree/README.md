# Using AnimationTree

Vimos que o `AnimatedSprite2D` é uma maneira direta e simples de criar animações a partir de uma spritesheet. Essa simplicidade é acompanhada de limitações, ou seja, não dá para fazer muita coisa complexa com este node. O `AnimationPlayer` é uma ferramenta muito mais completa para animações. Não só animações de sprites, mas de propriedades, funções, sons, entre outros. Neste sentido, o `AnimationPlayer` não é simplesmente uma ferramenta de animação, mas sim um editor visual e versátil de diversos objetos de Godot. 

O `AnimationTree` não faz animação nenhuma. Ele é uma camada de abstração extra ao `AnimationPlayer`, ou seja, é um conjunto de ferramentas visuais para combinar e manipular diversas instâncias do `AnimationPlayer`. A princípio não é muito claro o que o `AnimationTree` faz, seu papel vai ficar mais claro conforme formos evoluindo neste tutorial. 

## AnimationPlayer com diversas spritesheets

No [primeiro tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20sprite%20animation#animationplayer) sobre `AnimationPlayer` vimos como inserir uma spritesheet no node para executar. Naquele momento do aprendizado aquele approach fazia sentido, mas ele é limitado, pois só permite inserir uma spritesheet. Se você repetir o procedimento com outra spritesheet em outro `Sprite2D`, vai notar que as duas animações ficam na tela ao mesmo tempo. Isso acontece pois são nodes separados. Com este approach você teria que criar (manualmente) uma lógica para ocultar uma animação quando outra começa.

O approach correto é começar criando um `AnimatedSprite2D`, como se faz normalmente. Foi o que fizemos no exemplo mostrado abaixo. Utilizamos os sprites do terceiro personagem [neste](https://craftpix.net/freebies/city-man-pixel-art-character-sprite-sheets/) pacote de sprites.

> PS: Lembre-se de que só é possível usar o node `AnimationPlayer` para manipular outros nodes estejam na mesma cena.  

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/1c184770-3a8f-4103-bc23-98a32b4e20c2" />
</p>

Agora crie um `AnimationPlayer` e clique no *Animation* no painel de edição para criar uma nova animação. Iremos chamar esta animação de *idle*, assim como fizemos no `AnimatedSprite2D`. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/3ea6b34a-ffdc-4c66-b8e7-58caa50f1760" />
</p>

Adicione uma track e selecione o *Property Track* sobre a propriedade *animation* do *AnimatedSprite2D*. Agora insira um keyframe no instante inicial com o valor "idle". Isso significa que a propriedade *animation* do `AnimatedSprite2D` será igual a "idle" no início desta chamada do `AnimationPlayer`. 

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/53e4c72d-6a8b-49d9-842c-e5bc6ae0e492" />
  <img width="200" src="https://github.com/user-attachments/assets/600afd7c-abfe-4473-b629-403a6d848b24" />
</p>

Note que definir a animação não dá o play nela. Para dar o play, precisamos manipular outra propriedade. Adiciona mais uma *Property Track*, desta vez será a propriedade *frame* do *AnimatedSprite2D*. Insira um keyframe no instante inicial com o valor $0$. Isso significa que o frame $0$ irá aparecer na tela no início desta chamada. Agora é só repetir os passos para os frames seguintes, colocando eles no instante que deseja.

Existem duas outras maneiras de se fazer isso, possivelmente com menos trabalho.

  1. Definir uma função que dá play na animação e chamar este função pelo *Call Method Track*.
  2. Inserir apenas o primeiro e último frames da animação, e colocar o *Update Mode* para contínuo. Assim, ele vai variar entre todos os frames no intervalo, como mostrado na figura abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/e54a57cc-8ae7-4b7f-8a6e-6e0e2899cfbd" />
</p>

> Dicas sobre o approach 2 acima: Evite inserir frames com a animação rolando na tela, isso inibe a edição. Também não se esqueça de colocar o *Loop Wrap Mode* dos frames para o modo *Clamp*. Reveja [este tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Introduction%20to%20the%20animation%20features#configura%C3%A7%C3%B5es-de-track) caso tenha esquecido o que isso faz.

Repita estes passos para as outras animações e você terá toda a coleção de animações do seu spritesheet no `AnimationPlayer`.

## Animações contínuas

O `AnimationPlayer` está constituído apenas de spritesheets, o que pode ser visto como um conjunto discreto de animações. Será relavante termos também um conjunto contínuo de animações. Definimos abaixo algumas animações de transformações 2D sobre um sprite de espada. Vimos como fazer isso no [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Introduction%20to%20the%20animation%20features).

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/782ff24c-406a-4703-b433-35a2fd82047f" />
</p>

## Introdução ao AnimationTree

Depois de adicionar o node `AnimationTree` à sua árvore de nodes, é necessário escolher uma *Tree Root* e um `AnimationPlayer` para a propriedade *Anim Player*. Cada *Tree Root* pode ser vista como um conjunto de ferramentas diferente para manipular o `AnimationPlayer` escolhido no *Anim Player*. Vamos ver cada uma dessas na sequência. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/b4ff9cae-c564-41ec-ad62-b2bda464f758" />
</p>

> PS: Para este tutorial eu criei diversos nodes `AnimationTree` na mesma cena, referenciando o mesmo `AnimationPlayer`. Fiz isso apenas para ter os exemplos no mesmo lugar, mas é importante saber que as animações do último `AnimationTree` ficam por cima das anteriores, já que estão referenciando o mesmo objeto.

### AnimationNodeBlendSpace1D

Em *Inspector → Tree Root*, selecione *AnimationNodeBlendSpace1D*. Esse é o tipo de AnimationTree mais fácil de entender e manipular. Começaremos com o `AnimationPlayer` dos sprites.

O painel de edição estará como mostrado abaixo. A ideia é que você pode inserir "pontos de animação" no eixo $x$ (por isso o "1D" no nome ), e cada ponto representa uma animação do `AnimationPlayer` associado. Depois de ter os pontos inseridos no espaço, você pode definir em qual posição deste espaço você quer inserir o *blending point* (ponto de mistura). Conforme este ponto muda de posição, a animação também muda. Se o *Blend Mode* for *Contiunous*, a engine tenta mesclar as animações usando ponderações de acordo com a distância a cada ponto de animação no espaço. Se o *Blend Mode* for *Discrete*, a animação que toca é a do ponto mais próximo. O modo *Capture* é igual ao discreto, mas o primeiro frame da animação é a que o boneco já estava anteriormente.

> PS: Essa "ponderação" que o blend usa é uma interpolação do tipo $\alpha A + \beta B$, em que $A, B$ são as animações e $\alpha + \beta = 1$. Esse modo de interpretar vale para qualquer tipo de blend que aparecer mais para frente. 

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/63e29a53-555c-4258-a9de-ce3c7bb5b85f" />
</p>

  1. Com este botão selecionado, você escohe a posição do *blending point*.
  2. Botão de edição geral. Você pode arrastar os pontos de animação já inseridos ou pode adicionar novos com os segundo clique do mouse.
  3. Botão de criar pontos de animação.
  4. Botão para deletar pontos de animação.
  5. Seleção do Blend Mode.
  6. *Blending point*.

Para adicionar um ponto de animação, use o botões 2 ou 3, clique no espaço e seleciona uma das animaçaões do seu `AnimationPlayer`, assim como mostrado abaixo. Neste tutorial, iremos mostrar a dinâmica para uma animação discreta (*idle, run, walk*) e depois para uma animação contínua (*sword_pos, sword_rot*).

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/72f6c556-9ac3-4558-87c0-0e03fcd66bbe" />
</p>

> PS: Com o botão 3 selecionado, você pode clicar nos pontos de animação e editar suas propriedades pelo Inspector.

Mostramos abaixo como é a dinâmica da animação conforme mudamos de posição o *blending point*. Vale destacar que com animações discretas como essa o *Blend Mode* tem que ser discreto. No caso contínuo a a nimação simplesmente desaparece, pois não é possível mesclar esses tipo de animação, ela não muda continuamente.

https://github.com/user-attachments/assets/e7a54ea1-2c72-4dbd-8cb7-700c9b17664e

A aplicação disso (assim como outras modalidades do `AnimationTree`) é a capacidade de customizar as coisas graficamente. Muito menos código é necessário para obter a variação de animações. E isso é só a ponta do iceberg.

⚠️ **Atenção:** Pelo que eu testei, o *Animation Playback Track* não funciona no `AnimationTree`. Ou seja, todas as animações que você carregar devem estar integralmente contidas no `AnimationPlayer` carregado.

Agora repetimos o procedimento para a animação da espada. Essa é uma animação contínua, então podemos deixar o *Blend Mode* como contínuo. Isso significa que, em vez de trocar de animação, ele vai mesclar as animações de acordo com a distância aos pontos de animação. Essa mescla funciona como uma ponderação. Por exemplo, se o *blending point* estiver $80 \%$ próximo da animação A e $20 \%$ próximo da animação B, então a engine vai tocar $80 \%$ da animação A e $20 \%$ da animação B. Note que isso significa que nenhuma das animações vai tocar até o fim. Por conta disso, é importante ter o *Loop Wrap Mode = Wrap Loop Interp* na animação. Assim a engine interpola o ponto final com o inicial e a animação fica suave.

https://github.com/user-attachments/assets/042798ef-a3b1-4620-b180-77d37901c652

### AnimationNodeBlendSpace2D

A lógica desse modo é totalmente análogo ao anterior, mas agora podemos ter pontos de animação no espaço 2D em vez de 1D. Isso dá mais possibilidades de mesclas de animações, com ponderações mais variadas. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/e831451b-0c10-49e4-8725-28b0b3eb2f5c" />
</p>

No caso do sprite, note que no espaço 1D o boneco tinha que passar pela animação *walk* entre e *idle* e a *run*, agora ele pode ir diretamente de *idle* para *run*.

### AnimationNodeStateMachine

Agora criamos outro `AnimationTree` e selecionamos o modo *AnimationNodeStateMachine*. O painel de edição deve estar como mostrado abaixo. Isso funciona basicamente como uma [máquina de estados finitos](https://pt.wikipedia.org/wiki/M%C3%A1quina_de_estados_finita). Para não complicar muito, interprete isso como um fluxograma de animações, onde cada caixa/node corresponde a uma animação selecionada (com exceção do *Start* e *End*), e as setas/transições levam de uma animação para outra de acordo com certas condições.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/da2d925b-a68f-4fce-a6ab-ca73a49dec34" />
</p>

> PS: Neste contexto cada caixa é chamada de *node*, mas não é um node de Godot, e sim uma animação de um `AnimationPlayer`.

Começamos colocando a animação de *walk* entre o *Start* e o *End* e conectamos os nodes. O painel deve estar como abaixo. Não vou gastar tempo aqui explicando como adicionar/deletar nodes e transições pois o editor é bem simples e não deve ser nenhuma dificuldade aprender isso rápido.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/9faf3575-92e2-448f-903c-0a20e4252b33" />
</p>

⚠️ Atenção: Assim como foi com a track do tipo *call method*, a animação com *State Machine* só tem efeito quando você executa a cena, ela não roda na prévia do editor.

Note que com esta configuração nenhuma animação é tocada quando você executa a cena. Porém, se você deletar a transição entre a animação e o node *End*, a animação toca. Por que isto acontece? É simples, não existe nenhuma condicional imposta sobre as transições, então o fluxo segue de um node para o outro sem interrupções. Ou seja, assim que ele ia tocar a animação ele já vai para o próximo node e a animação é interrompida. Sem a última transição, o ponto final do fluxo fica na animação *walk*, por isso funciona. Se você trocar o modo de trasição para *At End*, como mostrado abaixo, aí sim a animação toca normalmente. 

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/dd06bb1b-7812-4921-b41f-5791e4960c43" />
</p>

O exemplo acima mostra que o tipo de transição importa para o fluxo do *State Machine*. Vamos explicar os 3 tipos de transições que existem em Godot.

  - **Immediate:** Muda para o próximo estágio imediatamente. Ocorre um pequeno blend entre o fim da animação atual e o início da seguinte.
  - **Sync:** Também muda para o próximo estágio imediatamente, mas continua a animação nova a partir da posição exata onde a anterior estava, mantendo a continuidade temporal.
  - **At End:** Espera a animação atual encerrar antes de ir para a seguinte.

⚠️ Atenção: Se a animação estiver configurada para ficar em loop, a transição *At End* vai fazer com que aquele estágio toque para sempre, sem ir para o seguinte.

No painel de edição, no topo direito, você pode notar que há duas opções de *Play Mode*. Você vai querer usar isso quando chamar algum node para tocar via código. A descrição delas está abaixo.

  - **Travel:** Segue o caminho de transições definido no *State Machine* (respeita blends).
  - **Immediate:** Troca instantânea, pulando o grafo e começando direto o novo estado.

Tantos os nodes quanto as transições possuem propriedades para serem modificadas no *Inspector*. Vamos começar descrevendo as propriedades dos nodes.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/02f1b39a-8662-4bab-bbe1-7f7e4c98caba" />
</p>

  - **Animation:** Modifica a animação que você quer tocar naquele node.
  - **Play Mode:** Determina se você quer tocar a animação na ordem default ou ao contrário.
  - **Advance on Start:** Se estiver habilitado, pula o primeiro frame ao exibir a animação.
  - **Use Custom Timeline:** Se estiver habilitado, logo abaixo se abre um pequeno painel para edições temporais sobre a animação.

Agora vamos ver as propriedades das transições.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/9efa5a47-0596-440c-9625-d62cae9a877a" />
</p>

  - **Xfade Time:** Tempo que uma animação pode continuar tocando mesmo após a próxima já ter começado.
  - **Xfade Curve:** Você pode definir a curva de peso do fade-out animnação do *Xfade Time*. Menores valores significam que o fade-out é mais leve, então a animação anterior fica mais evidente.
  - **Break Loop at End:** Se a animação for um loop, ativar esta opção garante que o loop será tocado apenas uma vez.
  - **Switch Mode:** É o tipo de transição, que é escolhido ao se criar a conexão. As opções são *Immediate, Sync* e *At End*, como já vimos acima.

⚠️ Atenção: Conforme você vai criando mais `AnimatedTree` na cena, sempre volte para o `AnimationPlayer` e deixe na posição RESET. É comum as animações do `AnimatedTree` ficarem tocando na tela, e isso pode levar a conflitos de animação que podem deixar toda a engine bugada.

### Condicionamento do AnimationNodeStateMachine

A parte *Advance* do *Inspector* é a parte onde introduzimos condicionais para as transições. Ou seja, a transição só ocorre se certas condições forem satisfeitas. Para poder usar essas lógicas de maneira apropriada, deixe a propriedade *Mode* em *auto*. Você só vai querer mudar isso se for chamar o método `travel()` por código (algo que eu não acho que seja muito usado). 

Agora vamos ver como criar condições na prática. Primeiro deixe todas as transições como *Immediate* e coloque as animações para rodar em loop. Feito isso, crie um script no node `AnimationNodeStateMachine`. Este script cria a variável *time*, que vai apenas contar o número de segundo que passou desde que se iniciou a cena. O principal é a linha `set("parameters/conditions/x", time > 5)`. Com ela, nós criamos uma variável condicional $x$ que será igual ao resultado da condição *time* $>5$. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/91c2bf26-9f92-48be-a090-9ba6749d2d61" />
</p>

> PS: Note que $x$ é um booleano, que é falso durante os primeiros $5$ segundos da cene a depois passa a ser verdadeiro pelo restante da cena.

Volte para o painel de edição e selecione a transição entre as duas animações. No *Inspector* desta transição, coloque a variável $x$ no campo *Condition*. A partir de agora essa transição só vai ser ativada quando $x$ for verdadeiro. Isso quer dizer que a primeira animação vai ficar sendo executada no seu loop por $5$ segundos antes de passar para a próxima animação.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/b08c2b2d-6382-4a99-83ba-2de1ccea9a59" />
</p>

Como podemos notar, a primeira animação de fato foi tocada por $5$ segundos, mas a segunda animação foi totalmente ignorada. Na verdade ela não foi ignorada, o que aconteceu é que a transição *Immediate* fez com que o fluxo fosse direto para o fim do *State Machine*. Vamos fazer a segunda animação tocar por $3$ segundos. Para isso, criamos mais uma variável condicional, na última transição.

<p align="center">
  <img width="950" src="https://github.com/user-attachments/assets/2d646492-2f27-4cf8-a2ac-5a40ee410517" />
</p>

Por fim, inserimos mais um node, repetindo a primeira animação, e na transição após ele colocamos para tocar até o décimo segundo (então essa animação tocará por $2$ segundos). Porém, em vez de utilizarmos o campo *Condition*, usaremos o *Expression*. Neste caso, basta colocar diretamente a condicional que queremos, assim como seria no código. Neste caso, `time>10`.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/83ddb328-8048-4b1f-b9f1-efdc49f838fc" />
</p>

### AnimationNodeBlendTree

Esta é a última modalidade do `AnimationTree` que veremos. Ela é tão poderosa que após ela não precisaremos ver mais nenhuma outra. O *Blend Tree* permite mixar todas as modalidades vistas acima em uma estrutura de fluxograma. Mas em vez de ser um fluxograma como o *State Machine*, o *Blend Tree* não trabalha com condicionais. Em vez disso ele possui diversas ferramentas de suporte para a animação. Veremos adiante como funciona.

Se você inicializou o node corretamente, o painel de edição deve estar como mostrado abaixo. O node de output sempre estará presente, e é necessário que ele esteja conectado a algo para tocar as animações. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/198043f3-f027-4798-adf5-ed4c6de11011" />
</p>

Você pode clicar em *Add Node* ou dar o segundo clique do mouse no espaço no painel de edição. As opções abaixo vão aparecer. Apenas como exemplo, clique na opção *Animation* (a primeira do topo). Uma caixa representando este node vai aparecer no painel. Todas as opções abrem uma caixa similar no painel, mas cada uma com as suas próprias propriedades. 

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/47bcebce-a69c-4845-9c1b-045716584db2" />
  <img width="320" src="https://github.com/user-attachments/assets/51c1ca8f-68ad-48ea-8825-5ef10e6d9003" />
</p>

> PS: Assim como em *State Machine*, é necessário conectar os nodes para determinar a sequência de eventos.

Vamos dar uma descrição geral de cada tipo de node e depois mostraremos um pequeno exemplo de aplicação.

  - **Animation:** É o node mais simples de todos, ele simplesmente toca uma animação.
  - **OneShot:** Toca uma animação uma única vez caso seja requisitado (via código). A estrutura e o código estão mostrados abaixo. Como a requisição foi feita logo na entrada da cena, e engine primeiro vai tocar a animação *idle* e logo depois a *run*, que ficará em loop. Para que a *idle* não fique presa no loop, você pode ativar a opção *Break Loop at End* no *Inspector* do *One Shot*.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/e0c5d32e-b7c3-4839-aa0d-a61f22fe65eb" />
  <img width="400" src="https://github.com/user-attachments/assets/00dc2611-f0b4-4253-8c9e-969bc1f31c16" />
  <img width="300" src="https://github.com/user-attachments/assets/c9ef4988-a793-427a-892c-bbbf62cb79e5" />
</p>

> PS: Note que há diversas outras propriedades para explorar no *Inspector* do *One Shot*. Vale a pena gastar um tempo explorando as propriedades dos nodes do *Blend Tree*.

  - **Add2:**  Soma duas animações, obtendo uma nova no processo. Somar animações é diferente do blend, pois o blend faz transição onde toca cada umas das animações parcialmente. De fato elas são somadas no blend, mas de maneira ponderada no tempo, omitindo uma animação enquanto a outra ganha mais peso (é uma interpolação do tipo $\alpha A + \beta B$, como já foi observado antes). O *Add2* sempre toca a animação "in" como é originalmente (ver figura abaixo), e adiciona a outra conforme o parâmetro de peso definido no node.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/397b994c-4f4f-4a1f-948e-11988c7471a3" />
</p>

  - **Add3:** Análogo ao *Add2*, mas com 3 animações e uma delas entra subtraíndo em vez de adicionar.
  - **Blend2, Blend3:** Segue a mesma lógica do *Add2, Add3*, mas fazendo blend em vez de adicionar as animações.
  - **Sub2:** Semelhante ao *Add2*, mas a segunda animação entra subtraindo em vez de adicionar. No *Add2* e *Add3* dá para colocar valores negativos no parâmetro, que tem o  mesmo efeito de subtrair. Então não sei se o *Sub2* tem tanta utilidade assim.
  - **TimeSeek:** Este node causa um delay na animação conectada à ele. O valor default $-1$ significa que ele não faz nada. A ativação deste node é feita por código, ele executa a requisição uma única vez e volta ao default $-1$ (semelhante ao *OneShot* que é executado uma única vez via código também). Abaixo mostramos como ele deve ser estruturado. Este node serve para "buscar" (seek) a um ponto específico no tempo de uma animação. Ele permite que você comece a animação a partir de um determinado instante.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/a3fd4257-31aa-4d98-9fe3-1af948e143c0" />
</p>

> PS: Caso seja uma animação de loop, não adianta alterar o $-1$ no painel, tem que ser por código (logo abaixo). E este node também só funciona na execução da cena, não na prévia do editor. 

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/3da4e97d-b282-4ba2-b62e-872872701b81" />
</p>

  - **TimeScale:** Basta adicionar esse node após uma animação e escolher uma valor para acelerar ou desacelerar a animação.

<p align="center">
  <img width="470" src="https://github.com/user-attachments/assets/92c487bd-bc7b-4824-8b55-30e1dac22c18" />
</p>

  - **Transition/BlendTree:** O *Transition* é um modo muito simlpes de *State Machine*. Como o próprio *State Machine* é um node acessível pelo `AnimationNodeBlendTree`, vou desconsiderar este node. O *BlendTree* é o próprio node pai destes todos, de modo que inserir um outro dentro dele significa ter uma estrutura recursiva. Além de muito complexo isso deve matar a performance. Por isso este também será desconsiderado.
  - **BlendSpace1D/BlendSpace2D/StateMachine:** São instâncias das modalidades de mesmo nome vistas anteriormente. Com isto, podemos ver que o `AnimationNodeBlendTree` é capaz de encapsular tudo que vimos de `AnimationTree` em uma única estrutura.

## Exemplo prático

Provavelmente este será o maior tutorial de todos porque além de ter muitos itens para abordar eu ainda decidi incluir este exemplo prático. Isto é necessário justamente porque a quantidade de informação é muito grande, precisamos aplicar algumas coisas na prática para reter o conhecimento. Fora que algumas aplicações que veremos aqui não são óbvias a partir do tutorial.

Começamos criando uma cena com um node raíz do tipo `Node2D`, que chamaremos de *BeetleScene*. Nesta cena, adicione um `CharacterBody2D` contendo um `Sprite2D`. Neste `Sprite2D`, adicione a spritesheet que obtivemos [daqui](https://opengameart.org/content/lpc-beetle). 

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/f24cfab8-56bb-4d10-a412-1d5af4937e0d" />
</p>

Vamos mostrar uma maneira de inserir as animações no `AnimationPlayer` a partir de uma spritesheet completa como essa dentro de um `Sprite2D`. Primeiro crie o node `AnimationPlayer` dentro do `CharacterBody2D`. No painel de edição, vamos criar 4 animações distintas: *right, left, up, down*. Vamos começar mostrando a animação *right*. As outras são análogas. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/0b6d9e31-5da3-44e1-bc87-675046d14cbb" />
</p>

> PS: Como serão 5 frames tocados em $1$ segundo, deixe em $0.2$ segundos o tempo de cada FPS no painel de edição (você muda este valor no campo que fica embaixo). 

Volte para o `Sprite2D` e coloque *HFrames* $= 5$ e *VFrames* $= 4$, pois temos uma spritesheet $4 \times 5$. Feito isso, vá no campo *Frame* e comece a passar de um em um, até encontrar o primeiro do sprite se movimentando para a direita. Assim que encontrar este sprite, clique no picone de chave ao lado para adicioná-lo ao `AnimationPlayer`, e vá clicando na chave para adicionar os seguintes. Você irá inserir $5$ frames no total. Não se esqueça de deixar a animação em loop.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/92962484-96b8-4caf-980c-0058d0d4de55" />
  <img width="600" src="https://github.com/user-attachments/assets/35e7e381-d13a-46fa-892b-fb2bc61911b0" />
</p>

Isso encerra o papel do `AnimationPlayer` neste projeto. Antes de partir para o `AnimationTree`, adicione uma caixa de colisão para a engine parar de reclamar.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/cd41cffb-235e-4747-99ff-380cc68992a6" />
</p>

Também vamos criar um script de movimentação "8-way", como visto [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/2D%20movement%20overview#8-way-movement). Com isso, já temos movimentação, só falta a animação.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/877e92d2-36a7-4c9c-8e9e-983a7ff2070e" />
</p>

Adicione um `AnimationTree` como filho do `CharacterBody2D`. A ideia será criar um *AnimationNodeBlendTree* contendo um node *State Machine* e um *TimeScale* para controlar a velocidade da animação de acordo com a posição do sprite na tela. A estrutura inicial está mostrada abaixo. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/9248a5b3-f25a-4168-a1d5-ee66ad88014a" />
</p>

Começaremos editando o *State Machine*, então clique em *Open Editor* para começarmos a edição deste node. Dentro do *State Machine*, adicione um node do tipo *BlendSpace2D* e clique para começar a edição dentro dele. Insira 4 pontos, de modo que *up* $= (0, -1)$, *down* $=(0, 1)$, *right* $=(1, 0)$, *left* $=(-1, 0)$. Coloque o modo blend como discreto e se certifique de que a conexão entre o *Start* e o *BlendSpace2D* é do tipo *Immediate*. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/c14a75a1-9f6b-4b49-a539-16f61a0fcced" />
  <img width="800" src="https://github.com/user-attachments/assets/4443cfb5-8a9f-4750-8ca0-a1dd9ec5051e" />
</p>

> PS: Talvez por estar num nível mais profundo da lógica da engine, não é possível ver a animações ao trocar ao manipular a posição do *blending point* no editor.

Uma coisa que não foi dita na discussão acima é que as novas propriedades que surgem a partir dos novos nodes aparecem no *Inspector*. Na figura abaixo, podemos ver que tanto o *blending point* (chamado de *Blend Position*) quanto o tempo do *Time Scale* são parâmetros manipuláveis pelo *Inspector*.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/6def3435-3139-4a4c-baf6-12fde0a0d45f" />
</p>

Não podemos esquecer da condicional, algo que acabamos de aprender sobre *State Machine*. Selecione a transição entre o *Start* e o *BlendSpace2D* e em *Inspector → 
advance → Expression* coloque a expressão `get_parent().velocity.length() > 0`. Devemos colocar este `get_parent()` na frente pois a velocidade não é do `AnimationTree` e sim do seu pai.

No script do `CharacterBody2D`, note que a variável `direction` recebe a direção normalizada para onde o sprite está se movendo. Portanto basta fazer o *blending point* ser igual a essa variável para que a animação correta seja mostrada quando o sprite se locomover. Para isso, inserimos o comando `$AnimationTree.set("parameters/StateMachine/BlendSpace2D/blend_position", direction)`. Isso é análogo ao que fizemos para a condicional, mas em vez de definir a variável condicional, nós sobrescrevemos o valor de uma variável que já existe.

> Dica: Você pode clicar em qualquer nome de propriedade no *Inspector* e simplesmente arrastar para dentro do script. Na figura abaixo isso foi feito para o *Blend Position*. Note como o nome já aparece enquanto ainda o estamos arrastando.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/bfd4d9ef-5f3c-4e6e-b7a0-c9512d857918" />
</p>

Com isso, temos o script abaixo. 

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/3299fca5-c60e-4963-a006-c7b424cb91a9" />
</p>

Este script já é funcional, mas ainda pode ser melhorado. Queremos que o "idle" mantenha a direção do sprite. Vamos adicionar mais um node no *State Machine* igual ao anterior, mas que seja ativado com a condição `get_parent().velocity.length() == 0`. Vamos aproveitar e renomear o node anterior para "Movement" e este para "Idle". Não se esqueça de atualizar o script de acordo. A transição do *Movement* para o *Idle* será do tipo *At End* para que a mudança de animação não tenha quebras. Além disso, não se esqueça também de colocar uma transição do *Idle* para *Movement*, que é idêntica a do *Start* para *Movement*.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/1f107a90-7776-4a6d-b6fc-f4c085525385" />
</p>

Se você fez tudo corretamente, vai perceber que o comportamento do sprite ainda não está como deveria. No estado idle ele sempre fica numa mesma posição em vez de ficar na última que estava. Isto acontece pois ao parar de pressionar a direção, a engine vai para a direção $(0, 0)$, e é esta a direção que vai para o estado idle. Resolvemos isso introduzindo uma variável auxiliar no script para memorizar a última direção não-nula. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/b237c09b-0ab7-4a24-9d88-870df7db0484" />
</p>

Para finalizar, vamos considerar duas regiões da tela, com o lado esquerdo sendo o "normal" e o lado direito o "acelerado". Lá atrás, já colocamos a node *Time Scale* no editor, então só falta a lógica. Logo após a parte de animação no script, inserimos condicionais para o comando `$AnimationTree.set("parameters/TimeScale/scale", x)`, alterando o valor de $x$ de acordo com o lado da tela onde está o sprite. Lembrando, o caminho "parameters/TimeScale/scale" você pode obter ao ir no respectivo parâmetro no *Inspector* e arastando para o script. O script final deve estar da seguinte maneira:

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/660688b0-804b-4685-8bff-dd38c92f6cdc" />
</p>

Também incluímos um `Sprite2D` de background para evidenciar as duas regiões. Abaixo temos uma prévia deste mini-game. Você pode brincar com ele [neste link](https://felipebottega.github.io/Games/Manual/Animation/Using%20AnimationTree/html/).

https://github.com/user-attachments/assets/bc8fda04-4c3c-4180-b965-b4f2bb5400c4
