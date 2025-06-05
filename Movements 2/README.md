# Movements 2

Este projeto em Godot deve ser visto como uma continuação do *Movements 1*. Aliás, o *Movements 3* será uma continuação deste, e assim por diante. 

Uma estrutura básica de cena que está servindo para mim é a mostrada na figura abaixo. Começa com um node raíz do tipo `RigidBody2D` (que chamei de "Medusa" no exemplo) que contém as propriedades físicas para um sprite. A partir deste node teremos dois nodes filhos no mesmo nível de hierarquia. Um é define o sprite e outro a colisão. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/f84c431f-ed30-4d49-a3fc-9240b6fe6d87" width="200"/>
</p>

Como esse projeto é em 2D pixelado, recomendo repetir os passos do projeto anterior em relação ao viewport e rendering. Feito isso, criamos a cena principal, que é do tipo `Node` e apenas funciona como um conteiner para os principais objetos da cena. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/00781df1-2785-451f-9475-e3624b6b0934" width="700"/>  
</p>

Para o node `Trevor`, configuramos o seu peso, que ficou em 70 kg. A gravidade igual a 1.0 significa que estamos utilizando a gravidade da Terra. Também marcamos a opção *Lock Rotation*. Isso significa que o boneco vai ficar em pé e reto independente das forças que atuam sobre ele. Sem isso ele poderia rolar para frente ou para trás quando começasse a caminhar.

<p align="center">
    <img src="https://github.com/user-attachments/assets/6d7e357b-4ae5-4f61-b0f9-3fe7f0b09731" width="300">
</p>

O node `Floor` só teve um tratamento diferenciado, em vez de ser um `RigidBody2D` ele é um `StaticBody2D`. Como o nome já diz, é um objeto que por definição deve ficar estático. 



