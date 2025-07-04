# 2D sprite animation

Vimos um pouco sobre animação de sprites [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Coding%20the%20player/Animation%201), 
mas vamos repassar o conteúdo já que ele se encontra neste tutorial oficial. Neste exemplo, a cena será constituída de um `CharacterBody2D` como node raíz, mas também seria possível
utilizar `Area2D` ou `RigidBody2D` como raíz.

## AnimatedSprite2D com imagens individuais

Selecione o node `AnimatedSprite2D` e abra a aba *Animation* em *Inspector*. Selecione *Sprite Frame* e *New SpriteFrames*, como mostrado abaixo. Clique no nome *SpriteFrames* 
que apareceu no mesmo local (figura do meio, abaixo), daí o editor de animação (figura da direita, abaixo) deve aparecer. Daí arraste os sprites de *File System* para a caixa
de animação. Troque o nome para *run* e mude a velocidade da animação para 10 FPS.  

[figura1]

Se você clicar no botão de play, consegue como ver como é a animação, mas isto não basta para ela estar na cena. Isso é possível com um script na cena, que pode ser no node raíz.
Com o script abaixo no `CharacterBody2D`, você já consegue ativar a animação ao apertar a seta para a direita do teclado. O comando `$AnimatedSprite2D.play("run")` é equivalente a 
executar os comandos `$AnimatedSprite2D.animation = "run"` e `$AnimatedSprite2D.play()` em sequência. Você pode alterar o node `$AnimatedSprite2D` de diversas maneiras antes de 
dar o play, ele vai acumular as alterações e só vai exibir a animação quando o comando de play aparecer.

[figura2]


## AnimatedSprite2D com sprite sheet

Uma *sprite sheet* é um único arquivo que contém todos os frames de uma animação dispostos em grid. Começamos procedendo da mesma maneira que antes, a diferença só aparece na
hora de arrastar o arquivo de *File System* para a caixa de animação. Em vez disso, selecione a opção *Add frames from sprite sheet* mostrada abaixo e escolha o arquivo da sua 
sprite sheet.

[figura3]

Uma janela vai se abrir. No lado direito dela, selecione as dimensões da grid, de modo a separar os sprites corretamente. Depois clique nos sprites, na ordem que desejar, e confirme
em *Add 8 Frame(s)*. Após isso, a lógica do script é idêntica, pois é o mesmo tipo de node. 

[figura4]

> PS: Na sprite sheet não é necessário selecionar todos os frames, e a ordem também é a que você quiser. 

## Customizações do AnimatedSprite2D

1 - Autoplay on Load: Começa a animação automaticamente assim que a cena é executada.
2 - Animation Looping: Repete a animação em loop.
3 - Animation Speed: Velocidade de cada frame da animação, medida em FPS (frames per second).
4 - Diversas opções básicas: Copiar, colar, inserir frame vazio, entre outros. 
5 - Velocidade de frame: Além da *Animation Speed*, que é a velocidade default de todos os frames, você pode editar velocidades de frames individuais com esse parâmetro.
6 - Speed Scale: Atributo que altera a velocidade geral da animação. Ela pode ser alterada via script para acelerar ou desacelerar a animação durante o jogo. É diferente do 
Animation Speed que é alterado apenas no editor.

[figura5]

## AnimationPlayer

O `AnimatedSprite2D` é capaz de suprir as necessidades da maioria dos casos de animações. Porém, há situações que demandam alterações mais específicas. Para isso temos o node
`AnimationPlayer`, que é mais complexo, mas permite obter feitos mais elaborados. Veremos ele por alto aqui, mas será aprofundado em um tutorial mais para frente.

O funcionamento deste é diferente, devemos carregar a sprite sheet no `Sprite2D`. Assim como no `AnimatedSprite2D`, a cena será constituída de um `CharacterBody2D` como node raíz, 
mas também seria possível utilizar `Area2D` ou `RigidBody2D` como raíz.

[figura6]

No *Inspector*, clique na aba *Animation* e coloque a opção *Hframes* para 6. *Hframes* é a quantidade de frames horizontalmente e *Vframes* é a quantidade de frames verticalmente.
Agora você alterar a propriedade *Frame* (abaixo de *Vframes*). Note que ela tem a função de mostrar um dos frames dentre os totais, de acordo com a divisão feita pelo *Hframes*.

[figura7]

Selecione o node `AnimationPlayer`, clique em *Animation → New* e nomeie a animação como "walk". Isso vai abrir um painel de animação diferente do anterior.

[figura8] 

Queremos que cada frame dure 0.1 segundos e que o total seja 0.6 segundos. Com isto em mente, devemos acertar os valores no painel de edição. O tempo do frame está embaixo à 
esquerda enquanto que o tempo total está em cima à direita na imagem. Também selecionamos a opção de deixar a animação em loop, em cima à direita.

[figura9]

O passo acima foi apenas para configurar a animação, mas ela não possui frames ainda. Note que não há nenhum de conexão entre o `Sprite2D` e o `AnimationPlayer`. Lembra da 
propriedade *Frame* do *Animation* do `Sprite2D`, ela servia para mostrar um frame de animação em específico. Selecione o primeiro frame e clique na chave destacada na imagem. 
Repare que ela foi adicionada ao primeiro frame do painel de animação. Repita este passos para acrescentar os outros frames em sequência.

[figura10]

Pode ser necessário dar um zoom no painel para ver melhor o que está acontecendo. No fim das adições de frames o resultado deve estar como a imagem abaixo.

[figura11]

Por fim, adicione um script ao node raíz. Ele é quase idêntico ao script do `AnimatedSprite2D`. Só o que muda é que você vai mudar `$AnimatedSprite2D` por `$AnimationPlayer`.

[figura12]

## Customizações do AnimationPlayer