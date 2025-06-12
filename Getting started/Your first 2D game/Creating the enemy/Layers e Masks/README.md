# Layers e Masks

No tutorial de Godot para [criar inimigos](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/04.creating_the_enemy.html), pela primeira vez aparecem os conceitos novos de *Layers* e *Masks*. Acho que vale a pena dedicar um tempo apenas para cobrir este tópico.

Vamos partir do nosso próprio projeto de [criação de player](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Coding%20the%20player/Animation%201), onde o "jogo" basicamente é a medusa do Castlevania se movendo em loop e tendo a capacidade de ativar uma animação de hit quando toca o nosso boneco (Trevor). A diferença é que agora teremos duas medusas realizando movimentos verticais.

<p align="center">
    <img src="https://github.com/user-attachments/assets/a48d5f58-addc-4244-9505-9d14b1b898ee" width="600">
</p>

## Editable Child e Make Local

Dois arquivos com duas imagens de medusas com cores diferentes foram criados, mas isso não significa que é necessário criar uma cena para cada medusa. Você pode usar a opção *Editable Child* para que uma instância da cena seja editável, mantendo a original intacta enquanto isso. Fizemos isso para usar um sprite para cada medusa.

<p align="center">
    <img src="https://github.com/user-attachments/assets/afb28e2e-5246-44ae-bd17-9b70c55f79c3" width="400">
</p>

Outra opção viável seria o *Make Local*, que fica logo abaixo. A diferença é que o Make Local é um pouco mais "radical", no sentido de que ele fica totalmente desligado da cena original, enquanto que o Editable Child ainda é uma instância dela. Por exemplo, se você mudar a escala da cena original, essa mudança será refletida no Editable Child mas não no Make Local.

## Definição de layer e mask

Todo `RigidBody2D` possui a propriedade de *Layers* e *Masks*, um total de 32 para cada. Cada número destes se refere ao mesmo "espaço". A diferença entre layer e mask é se você está dizendo que seu objeto pertence a um destes espaços ou se ele é capaz de detectar objetos nestes espaços. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/4e152a91-112a-45fa-adde-c551e87ad456" width="350">
</p>

Layer se refere a localização do seu objeto. Se você coloca a layer 2 para ele, significa que ele está na layer 2. Note que é possível adicionar o objeto a múltiplas layers. Mask se refere às layers que o seu objeto é capaz de detectar. Se você colocar mask 2 para ele, isso significa que ele é capaz de detectar todos os objetos que estão na layer 2. 

O objetivo disso é controlar quem pode colidir com quem. Um objeto $A$ só pode colidir com um objeto $B$ se $B$ está na layer $i$ e $A$ tem a mask $i$ ativada, de modo que $B$ é detectável por $A$.

## Exemplo

A medusa da esquerda estará na layer 1 enquanto que a verde estará na layer 2, e ambas com mask 1. Inicialmente o protagonista Trevor estará na layer 1 e com mask 1. Isso significa que ambas as medusas podem detectá-lo e colidir com ele

