# Movements 2

Este projeto em Godot deve ser visto como uma continuação do *Movements 1*. O *Movements 3* será uma continuação deste, e assim por diante. 

Uma estrutura básica de cena que está servindo para mim é a mostrada na figura abaixo. Começa com um node raíz (neste exemplo é do tipo `RigidBody2D` e o chamei de "Medusa") que contém as propriedades definidoras do sprite. A partir deste node teremos dois nodes filhos no mesmo nível de hierarquia. Um define o sprite e outro a colisão. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/f84c431f-ed30-4d49-a3fc-9240b6fe6d87" width="200"/>
</p>

>PS: A palavra "sprite" na engine Godot se refere a imagem usada para o objeto, enquanto que em muitos outros contexto sprite é o objeto em si. Aqui eu estarei usando para ambos os casos sem muita preocupação. O contexto deve deixar claro o significado da palavra.

Como esse projeto é em 2D pixelado, recomendo repetir os passos do projeto anterior em relação ao viewport e rendering. Feito isso, criamos a cena principal, que é do tipo `Node` e apenas funciona como um conteiner para os principais objetos da cena. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/00781df1-2785-451f-9475-e3624b6b0934" width="700"/>  
</p>

Para o node `Trevor`, configuramos o seu peso, que ficou em 70 kg. A gravidade igual a 1.0 significa que estamos utilizando a gravidade da Terra. Também marcamos a opção *Lock Rotation*. Isso significa que o boneco vai ficar em pé e reto independentemente das forças que atuam sobre ele. Sem isso ele poderia rolar para frente ou para trás quando começasse a caminhar.

<p align="center">
    <img src="https://github.com/user-attachments/assets/6d7e357b-4ae5-4f61-b0f9-3fe7f0b09731" width="300">
</p>

O node `Floor` só teve um tratamento diferenciado, em vez de ser um `RigidBody2D` ele é um `StaticBody2D`. Como o nome já diz, é um objeto que por definição deve ficar estático. 

No node `Medusa` marcamos a opção *Freeze*. Isso significa que este objeto não sente gravidade ou qualquer tipo de força externa. A ideia é que a medusa faça o seu percurso ondulatório, tenha colisões, mas não altere a trajetória por nada. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/66ed09bf-035b-4bda-84e0-83e0aaaea4bd" width="300">
</p>

>PS: Se os dois objetos são `RigidBody2D` com caixa de colisão (`CollisionShape2D`), então eles só colidem fisicamente se a movimentação for controlada pela física (ou seja, por forças, torques, impulsos). Se você move o objeto manualmente, como definindo um percurso (que é o caso da Medusa), você está sobrescrevendo a física, e a colisão não ocorre. Quando você marca o `RigidBody2D` como *Freeze*, ele congela e se comporta como um corpo estático. Isso faz com que os outros corpos físicos reconheçam a colisão corretamente, porque agora ele é tratado como uma barreira fixa no espaço, tipo um `StaticBody2D`.

## Posicionamento inicial dos sprites

No *Movements 1* eu usei a opção *Make Local* para forçar a cena principal a reconhecer as posições novas dos sprites. Sem isso ele usava sempre a posição da cena original do sprite em questão. O meu erro lá foi atribuir um valor à variável `orig_pos` logo no início do script. Essa atribuição é feita antes da cena principal "rodar", então o programa pega a posição do sprite original. A solução disso é simples, basta fazer essa atribuição após a cena iniciar, dentro da função `_ready`. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/5c64faad-ddd2-4e76-b974-a8c31881d619">
</p>

## Inputs

Vá na parte de inputs da Godot e marque para mostrar as ações built-in. É possível utilizar qualquer uma destas sem precisar configurar nada. No nosso caso, vamos configurar nossos comandos para mostrar como se faz.

<p align="center">
    <img src="https://github.com/user-attachments/assets/46dce056-0e67-466a-9313-85a3ccba38e8" width="650">
</p>

Agora vá em *Add New Action* e crie um nome para o novo comando. Neste exemplo vamos chamá-lo de "walk_right". Depois disso clique em "+Add". Você vai reparar que o seu comando foi para o final da lista. Na linha onde está o seu comando, tem um "+" que é o botão de *Add Event*. Ao clicar neste botão, o computador vai esperar que você pressione uma tecla que estará associada ao comando "walk_right". Pressione a tecla e dê ok. Faremos isso para ele andar para a direita, esquerda e pular com espaço.

<p align="center">
    <img src="https://github.com/user-attachments/assets/3d294a4c-5770-462f-9866-cf4ec851b203" width="650">
</p>

Abaixo segue o script completo do node `Trevor`, ele é pequeno mesmo. Note que `linear_velocity` é um atributo nativo do `RigidBody2D`. Usamos ele para responder aos inputs, como pode ser visto claramente. A medida é em pixels/segundo. Note a lógica usada para permitir o pulo. Além do jogador ter que pressionar o espaço, é necessário que a velocidade vertical do boneco seja quase zero. Não coloquei igual a zero para permitir ele pular mais rapidamente ao tocar no chão. Porém isso introduziu um bug de pulo infinito já que a velocidade vertical é igual a zero quando o boneco deu um pulo e está transicionando da subida para a queda. Isso não é tão grave para este exemplo, mas já mostra os tipos de desafios que podem vir pela frente.

<p align="center">
    <img src="https://github.com/user-attachments/assets/cb0e7491-3998-46f3-96a6-2cc130b92558" width="600">
</p>

