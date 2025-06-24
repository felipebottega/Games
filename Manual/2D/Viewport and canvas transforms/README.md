# Viewport and canvas transforms

Vamos falar sobre sistemas de coordenadas neste tutorial. Começamos inicializando uma cena simples, um  `Node2D` contendo o `Sprite2D` do logo da Godot.

<p align="center">
  <img src="https://github.com/user-attachments/assets/41c58729-46fe-497f-981d-99dfbf2ec4c2" width="600">
</p>

Se você for no Inspector agora e abrir a aba *Transform* de ambos, as posições deles devem ser $(0, 0)$. A figura abaixo mostra isso, o `Node2D` à esquerda e o `Sprite2D` à direita.

<p align="center">
  <img src="https://github.com/user-attachments/assets/26904547-7b24-4582-acbc-a255593bb572" width="150">
  <img src="https://github.com/user-attachments/assets/eb8dd125-bf5f-42cf-9c85-f6e4a6584019" width="140">
</p>

## Sistema de coordenadas locais

Agora vamos mover apenas o node do sprite. Repare que o `Node2D` continua na origem enquanto que o filho mudou de posição.

<p align="center">
  <img src="https://github.com/user-attachments/assets/98985292-8f48-4731-8de3-4ebe335d9f0b" width="500">
  <img src="https://github.com/user-attachments/assets/be7340a8-4fce-47d3-95a3-780a5a633f1e" width="150">
  <img src="https://github.com/user-attachments/assets/8eeb30c8-eaf5-47a7-8eba-394a590aad56" width="150">
</p>

Salve essa cena do jeito que está e crie uma outra cena chamada *World*, com apenas um node do tipo `Node2D`. Feito isso, coloque a cena inicial dentro da *World* e mova ela de posição. Dentro da cena *World* a nossa cena inicial foi colocada na posição $(44, 112)$, mas note que o `Sprite2D` ainda está em $(485, 243)$. Habilitamos o *Editable Child* para poder mostrar isso.

<p align="center">
  <img src="https://github.com/user-attachments/assets/25ef7b75-dced-45a4-9d28-ca02f30e9b2c" width="1100">
</p>

O que está acontecendo é que a posição mostrada no *Transform* sempre diz respeito a posição do node em relação ao seu pai. Um exemplo mais crítico que ilustra isso está mostrado abaixo. Claramente o sprite não está na origem, mas sua posição está no $(0, 0)$ pois ele está na origem do node pai. É bom sempre lembrar deste exemplo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/5c1529b5-68db-45d0-b70e-8c828afd8e12" width="1100">
</p>

## Atributo transform

No [tabuleiro de Galton 4](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Canvas%20layers/Galton%20Board%204) vimos sobre o `Viewport.canvas_transform`. Na verdade esse é só um exemplo de aplicação do `Transform2D`, que é uma classe de transformações lineares de Godot. Em particular, estamos interessados na matriz mencionada no projeto. Essa matriz é acessível por qualquer node filho do `CanvasItem` através do atributo `transform`. Considere o script simples mostrado abaixo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/cb558283-2ed0-4f03-9dac-c2199f7ebe2f" width="500">
</p>

Se você executá-lo na cena do `Node2D`, vai obter $[X: (1.0, 0.0),\ Y: (0.0, 1.0),\ O: (0.0, 0.0)]$ e $[X: (1.0, 0.0),\ Y: (0.0, 1.0),\ O: (485.0, 243.0)]$, que se refere aos vetores $e_1, e_2, v_o$ definidos no outro projeto. O node raíz está com os valores default e o sprite está com a translação mencionada acima. Ao executar a cena `World`, obtemos $[X: (1.0, 0.0),\ Y: (0.0, 1.0),\ O: (44.0, 112.0)]$ e $[X: (1.0, 0.0),\ Y: (0.0, 1.0),\ O: (485.0, 243.0)]$. O `Node2D` foi transladado da origem nessa cena. Note que o `transform` do `Sprite2D` não se alterou, pois ele se refere ao sistema de coordenadas local, isto é, em relação ao seu pai e não a cena onde ele está. 



