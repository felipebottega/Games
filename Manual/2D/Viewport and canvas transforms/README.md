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

Salve essa cena do jeito que está e crie uma outra cena chamada *World*, com apenas um node do tipo `Node2D`. Feito isso, coloque a cena inicial dentro da *World* e mova ela de posição. Como podemos ver, dentro da cena *World* o nosso `Node2D` inicial encontra-se em $(44, 112)$. Porém, note que o `Sprite2D` ainda está em $(485, 243)$. Habilitamos o *Editable Child* para poder mostrar isso.

<p align="center">
  <img src="https://github.com/user-attachments/assets/25ef7b75-dced-45a4-9d28-ca02f30e9b2c" width="1100">
</p>

O que está acontecendo é que a posição mostrada no *Transform* sempre diz respeito ao pai do node. Um exemplo mais crítico que ilustra isso é o mostrado abaixo. Claramente o sprite não está na origem do canvas (que é o mesmo do node raíz), mas sua posição está no $(0, 0)$ pois ele está na origem do node pai. É bom sempre lembrar deste exemplo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/5c1529b5-68db-45d0-b70e-8c828afd8e12" width="1100">
</p>


## Transformações lineares entre sistemas

No [tabuleiro de Galton 4](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Canvas%20layers/Galton%20Board%204) vimos sobre o `Viewport.canvas_transform`. Na verdade esse é só um exemplo de aplicação do `Transform2D`, que é uma classe de transformações lineares de Godot. Em particular, estamos interessados na matriz mencionada no projeto. Essa matriz é acessível por qualquer node filho do `CanvasItem`, que é o caso de todos os nodes daqui. O atributo `transform` é acessível por todos estes nodes e sempre nos retorna a matriz do node na cena. Define o script simples mostrado abaixo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e4b600cf-a8de-4bd2-869c-9f6140691807" width="500">
</p>

Se você executá-lo na cena do `Node2D`, vai obter $[X: (1.0, 0.0),\ Y: (0.0, 1.0),\ O: (0.0, 0.0)]$, que se refere aos vetores $e_1, e_2, v_o$ definidos no outro projeto. Isso significa que não aplicamos nenhuma deformação no node e ele não foi transladado da origem. Por outro lado, ao executar a cena `World`, obtemos $[X: (1.0, 0.0),\ Y: (0.0, 1.0),\ O: (44.0, 112.0)]$, pois ele foi transladado da origem nessa cena. O `transform` tem a propriedade de sempre mostrar a coordenadas locais de um objeto, que por definição são as coordenadas em relação ao pai. 



