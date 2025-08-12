# Introduction to the animation features

O node `AnimationPlayer` pode gerar animações sobre qualquer outro node, então não é preciso se preocupar se ele é filho ou pai de algum node em específico. Começamos com uma simples cena de um `Node2D` contendo um `AnimationPlayer` e um `Sprite2D` que será animado. Ressaltamos que a animação de agora não é animação como um `AnimatedSprite2D`, mas sim animação das transformações 2D sobre o sprite.

No painel de animação, clique para adicionar uma nova animação e escolha um nome para ela.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/79981d3e-47ed-4c3d-b1df-fc9a1954c98b" />
</p>

O painel de animação possui 4 partes principais: 
 - Tracks: Cada track corresponde a algum tipo de animação sobre algum objeto em específico. Todas as tracks ocorrem simultaneamente, podendo ser cada uma sobre objetos distintos.
 - Timeline: Linha do tempo da animação. Ali você verá marcadores indicando quando algum evento de animação vai acontecer.
 - Animation Controls: Principais ferramentas para gerenciar e editar as animações.
 - Timeline Controls: Configurações sobre a visualização do Timeline. Essas configurações não tem efeito nenhum sobre nas animações em si.  

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/85166f4b-d008-4074-83e4-993831ca7800" />
</p>

> PS: Como mostrado na figura abaixo, algumas opções aparecem no editor quando você está no node `AnimationPlayer`. Nós iremos ignorar estes botões em favor da edição mais precisa pelo Inspector. Portanto, pode simplesmente fingir que eles não existem.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7621a87f-9e9e-4b42-b031-c5411b7e6cd6" />
</p>

## Animando propriedades

Clique em *+ Add Track* e selecione *Property Track*. Uma janela com a árvore de nodes vai se abrir. Escolhe o node que quer animar. Depois disso vai se abrir uma outra janela, agora com as propriedades deste node (as dele mesmo e as herdadas). Você pode editar qualquer propriedade que quiser. Isso já evidencia o quão poderosa é esta ferramenta, pois ela não é simplesmente uma ferramenta de animação, mas sim uma ferramenta de controle de estados dos nodes.

<p align="center">
  <img width="150" src="https://github.com/user-attachments/assets/8e2b564b-6c7b-473a-812c-f782eb135bd7" />
  <img width="220" src="https://github.com/user-attachments/assets/35f7b458-75f7-413b-bce9-c9f7f0bafe85" />
  <img width="630" src="https://github.com/user-attachments/assets/b6073fb1-efa8-4a5d-9d3c-71affe3df3b5" />
</p>

Dê o segundo clique do mouse sobre a linha vertical azul no track (essa linha marca o ponto da animação que o editor está no momento) e selecione a opção *Insert Key*. Logo após isso, vai aparecer uma "bolinha" no timeline, no local onde você clicou. Você acabou de inserir um evento de animação, que é chamado de "keyframe" na Godot. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/ae30d732-0bab-43ac-ae9e-3531e7874224" />
  <img width="325" src="https://github.com/user-attachments/assets/c7ce6f08-fb89-4716-8a54-d02ae3ddb4a5" />
</p>

Agora clique na bolinha e olhe para o Inspector. Estas são as configurações das propriedades do `position` do `Sprite2D` naquele instante marcado. Estamos dizendo à engine que queremos o sprite na origem no instante inicial.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/9097e2e8-9439-4684-915e-85f4403d0405" />
</p>

 Agora repita o procedimento para colocar o sprite na posição $(100, 100)$ no instante $1.0$ (em segundos). Se você fez tudo certo, o editor deve estar como mostrado abaixo. Note que não é necessário inserir a bolinha na posição perfeita, pois você pode editar o instante dela no Inspector caso ele fique um pouco deslocada do momento que você queria. Depois disso você já pode dar o play e ver a sua animação acontecer. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/09ec1e7e-edbc-4bb5-856d-5b09ba0a3447" />
</p>

Esses foi o nosso primeiro passo no mundo de `AnimationPlayer`. A partir disso você já deve ter uma ideia das possibilidades. Aos poucos o nosso arsenal de ferramentas só vai aumentar.

## Animation Controls

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/1ace4903-6c7c-49e1-8a19-c7c3f352ce33" />
</p>

  1. Botões de play, stop, etc. Nenhum mistério aqui.

  2. Instante da animação que está no editor (corresponde tanto à linha vertical azul no Timeline quando a imagem que está na tela acima).

  3. Opções mais gerais de gerenciamento, como criar novas animações, renomear, etc. Em particular, no *Manage Animations* você pode organizar suas animações em pastas e pode carregar animações que estejam salvas em arquivo. Vale notar que as animações de um node não são compartilhadas com outros nodes.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/fe52ad55-f310-45d3-b735-62d79d8e6664" />
</p>

  4. Lista de animações. Um mesmo node de animações pode ter várias animações, assim como o `AnimatedSprite2D`. E assim como o `AnimatedSprite2D`, só é permitido tocar uma animação por vez. A animação *RESET* é especial. Nela você deve colocar a "pose" default do objeto. Esta pose sempre será carregada quando você carregar a cena. Caso você não use isso e deixe a animação no meio caminho ao fechar o editor, na próxima vez que for abrí-lo, o objeto estará na pose da animação. O *RESET* é útil para evitar isso e forçar uma pose inicial ao abrir a cena. Apenas insira as poses para o primeiro frame de track track no *RESET* e esas será a pode default.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/5686799f-d264-4418-9711-7f8c40f5b7cf" />
