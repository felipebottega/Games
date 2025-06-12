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

## Layers

