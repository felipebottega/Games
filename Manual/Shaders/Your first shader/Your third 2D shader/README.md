# Your third 2D shader

Este tutorial é o último da série *Your ith shader*. Parte dele é baseado neste [video do youtube](https://www.youtube.com/watch?v=f4s1h2YETNY) que é muito bom para entender a dinâmica de shaders, assumindo que você já entende de [GLSL](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Introduction%20to%20shaders#introduction-to-shaders).

No tutorial anterior, eu apenas comentei sobre um dos efeitos e deixei o restante para a pessoa testar e acessar o código para ler e entender. Como esse aqui trata de efeitos mais básicos, faço questão de explicar um por um. No total, vamos passar por 14 efeitos. Porém, alguns deles são sequenciais, ou seja, pega um efeito anterior e acrescenta uma coisa pequena por cima. Está bem didático.

## Leitura da texturas do frame anterior no shader

Antes mesmo de falar dos experimentos, precisamos falar de uma técnica importante para certos tipos de shader. Existem casos em que o shader trabalha de forma iterativa, ou seja, ele não é apenas um efeito que atua sobre uma textura estática (todos os shaders do [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20second%202D%20shader) foram assim), mas sim um efeito que atua sobre o output do próprio efeito na textura no frame anterior. Isso significa que, a cada frame, a textura com o efeito do shader precisa se armazenada na memória e passada para a GPU no frame seguinte. Note que isso necessita de passar a textura completa entre CPU e GPU 2 vezes por frame. 

> PS: Dependendo do tipo de shader a ser aplicado, pode não ser necessário passar a textura completa entre CPU e GPU a cada frame. Vamos adotar o approach menos otimizado por ser rápido o suficiente para as nossas aplicações e também por ser mais simples.

Em todos os experimentos, a estrutura principal da árvore é a mostrada abaixo. Precisamos do `SubViewport` pois é esse node que nos permite salvar a textura. 

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/0dde028f-71ba-4766-bd75-b31fb95b68ae" />
  <img width="460" src="https://github.com/user-attachments/assets/72ec061d-2987-4d5c-9c61-d455bb217982" />
</p>


## Experimento 1

