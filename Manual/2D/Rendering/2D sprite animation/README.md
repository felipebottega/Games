# 2D sprite animation

Vimos um pouco sobre animação de sprites [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Coding%20the%20player/Animation%201), mas vamos repassar o conteúdo já que ele se encontra neste tutorial oficial. Neste exemplo, a cena será constituída de um `CharacterBody2D` como node raíz, mas também seria possível utilizar `Area2D` ou `RigidBody2D` como raíz.

## AnimatedSprite2D com imagens individuais

Selecione o node `AnimatedSprite2D` e abra a aba *Animation* em *Inspector*. Selecione *Sprite Frame* e *New SpriteFrames*, como mostrado abaixo. Clique no nome *SpriteFrames* que apareceu no mesmo local (figura do meio, abaixo), daí o editor de animação (figura da direita, abaixo) deve aparecer. Daí arraste os sprites de *File System* para a caixa de animação. Troque o nome para *run* e mude a velocidade da animação para 10 FPS.  

<p align="center">
  <img src="https://github.com/user-attachments/assets/a0f44fc1-b7cc-4177-8b74-c6e191f87d9f" width="1100">
</p>

Se você clicar no botão de play, consegue como ver como é a animação, mas isto não basta para ela estar na cena. Isso é possível com um script na cena, que pode ser no node raíz. Com o script abaixo no `CharacterBody2D`, você já consegue ativar a animação ao apertar a seta para a direita do teclado. O comando `$AnimatedSprite2D.play("run")` é equivalente a executar os comandos `$AnimatedSprite2D.animation = "run"` e `$AnimatedSprite2D.play()` em sequência. Você pode alterar o node `$AnimatedSprite2D` de diversas maneiras antes de dar o play, ele vai acumular as alterações e só vai exibir a animação quando o comando de play aparecer.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e46e0ece-a68e-4e55-9973-4c3ae4e6c9da" width="300">
</p>

## AnimatedSprite2D com sprite sheet

Uma *sprite sheet* é um único arquivo que contém todos os frames de uma animação dispostos em grid. Começamos procedendo da mesma maneira que antes, a diferença só aparece na
hora de arrastar o arquivo de *File System* para a caixa de animação. Em vez disso, selecione a opção *Add frames from sprite sheet* mostrada abaixo e escolha o arquivo da sua sprite sheet.

<p align="center">
  <img src="https://github.com/user-attachments/assets/3250aa0e-2c91-42a5-a545-9e55d8d3f048" width="900">
</p>

Uma janela vai se abrir. No lado direito dela, selecione as dimensões da grid, de modo a separar os sprites corretamente. Depois clique nos sprites, na ordem que desejar, e confirme em *Add 8 Frame(s)*. Após isso, a lógica do script é idêntica, pois é o mesmo tipo de node. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/fa87ca4a-6a77-4fb6-92af-30114ad6d910" width="750">
</p>

> PS: Na sprite sheet não é necessário selecionar todos os frames, e a ordem também é a que você quiser. 

## Customizações do AnimatedSprite2D

 1. Autoplay on Load: Começa a animação automaticamente assim que a cena é executada.
 2. Animation Looping: Repete a animação em loop.
 3. Animation Speed: Velocidade de cada frame da animação, medida em FPS (frames per second).
 4. Diversas opções básicas: Copiar, colar, inserir frame vazio, entre outros. 
 5. Velocidade de frame: Além da *Animation Speed*, que é a velocidade default de todos os frames, você pode editar velocidades de frames individuais com esse parâmetro.
 6. Speed Scale: Atributo que altera a velocidade geral da animação. Ela pode ser alterada via script para acelerar ou desacelerar a animação durante o jogo. É diferente do 
Animation Speed que é alterado apenas no editor.

<p align="center">
  <img src="https://github.com/user-attachments/assets/003391c8-b3c5-473a-bbbc-43f167c4b1d8" width="800">
</p>

## AnimationPlayer

O `AnimatedSprite2D` é capaz de suprir as necessidades da maioria dos casos de animações. Porém, há situações que demandam alterações mais específicas. Para isso temos o node
`AnimationPlayer`, que é mais complexo, mas permite obter feitos mais elaborados. Veremos ele por alto aqui, mas será aprofundado em um tutorial mais para frente.

O funcionamento deste é diferente, devemos carregar a sprite sheet no `Sprite2D`. Assim como no `AnimatedSprite2D`, a cena será constituída de um `CharacterBody2D` como node raíz, mas também seria possível utilizar `Area2D` ou `RigidBody2D` como raíz.

<p align="center">
  <img src="https://github.com/user-attachments/assets/0cbc2b84-d997-401d-b141-0af5dc90b7b8" width="1000">
</p>

No *Inspector*, clique na aba *Animation* e coloque a opção *Hframes* para 6. *Hframes* é a quantidade de frames horizontalmente e *Vframes* é a quantidade de frames verticalmente. Agora você alterar a propriedade *Frame* (abaixo de *Vframes*). Note que ela tem a função de mostrar um dos frames dentre os totais, de acordo com a divisão feita pelo *Hframes*.

<p align="center">
  <img src="https://github.com/user-attachments/assets/9520e08a-bcbb-4194-ba17-0119931b0d97" width="200">
</p>

Selecione o node `AnimationPlayer`, clique em *Animation → New* e nomeie a animação como "walk". Isso vai abrir um painel de animação diferente do anterior.

<p align="center">
  <img src="https://github.com/user-attachments/assets/8d5cb05b-868a-45d6-a492-6a7b3d9dc205" width="700">
</p>

Queremos que cada frame dure 0.1 segundos e que o total seja 0.6 segundos. Com isto em mente, devemos acertar os valores no painel de edição. O tempo do frame está embaixo à esquerda enquanto que o tempo total está em cima à direita na imagem. Também selecionamos a opção de deixar a animação em loop, em cima à direita.

<p align="center">
  <img src="https://github.com/user-attachments/assets/5fd84603-7e66-4ae6-bfb6-a812042aca1f" width="350">
</p>

O passo acima foi apenas para configurar a animação, mas ela não possui frames ainda. Note que não há nenhum de conexão entre o `Sprite2D` e o `AnimationPlayer`. Lembra da 
propriedade *Frame* do *Animation* do `Sprite2D`, ela servia para mostrar um frame de animação em específico. Selecione o primeiro frame e clique na chave destacada na imagem. Repare que ela foi adicionada ao primeiro frame do painel de animação. Repita este passos para acrescentar os outros frames em sequência.

<p align="center">
  <img src="https://github.com/user-attachments/assets/5799a1eb-177c-47ff-a10a-984541e9a070" width="900">
</p>

Pode ser necessário dar um zoom no painel para ver melhor o que está acontecendo. No fim das adições de frames o resultado deve estar como a imagem abaixo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/aa494433-37c6-4bc0-a859-f0fb7694a292" width="900">
</p>

Por fim, adicione um script ao node raíz. Ele é quase idêntico ao script do `AnimatedSprite2D`. Só o que muda é que você vai mudar `$AnimatedSprite2D` por `$AnimationPlayer`.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2ad33ae4-6030-4dca-97eb-3fda706f5380" width="300">
</p>

## Customizações do AnimationPlayer
