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

Começamos criando uma cena com um `Node2D` contendo um `Sprite2D` (poderia ser apenas o `Sprite2D` mas eu não fiz isso só para evitar o warning do editor). Chame o node raíz de *Wolverine*, pois será uma imagem dele. Vá em *Inspector → Sprite2D → Texture → Setinha da direita (ou no empty) → New CanvasTexture*. Depois clique em *Canvas Texture* que apareceu na aba do *Texture*. 

<p align="center">
   <img src="https://github.com/user-attachments/assets/5911c959-a305-49c0-93ea-677ee18a9212" width="220">
   <img src="https://github.com/user-attachments/assets/b3bed145-6252-4128-9ce8-09054affcf03" width="270">
</p>

A aba *Diffuse* é para a figura do sprite normal, e a aba *NormalMap* é para a figura do normal map do sprite. A figura do normal map (até onde eu sei) é um PNG. Arraste as suas duas figuras para suas respectivas abas.

<p align="center">
   <img src="https://github.com/user-attachments/assets/a4d0530a-6b8d-4ab9-b638-bd0146bc5200" width="270">
</p>

A cena Main será um `Node2D` contendo um background preto e a cena do Wolverine. Apenas isso não basta para vermos o efeito do normal map, lembre que o propósito dele é reagir à luz. Então vamos adicionar luz ao nosso projeto (não se esqueça de adicionar textura para a luz). Note que é possível já interagir com a luz e o sprite no próprio editor, sem precisar carregar a cena.

https://github.com/user-attachments/assets/c5255852-55b5-4019-b785-546b5cc12fb5

## Luz seguindo o mouse

Poderíamos parar por aqui e isso já seria o suficiente para muitos jogos com luz estática. Para fins didáticos, faremos um projeto em que a luz se move junto com o mouse, assim como é no editor. Além disso, colocaremos alguns sliders para alterar certos parâmetros de iluminação. Basicamente estamos trazendo algumas ferramentas do editor para a cena. Crie um script para a Main e coloque o código abaixo nele.

<p align="center">
   <img src="https://github.com/user-attachments/assets/af6cdd02-d96a-4a74-9fd1-b05825151d72" width="400">
</p>

Depois disso, acrescentamos os sliders (e labels para identificar) dos parâmetros que estamos interesasdos. Não esqueça de fazer o HUD ser *Editable Child* na Main, pois só assim você consegue mover seus objetos. Isso acontece porque ele reside numa outra camada, mas não vamos explorar este tópico aqui.

<p align="center">
   <img src="https://github.com/user-attachments/assets/c18de11e-ef94-4949-a571-69e7c07166fa" width="1000">
</p>

## Criando normal maps

Como normal maps são figuras PNG, você pode simplesmente desenhar um na mão, editando os pixels. Porém, vamos pegar o caminho mais fácil e usar um programa feito para gerar normal maps. Na própria documentação da Godot eles indicam uma feramenta chamada [Laigter](https://docs.godotengine.org/en/stable/tutorials/2d/2d_lights_and_shadows.html#normal-and-specular-maps). Baixe e instale o programa no seu computador.

Abaixo segue um resumo dos itens básicos do programa para gerar seus normal maps.



![image](https://github.com/user-attachments/assets/4c83e9f1-d0c5-4c84-b9cb-84c827566565)

