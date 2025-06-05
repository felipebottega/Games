# Galton Board - version 1

Minha primeira tentativa fazer um [tabuleiro de Galton](https://pt.wikipedia.org/wiki/Tabuleiro_de_Galton) em Godot. A implementação deste "jogo" usa apenas conceitos básicos de corpos rígidos e física. 

Para que a visualização no site ocorra normalmente é necessário ir em *Project → Project Settings → Display → Window*, colocar *Initial Position Type = Absolute*, *Mode = viewport* e *Aspect = keep*. Também é importante que as dimensões da viewport estejam de acordo com o que você definiu. Estou deixando isso aqui registrado pois não foi óbvio para mim logo de primeira.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e2ef8e5c-e25c-4d3d-b18a-a3ec841d8034" width="550"/>
</p>

Neste projeto eu aprendi a usar a classe `Node` como conteiner. Fora o uso como node raíz, eu usei essa classe para definir os conteiners `Walls`, `Small_Balls` e `Pins{i}`. Cada um destes é um conjunto de nodes de um mesmo tipo. As bolas são as bolinhas que caem, os pins são os obstáculos onde as bolas batem durante o percurso, e as paredes são quaisquer paredes na cena. Vale notar que os pins são apenas paredes redimensionadas para serem minúsculas (portanto cada pin é um quadrado).

Um coisa importante também que aprendi foi o uso de *ctrl+C* *ctrl+D* para duplicar uma seleção de nodes. A partir disto pude repetir as fileiras dos pins apenas duplicando a primeira já existente.

<p align="center">
  <img src="https://github.com/user-attachments/assets/7ea3685a-f061-4759-9852-2f6a446a6c33" width="100"/>
</p>

Por fim, no tabuleiro de Galton é importante que o shape dos pins forme um quadrado. No meu caso eles ficaram mais com uma forma de diamante, e isso fez com que a ditribuição final fosse um pouco diferente da distribuição normal. 
