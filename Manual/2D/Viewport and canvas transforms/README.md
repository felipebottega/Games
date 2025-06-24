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

No [tabuleiro de Galton 4](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Canvas%20layers/Galton%20Board%204) vimos sobre o `Viewport.canvas_transform`. Na verdade esse é só um exemplo de aplicação do `Transform2D`, que é uma classe de transformações lineares de Godot. Em particular, estamos interessados na matriz mencionada no projeto. Essa matriz é acessível por qualquer node filho do `CanvasItem`, através do atributo `transform`. Considere o script simples mostrado abaixo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/cb558283-2ed0-4f03-9dac-c2199f7ebe2f" width="250">
</p>

Se você executá-lo na cena do `Node2D`, vai obter $[X: (1, 0),\ Y: (0, 1),\ O: (0, 0)]$ e $[X: (1, 0.0),\ Y: (0, 1),\ O: (485, 243)]$, que se refere aos vetores $e_1, e_2, v_o$ definidos no outro projeto. O node raíz está com os valores default e o sprite está com a translação mencionada acima. Ao executar a cena `World`, obtemos $[X: (1, 0),\ Y: (0, 1),\ O: (44, 112)]$ e $[X: (1, 0),\ Y: (0, 1),\ O: (485, 243)]$. O `Node2D` foi transladado da origem nessa cena. Note que o `transform` do `Sprite2D` não se alterou, pois ele se refere ao sistema de coordenadas local, isto é, em relação ao seu pai e não a cena onde ele está. Isto nada mais é do que acessarmos as informações mostradas acimas por meio de código.

O atributo `transform` é interpretado em Godot como a matriz $2 \times 3$ dada por $\left[ e_1, e_2, v_o \right]$. Assim como temos a posição local dos objetos (em relação ao pai), também temos a posição global deles, que são as coordenadas em relação à tela, o mundo real. O primeiro se chama *Item Coordinates* e o segundo se chama *Canvas Coordinates*. Por estarmos no contexto de álgebra linear, sabemos que existem matrizes de conversão de coordenadas. A matriz que converte as coordenadas locais em globais é dada por `get_global_transform()`, e a matriz que converte coordenadas globais em locais é dada por `get_global_transform().affine_inverse()`. Obviamente, temos que `get_global_transform().affine_inverse()` = `get_global_transform()`$^{-1}$.

Agora vamos considerar o script abaixo. Ele vai nos mostrar todas as informações discutidas aqui. Ao executarmos o script na cena *World*, o vetor $v_o$ se descolou para $(44, 112)$, que é a translação que de fato fizemos com o `Node2D` nesta cena. Daí temos que <p align="center">`get_global_transform()` $\cdot [(1, 0),\ (0, 1),\ (485, 243)] = [(1, 0),\ (0, 1),\ (529, 355)]$.</p> 

Note que $(529, 355) = (485+44, 243+12)$, que é justamente o que esperávamos, é apenas a translação do ponto de acordo com a translação feita no node pai. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/b12fb6e1-54d0-4721-b3a4-19e1cbe4b4cf" width="350">
  <img src="https://github.com/user-attachments/assets/2b7fa680-3a20-4408-817c-62a97d0f17ff" width="350">
</p>

> Atenção: Você não deve aplicar a transformação sobre o próprio `Node2D`. A matriz `transform` é uma "ponte" entre o node pai e seus filhos, ela serve apenas para converter as coordenadas dos filhos. Se você quisesse mudar as coordenadas de `Node2D`, teria que criar um script para o node pai da cena *World* e trabalhar ali, pois nesta cena `Node2D` é um filho. Por esta mesma razão, se você tiver uma cadeia de nodes aninhados e quiser converter as coordenadas do filho no fim da cadeia, tem que colocar o script no pai direto do filho, no penúltimo nível desta cadeia.

## Rotações

Vamos repetir a cena do `Node2D`, mas dessa vez vamos também rotacionar o sprite por $45^\circ$. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/83f65359-a89d-41d2-b237-2e9fda3509f0" width="1100">
</p>

Ao executar o primeiro script, vemos que `$Sprite2D.transform` $= [X: (0.707107, 0.707107),\ Y: (-0.707107, 0.707107),\ O: (485, 243)]$. Não há nada demais na translação, já sabemos o que está acontecendo. Mas e os vetores $e_1, e_2$? Basta desenhá-los no plano e a situação fica bastante clara. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/388b190b-016f-4c3e-a2a5-8ac56a20a81e" width="300">
</p>

Vendo a imagem do editor já sabíamos que a rotação era no sentido horário, mas agora a posição dos vetores mata qualquer possível dúvida em relação a isso.

E como que fica a situação se colocarmos o `Node2D` no *World* e rotacioná-lo? A resposta para isso reside na própria cena do `Node2D`. Abaixo, a figura de cima mostra a situação em que apenas o sprite foi rotacionado (por $45^\circ$), e na figura seguinte o `Node2D` foi rotacionado por $10^\circ$. Podemos ver que essa rotação extra foi aplicada ao sprite, só que o pivô central da rotação é no centro do `Node2D`. Ou seja, funciona como uma composição de rotações.

<p align="center">
  <img src="https://github.com/user-attachments/assets/f39ca2d8-a0ee-496f-9d80-85178f792598" width="1200">
</p>

Por mais que a rotação do `Node2D` tenha acrescentado um pouco mais de rotação ao sprite em relação à tela, seu ângulo ainda é de $45^\circ$ pois este é o ângulo em relação ao pai. 

Acredito que não seja necessário levar o `Node2D` para o *World* para checar que este comportamento irá se repetir lá. Inclusive, o experimento da translação poderia ter sido feito na cena do `Node2D`. Se ele for transladado da origem, a posição do sprite continuará a mesma (no `transform` e no Inspector), pois ela sempre é em relação ao node pai. Apenas fizemos essa mudança de cena para efeito didático, pois é o que vai acontecer mais vezes na prática.

Vale ressaltar que quaisquer outros efeitos de mudar escala e distorção seguem a mesma lógica, isto é, os valores mostrados são os valores em relação ao node pai. Além disso, ressaltamos também que as transformações de converter coordenadas levam em conta tudo o que discutimos até aqui, não apenas translações.
