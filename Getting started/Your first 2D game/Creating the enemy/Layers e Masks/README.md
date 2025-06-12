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

Todo `RigidBody2D` possui a propriedade de *Collision Layers* e *Collision Masks*, um total de 32 para cada. Cada número destes se refere ao mesmo "espaço". A diferença entre layer e mask é se você está dizendo que seu objeto pertence a uma camada ou se ele é capaz de detectar objetos em alguma camada. Pense nas layers como sendo as camadas em que o objeto está presente e masks como sendo as camadas com as quais camadas ele quer colidir. A colisão é registrada do ponto de vista do `RigidBody` ou outro objeto "ativo", fazendo oposição a `StaticBody`, que é passivo. É possível adicionar o objeto a múltiplas layers ou masks. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/4e152a91-112a-45fa-adde-c551e87ad456" width="350">
</p>

O objetivo disso é controlar quem pode colidir com quem. Um objeto $A$ só pode colidir com um objeto $B$ se $B$ está na layer $i$ e $A$ tem a mask $i$ ativada, de modo que $B$ é detectável por $A$. 

> Corner case: Suponha um `RigidBody` que não está em nenhuma layer e detecta mask=1, e um `StaticBody` que está na layer 1 mas nenhuma mask. Neste caso, o `RigidBody` busca ativamente por corpos na layer 1 e vai encontrar o `StaticBody`, de modo que haverá colisão se eles se encontrarem. Agora suponha o contrário, o `RigidBody` na layer 1 sem nenhuma mask, e um `StaticBody` sem nenhuma layer mas com mask=1. Neste caso não haverá colisão pois o `StaticBody` não faz nada ativamente. Aliás, adicionar masks em corpos estáticos não tem efeito algum por eles serem passivos.

## Exemplo

A medusa da esquerda estará na layer 1 e com mask 2, enquanto que a verde estará na layer 2 e com mask 1. O boneco estará na layer 1 e com mask 3 para identificar o chão, que deverá estar na layer 3. Isso significa que o boneco não está buscando colisão com nenhum inimigo, ele quer apenas ficar em terra firme, são os inimigos que querem colidir com ele! Neste caso, apenas a medusa verde (da direita) pode colidir com ele, pois ela está buscando corpos na layer 1.

