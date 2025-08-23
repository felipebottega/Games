# Using AnimationTree

Vimos que o `AnimatedSprite2D` é uma maneira direta e simples de criar animações a partir de uma spritesheet. Essa simplicidade é acompanhada de limitações, ou seja, não dá oara fazer muita coisa complexa com este node. O `AnimationPlayer` é uma ferramenta muito mais completa para animações. Não só animações de sprites, mas de propriedades, funções, sons, entre outros. Neste sentido, o `AnimationPlayer` não é simplesmente uma ferramenta de animação, mas sim um editor visual e versátil de diversos objetos de Godot. 

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

## Segundo AnimationPlayer

Este primeiro `AnimationPlayer` foi constituído apenas de spritesheets, o que pode ser visto como um conjunto discreto de animações. Será relavante termos também um conjunto contínuo de animações. Definimos abaixo algumas animações de transformações 2D sobre um sprite de espada. Vimos como fazer isso no [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Introduction%20to%20the%20animation%20features).

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/782ff24c-406a-4703-b433-35a2fd82047f" />
</p>

## Introdução ao AnimationTree

Depois de adicionar o node `AnimationTree` à sua árvore de nodes, é necessário escolher uma *Tree Root* e um `AnimationPlayer` para a propriedade *Anim Player*. Cada *Tree Root* pode ser vista como um conjunto de ferramentas diferente para manipular o `AnimationPlayer` escolhido no *Anim Player*.  

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/b4ff9cae-c564-41ec-ad62-b2bda464f758" />
</p>

### AnimationNodeBlendSpace1D

Em *Inspector → Tree Root*, selecione *AnimationNodeBlendSpace1D*. Esse é o tipo de AnimationTree mais fácil de entender e manipular. Começaremos com o `AnimationPlayer` dos sprites.

O painel de edição estará como mostrado abaixo. A ideia é que você pode inserir "pontos de animação" no eixo $x$ (por isso o "1D" no nome ), e cada ponto representa uma animação do `AnimationPlayer` associado. Depois de ter os pontos inseridos no espaço, você pode definir em qual posição deste espaço você quer inserir o *blending point* (ponto de mistura). Conforme este ponto muda de posição, a animação também muda. Se o *Blend Mode* for *Contiunous*, a engine tenta mesclar as animações usando ponderações de acordo com a distância a cada ponto de animação no espaço. Se o *Blend Mode* for *Discrete*, a animação que toca é a do ponto mais próximo. O modo *Capture* é igual ao discreto, mas o primeiro frame da animação é a que o boneco já estava anteriormente.

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



