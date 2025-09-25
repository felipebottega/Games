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
