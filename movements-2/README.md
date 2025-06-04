# Movements 2

Este projeto em Godot deve ser visto como uma continuação do *movements*. Aliás, o *movements 3* será uma continuação deste, e assim por diante. 

Uma estrutura básica de cena que está servindo para mim é a mostrada na figura abaixo. Começa com um node raíz (do tipo `Node` ou `Node2D`) que funciona apenas como conteiner geral, sem fazer nada. O filho deste node é o node que representa o objeto. Neste caso é um `RigidBody2D` pois é o boneco e possui física, mas poderia ser outra coisa. Dentro deste node teremos todos os nodes restantes, que estão no mesmo nível de hierarquia. Após configurar cada um, eu renomeio o node raíz para identificar a cena.

<p align="center">
  <img src="https://github.com/user-attachments/assets/708c830a-f263-4982-b097-c29842e2a0d0" width="700"/>>
</p>


