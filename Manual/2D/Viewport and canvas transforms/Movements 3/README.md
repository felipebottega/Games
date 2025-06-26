# Movements 3

Este jogo é uma aplicação do que foi visto sobre rotações [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Viewport%20and%20canvas%20transforms#rota%C3%A7%C3%B5es). A ideia central é que se um filho estiver a uma certa distância do pai (foi transladado) e o pai rotacionar, o filho rotaciona junto de longe, como se orbitasse o pai. Se esse filho tem outros filhos, eles rotacionam junto.

## Sprites de sprites

Os objetos principais deste jogo, onde tudo começou, são os sprites *A, B, C, D, E*. Temos que *A* é o maior sprite no centro, *B* é o segundo, e assim por diante. Note que é uma sequência aninhada de sprites. Rotacionar *A* faz todos os seguintes rotacionarem, rotacionar *B* faz *C, D, E* rotacionarem, e assim por diante. Deste modo, *B* orbita *A*, *C*  orbita *B*, etc. O comportamento de fato é semelhante ao de planetas, mas com órbitas perfeitamente circulares.

<p align="center">
  <img src="https://github.com/user-attachments/assets/bc7fd5c7-0e56-4da4-9243-f6454a44604b" width="500">
</p>

Cada sprite contém o script simples mostrado abaixo. O atributo `modulate` serve para alterar as cores do sprite, não é nada demais. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/92f1f5e3-dd99-491f-a67d-de34f13da64a" width="250">
</p>

## Rastro de sprites

Para os comportamentos orbitais, o que foi descrito anteriormente basta. Mas não paramos por aí, queremos mais beleza para o jogo! O script do node principal da cena contém a lógica para que cada sprite deixe um "rastro" por onde passa, como um cometa. Vou explicar alguns trechos do código. Primeiramente, o comando `@export var sprite_scene: PackedScene` cria um espaço no Inspector para arrastar cenas. No nosso caso, arrastamos a cena `sprite_2d.tscn`, que é o mesmo sprite de *A, B, C, D, E*. Esse comando é equivalente a `preload("res://scenes/sprite_2d.tscn")`, que já foi abordado no [tutorial Add Child](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Add%20Child#packedscene). 

O parâmetro `delay` controla quando um sprite do rastro será adicionado, usando a variável `time_passed` como auxiliar. O parâmetro `factor_scale` aplica uma mudança de escala, pois podemos querer um rastro menor que o próprio sprite (isso dá ainda mais uma cara de cometa para o rastro). O parâmetro `seconds` é o tempo de vida so rastro, caso contrário teríamos um acúmulo de sprites na tela que iriam acabar com a capacidade da máquina. Esse parâmetro é passado para a função `start_lifetime` dentro do script da cena `sprite_2d.tscn`. Essa função foi feita para destruir o sprite após essa quantidade de segundos.

<p align="center">
  <img src="https://github.com/user-attachments/assets/413b2296-f478-40cf-a26d-c33ce101cfb2" width="500">
</p>

## Menu principal

Este é o meu primeiro projeto que possui uma cena especificamente para o menu. À primeira vista, ela contém apenas um botão para iniciar o jogo, um botão para mostrar instruções e um background móvel. Aliás, note que o script está todo no background. O `_process` contém a lógica que faz o backrgound se mover em torno do botão de Start enquanto muda sua escala suavemente também. Ao pressionar no botão de instruções, vários itens se omitem e o sprite com as instruções se abre, além do background sofrer uma aplicação do `modulate` que o deixa mais escurecido. O botão de start executa a linha `get_tree().change_scene_to_file("res://scenes/rotations_composition.tscn")`, que serve para mudar fazer mudança de cena.

<p align="center">
  <img src="https://github.com/user-attachments/assets/40201d8e-2e33-4df4-921a-65cc47c8c753" width="900">
</p>

## HUD de sliders

A cena do HUD é basicamente um monde de sliders horizontais. Para configurar a aparência do `HSlider`, você deve ir em *Inspector → Control → Styles*, colocar *StyleBoxFlat* em cada item e explorar o que tem. Vimos um pouco sobre sliders no [Galton Board 3](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Heads%20up%20display/Galton%20Board%203). Ao adicionar estes sliders, precisamos alterar o script da cena de movimentos para que eles tenham efeito. Abaixo, mostramos como fica o novo `_ process`.

<p align="center">
  <img src="https://github.com/user-attachments/assets/7ddaef52-a7d4-4194-9b8f-864d36bc09c6" width="200">
  <img src="https://github.com/user-attachments/assets/dca417f3-c129-42cc-92b0-17a570447241" width="450">
</p>