</p>

  5. Botão de autoplay. Se estiver marcado, a animação começa automaticamente assim que a cena é carregada.

  6. Conjunto de opções sobre as tracks. Por enquanto basta saber que a opção *Apply RESET* faz a animação voltar para a pode default do *RESET*.

  7. Aplica ou não o *Onion Skinning*. Esta opção serve para mostrar na tela alguns passos para trás ou para frente da animação, junto do ponto atual dela.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/a68c1b23-2b3f-48f9-929c-f0ad1ebde66d" />
</p>

  8. Opções do *Onion Skinning*.

  9. Tempo total da animação. Por default vem como 1 segundo. A barra cinza no Timeline indica a faixa onde há animação.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/fb3f976a-6c75-402c-abd9-d33291d78c88" />
</p>

  10. Opções de loop. Você pode deixar a animação sem loop nenhum (default), de modo que ela é executada uma única vez. Tem a opção de loop, onde ela fica repetindo indefinidamente. Por fim, tem uma outra opção de executar em loop, mas em vez de repetir a animação, ela executa de trás para frente quando acaba a execução normal, e fica repetindo indefinidamente desta maneira. 

## Configurações de track

Quando você adiciona uma track, aparecem algumas opções junto a ela. Estas opções moldam como a animação daquela track será executada. Mais especificamente, elas determinam como é a passagem entre cada keyframe da track. Vamos descrever uma a uma abaixo.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/fc67acd1-8909-428d-92dc-fa1d39738bd5" />
</p>

  1. Método geral que com que a mudança da animação ocorre entre duas keyframes. O método *contínuo* faz com que a mudança seja gradual e ocorra frame a frame. O método *Discrete* faz com que a mudança só ocorra em keyframes. O método *Capture* só vale para o primeiro keyframe. Caso o instante dele seja positivo, então o instante zero é capturado do estado atual do objeto da cena.   

<p align="center">
  <img width="120" src="https://github.com/user-attachments/assets/ed0ca223-6e5f-4d71-82b3-30b60c10dfcb" />
</p>

  2. Método de interpolação entre duas keyframes. O método *Nearest* basicamente é um "pulo" entre keyframes. O método *Linear* faz a interpolação linear. O método *Cubic* segue a curva cúbica, e é interessante quando queremos um comportamento mais orgânico no movimento.

<p align="center">
  <img width="120" src="https://github.com/user-attachments/assets/a1802369-aea7-4704-957e-f083f25be35c" />
</p>

  3. Modos de loop. O modo *Clamp Loop Interp* executa a animação inteira e pula para o primeiro keyframe após isso. O modo *Wrap Loop Interp* faz uma interpolação entre o último keyframe e o primeiro em vez de pular a animação.

<p align="center">
  <img width="150" src="https://github.com/user-attachments/assets/704f8f59-352d-4b40-8c98-4034fa60d8cb" />
</p>

  4. Opção de deletar a track.

## Controles da Timeline

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/852fbc5a-0f2f-4ab3-a554-d2c580b33595" />
</p>

  1. Tempo de cada frame na animação. Este valor não tem nada a ver com o jogo, é apenas para auxiliar na edição da animação. Se você quiser uma animação com menos frames, isto pode ser útil para análises com o Onion Skinning, mas quando for rodar a cena, o número de frames dela é o default do jogo.

  2. Determina se você quer trabalhar com as unidades de segundos (default) ou FPS. Se for alterar para FPS, o painel inteiro sde adapta para essa unidade.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/0e517f11-1b0a-4e8b-b667-d328776985e7" />
</p>

  3. Zoom-in e zoom-out na Timeline.

  4. Ajusta o zoom da Timeline para ocupar o todo o espaço da track.
     
## Marcadores

Você pode clicar com o segundo clique do mouse na parte da marcação de tempo que vai aparecer a opção de adicionar um marcador.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/3f933dac-6a2c-425c-8fcd-c07b754208da" />
</p>

Depois de decidir o nome e a cor do marcador, dê ok. Ele ficará destacado na Timeline com a cor que você escolheu. Ao clicar nele, suas configurações aparecem no Inspector.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/fbb637b3-afea-4a13-88f6-7d2df5497114" />
</p>

Criamos dois marcadores como exemplo. Se você segurar shift e clicar em dois marcadores, a região entre eles ficará destacada em vermelho. Ao dar play, apenas a animação deste trecho será executada. 

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/b93b3a5b-eb91-4b77-9b0d-0785140a4dce" />
</p>

Marcadores são úteis como ferramentas de edição, quando você quer se concentrar em um trecho, ou quer deixar marcado como lembrete para voltar ali mais tarde, entre outros. Além da edição, você pode animar apenas o trecho entre marcadores no jogo através da função `play_section_with_markers` (aí tem quer ser via script). Também dá para chamar a função `play_section_with_markers_backwards` para executar o trecho ao contrário no jogo.

## Exemplo prático

Vamos continuar trabalhando a nossa animação, mas dessa vez com um arsenal maior de ferramentas.

## Keyframes for other properties

