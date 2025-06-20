# Animation 1

Para fazer um sprite ter movimentos, utilizaremos o node `AnimatedSprite2D`. Neste caso o node chamado `Trevor` é do tipo `RigidBody2D`, mas vale ressaltar que outros tipos de nodes também funcionam com `AnimatedSprite2D`. 

Uma coisa interessante que eu não conhecia mas é bem útil é o botão *Group Selected Nodes* destacado na imagem abaixo. Ele faz com que os filhos do node raíz da cena não sejam selecionáveis em outras cenas. Ou seja, se você clicar num deles, automaticamente é o node pai que será selecionado. Várias vezes eu queria mover um sprite na cena principal e movia só a collision shape dele sem querer, ou vice-versa. Então descobrir esse botão foi um alívio para mim!

<p align="center">
    <img src="https://github.com/user-attachments/assets/a761a71f-cb31-43c4-9477-900ee340e000" width="700">
</p>

Agora vamos para a parte que interessa. Selecione o node `AnimatedSprite2D` e abra a aba *Animation* em *Inspector*. Selecione *Sprite Frame* e *New SpriteFrames*, como mostrado abaixo. Clique no nome *SpriteFrames* que apareceu no mesmo local (figura do meio, abaixo), daí o editor de animação (figura da direita, abaixo) deve aparecer. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/ca0a10c6-7b4b-4f6a-a4f6-85119f5294e2" width="1200">
</p>

Começaremos pelo boneco estático, o *idle*. Troque o nome onde está escrito "default" e arraste a imagem do idle, em *FileSystem*, para o editor de animação.

<p align="center">
    <img src="https://github.com/user-attachments/assets/37526b0f-9682-4346-a548-f4791120b9cb" width="600">
</p>

Agora adicione animações para caminhar e tomar dano. Você pode selecionar múltiplas imagens no *FileSystem*.

<p align="center">
    <img src="https://github.com/user-attachments/assets/bcab2a18-a354-495b-ba1d-aa1c0807070f" width="600">
</p>

Estaremos também usando uma tela menor para ficar coerente com o tamanho dos sprites. Além das opções mostradas na figura abaixo, lembre-se de ir em *Rendering* e em *Textures* colocar a opção *Nearest*.

<p align="center">
    <img src="https://github.com/user-attachments/assets/af4ae282-5465-4a7f-92da-7b94c0110569" width="500">
</p>

Adicionar os sprites de animação não é o suficiente, precisamos dizer ao programa quando aquelas animações devem ocorrer. Isso é feito com um script associado ao node raíz do personagem. Repare no primeiro if abaixo. Enquanto o jogador estiver pressionando o botão de se mover para a esquerda, uma velocidade negativa no eixo *x* é acrescentada ao boneco, o que garante que ele vai se deslocar na tela. Após isso o script chama a animação de caminhar. Isso não faz com que ela comece ainda, apenas diz ao programa que o comando `$AnimatedSprite2D.play()` deverá mostrar essa animação. Antes da animação começar, um flip horizontal é aplicado a ela, já que o boneco originalmente está olhando para a direção oposta. Depois disso o play é chamado e aí sim começa a animação. Ela vai continuar até o jogador soltar o botão de caminhar para a esquerda. Não se esqueça de ativar o *Lock Rotation* na física do personagem.

<p align="center">
    <img src="https://github.com/user-attachments/assets/9c7c5270-51fd-4254-bd83-21d1fd4ba49f" width="500">
</p>

## Testando

Para testar se a animação funciona, vamos criar uma cena principal com um chão e o nosso personagem. Também iremos adicionar a medusa com o seu movimento senóide. Toda a configuração dela se encontra no projeto *Getting started/Step by step/Listening to player input/Movements 2*. Não se esqueça de selecionar a opção *Freeze* na física da medusa, caso contrário ela não vai ter colisão. A cena principal deve estar como mostrado abaixo.

<p align="center">
    <img src="https://github.com/user-attachments/assets/7aaa1524-06dc-4c2e-8917-d1c8c54e925f" width="700">
</p>

## Tomando dano

Também vamos simular a animação de dano. São apenas dois quadros de animação, mas isso é o suficiente. Devemos criar um sinal sobre o node raíz do personagem. Como ele é um `RigidBody2D`, possui o sinal `body_entered`, que foi feito para identificar quando outro objeto físico entra em contato com o shape de colisão do personagem. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/0f65cb53-cce8-4ebf-ad6b-92d3190056b5" width="600">
</p>

Adicione a variável global `is_hurt` como falso, no início do script. Depois edite a função `_on_body_entered`, como mostrado abaixo. Devemos colocar a medusa em um grupo (chamado "inimigo" neste exemplo) para que o sinal só tenha efeito com a medusa, caso contrário o próprio chão vai dar dano no personagem. Depois disso a variável `is_hurt` passa a ser verdadeira, indicando que a animação do dano está em vigor. Note que é necessário incluir uma rotina no `_physics_process` para pular a iteração caso `is_hurt` seja verdadeiro. Isso garante que o input não vai cancelar a animação de dano. Também incluímos o sinal `_on_animated_sprite_2d_animation_finished` do `AnimatedSprite2D`. Este sinal é enviado quando uma animação termina.

<p align="center">
    <img src="https://github.com/user-attachments/assets/5e16aa72-16a0-4c7d-88bd-96163ba140ee" width="400">
    <img src="https://github.com/user-attachments/assets/404e6954-b864-4925-b685-69a7c0e5e6f2" width="400">
    <img src="https://github.com/user-attachments/assets/e7a9d3a9-8aa3-47f1-a1dc-b19c3e94e4b1" width="500">
    <img src="https://github.com/user-attachments/assets/76958261-180d-46fa-a474-e7736a1524a4" width="350">
</p>

É necessário selecionar a opção `Contact Monitor` para permitir que um `RigiBody2D` emita sinais em caso de colisão. Por default eles não emitem. Mesmo que você configure todos os sinais bonitinho, sem habilitar essa opção o sinal não é emitido e nada acontece.

<p align="center">
    <img src="https://github.com/user-attachments/assets/f84ddc0c-c0ec-44cd-8cc3-7a3db0539fc6" width="250">
</p>

Por fim, desmarque a opção *Animation Looping* (ao lado do 5.0 FPS), senão o boneco vai ficar em loop na animação para sempre. Por default a animação fica em loop. Isso não causa problema na movimentação pois cada input dá um stop na animação, enquanto que na animação de dano nós desabilitamos os inputs e obrigamos o jogador a esperar a animação de dano. São vários detalhes para se atentar, mas é assim mesmo que é para desenvolver jogos.

<p align="center">
    <img src="https://github.com/user-attachments/assets/77eea654-0054-4a91-a68a-ccbb8557199b" width="350">
</p>
