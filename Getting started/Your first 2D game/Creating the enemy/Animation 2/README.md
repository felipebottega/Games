# Animation 2

Neste pequeno projeto nós vamos aprender sobre *Arrays*, como acessar as animações de um `AnimatedSprite2D` por GDScript, fazer escolhas aleatórias e detectar se um objeto está fora da tela.

## Arrays

Um *Array* em GDScript é o mesmo que uma *lista* em Python. Pode ser tratado e manipulado de maneira muito parecida. Segue abaixo alguns comandos básicos com arrays.

  - `arr = [1, "2", 3, 4, RigidBody2D] ` (cria um array)
  - `arr[1]` (acessa um elemento do array)
  - `arr.append(3)` (acrescenta um elemento ao final do array)

Em particular, usaremos o método `pick_random` para selecionar um elemento aleatório do array.

## Animações

Vamos relembrar rapidamente como acrescentar animações para o seu boneco. Começamos criando a estrutura principal da cena da árvore dele.

<p align="center">
    <img src="https://github.com/user-attachments/assets/127c3452-87b0-4f71-a117-eee5dbca3853" width="200">
</p>

Vá em `AnmatedSprite2D` → *Inspector → Animation → Sprite Frames → New SpriteFrames* e clique novamente no mesmo local onde estava *New SpriteFrames* (agora terá escrito *SpriteFrames*, o novo objeto de edição que você acabou de criar).  

<p align="center">
    <img src="https://github.com/user-attachments/assets/2a53779f-8841-41c6-a5db-834870486863" width="250">
</p>

Crie três tipos de animação e arraste os respectivos sprites de *FileSystem* para a caixa de edição ao lado. Faça isso para os três tipos. A *Animation Speed* (espaço onde está escrito "5 FPS") pode ser editada à vontade, recomendo escolher entre 3 e 6 FPS. Deixe o *Animation Looping* ligado para todos (ícone ao lado do *Animation Speed*, por default já vem ligado).

<p align="center">
    <img src="https://github.com/user-attachments/assets/f221ad2b-5a7b-49e0-add1-d580b4e7a6db" width="700">
</p>

Aproveite para já colocar a shape de colisão no boneco.

## RigidBody2D vs CharacterBody2D vs Node2D

Se você não quer usar a física, e quer controle total sobre a posição, o tipo de node ideal seria `CharacterBody2D` (se quer colisão com controle) ou `Node2D` (se for visual apenas). `RigidBody2D` só deve ser usado se você quer que o movimento obedeça as leis da física, como gravidade, colisões, impulsos etc. Um resumo geral é dado na tabela abaixo.

<p align="center">
    <img src="https://github.com/user-attachments/assets/355f04a9-ad66-4cc8-a113-694a3ae10d6c" width="800">
</p>

Vale ressaltar que essa é uma tabela de recomendações, não de regras absolutas. Em diversos exemplos anteriores nós criamos a medusa como `RigidBody2D` e mudamos sua posição manualmente com o `position`. O `RigidBody2D` é controlado pelo motor de física da Godot. Quando você define a posição diretamente, está lutando contra o sistema de física, que pode sobrescrever sua posição no mesmo frame ou nos seguintes. Isso causa comportamentos inconsistentes. Nos nossos exemplos anteriores tudo ficou ok, mas vamos tentar fazer as coisas corretas daqui para frente. 

## Animações com aleatoriedade

O script do boneco está mostrado abaixo. Ele começa definindo um array de fatores de velocidade e escolhe aleatoriamente um deles. Depois, define um array com os nomes das animações ("fly", "swim", "walk"), escolhe um deles aleatoriamente e dá play na animação. Na função `_process`, o boneco se locomove um pouco para frente no eixo $x$ a cada frame. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/c1365882-1a4a-4b0f-94db-043c10f5ee13" width="500">
</p>

> PS: Se você trocar o `CharacterBody2D` por `RigidBody2D` (e tirar a gravidade no segundo caso), vai notar que o boneco fica um pouco parado no início. Esse comportamento inesperado se deve ao que falamos anteriormente sobre forçar posição em um `RigidBody2D`. É possível, mas pode levar a comportamentos inesperados.

## VisibleOnScreenNotifier2D

Agora vá para o node `VisibleOnScreenNotifier2D` e ative o sinal `screen_exited`.

<p align="center">
    <img src="https://github.com/user-attachments/assets/59ed5a8f-d50f-4622-9a0a-b40462834f77" width="800">
</p>

Na função `_on_visible_on_screen_notifier_2d_screen_exited`, basta acrescentar o comando `queue_free()`. Isto coloca o rsepectivo node na fila para ser deletado ao fim do frame. Como o sinal foi feito para ser emitido apenas quando o sprite sair da tela, isso é exatamente o que queremos, pois vai evitar armazenar objetos sem utilidade na memória.
