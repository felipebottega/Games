  # Using AnimationTree

Vimos que o `AnimatedSprite2D` é uma maneira direta e simples de criar animações a partir de uma spritesheet. Essa simplicidade é acompanhada de limitações, ou seja, não dá oara fazer muita coisa complexa com este node. O `AnimationPlayer` é uma ferramenta muito mais completa para animações. Não só animações de sprites, mas de propriedades, funções, sons, entre outros. Neste sentido, o `AnimationPlayer` não é simplesmente uma ferramenta de animação, mas sim um editor visual e versátil de diversos objetos de Godot. 

O `AnimationTree` não faz animação nenhuma. Ele é uma camada de abstração extra ao `AnimationPlayer`, ou seja, é um conjunto de ferramentas visuais para combinar e manipular diversas instâncias do `AnimationPlayer`. A princípio não é muito claro o que o `AnimationTree` faz. Seu papel vai ficar mais claro conforme formos evoluindo neste tutorial. 

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

