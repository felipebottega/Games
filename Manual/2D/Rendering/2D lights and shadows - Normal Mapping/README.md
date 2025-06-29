# Normal Mapping

Um *mapa normal* (*normal map*) no contexto de jogos 2D é uma imagem usada para simular relevo e detalhes de iluminação em um objeto 2D, sem precisar modelar esse relevo de verdade. Neste mapeamento o vermelho (R) representa a inclinação da superfície no eixo X, o verde (G) representa a inclinação no eixo Y, e o azul (B) representa o quanto a superfície aponta "pra frente", ou seja, o eixo Z. Essas cores não são para serem vistas como arte, mas sim para serem interpretadas pela engine.

As duas figuras são exatamente a mesma, não há nenhum efeito 3D de verdade acontecendo. A figura da esquerda tem um normal map embutido que dá esse efeito quando reage à luz, mas o normal map em si é apenas um sprite 2D.

https://github.com/user-attachments/assets/e7e3a257-4674-4e11-a317-f68cf6d81b5c

Abaixo, temos o cubo e o seu normal map associado. Geralmente as cores de um normal map tem essa cara mesmo. É possível obter diversos normal maps para a mesma figura original, tudo depende de como você configura o seu normal map. Veremos mais adiante como gerar um.

<p align="center">
   <img src="https://github.com/user-attachments/assets/98c99254-57d5-4512-a691-7344144f7399" width="450">
</p>

## Normal map na prática

Vamos mostrar um de projeto contendo apenas uma figura com normal map, mas o projeto de Godot nesta página contém diversos outros exemplos para você checar depois. Você pode baixar o projeto ou pode interagir com ele diretamente [por aqui]().


