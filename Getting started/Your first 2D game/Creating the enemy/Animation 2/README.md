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




