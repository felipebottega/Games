# Your first 2D shader

Este será um tutorial simples, apenas vamos ver os passos básicos para começar a trabalhar com shaders em 2D.

## Primeiros passos

Vamos trabalhar com um `Sprite2D` filho de um node raíz `Node2D`, mas poderia ser outro node fiho do `CanvasItem` possuindo material. Clique para abrir a aba *Material* no *Inspector* e depois clique no campo onde está o *empty* ao lado. Feito isso, clique em *Shader Material*. Vai aparecer um campo novo contendo uma imagem de uma esfera 3D.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/0fa8c6c8-b23d-4898-a1e1-6ca95328c35e" />
</p>

Repare que no lado esquerdo da imagem da esfera, há 3 ícones. Cada um altera o objeto, podendo ser uma esfera, um cubo, ou um plano. Estes objetos estão aí para dar um preview do efeito dos shaders nestes objetos canônicos.  

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/e1f5c8a7-73d0-4348-8fde-429701ccce50" />
</p>

Abaixo dessa parte, há o campo *Shader*, que está como *empty* por enquanto. Clique nele e selecione *New shader*. Isso vai abrir a janela mostrada abaixo. Você pode alterar o nome do arquivo se quiser, mas o restante já está configurado corretamente e não precisa de alterações.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/4b30467e-2013-4d06-8f87-4c0f7d37b0a7" />
</p>

Depois de clicar para criar, volte para o *Inspector*, no mesmo campo onde apareceu o arquivo agora. Clique no nome dele. Isso vai abrir o painel de edição do shader. Agora tudo está pronto para começar o trabalho de verdade.

<p align="center">
  <img width="280" src="https://github.com/user-attachments/assets/d3536d68-029e-4d5d-b8c9-73c5c3195a68" />
  <img width="720" src="https://github.com/user-attachments/assets/e9cbb768-74b8-4213-80bd-224e4d0d1c6f" />
</p>

## Escrevendo código no shader

Em Godot, todos os shaders começam com uma linha especificando o tipo de shader que são. Neste caso a linha deve ser `shader_type canvas_item;`. Note que o template inicial do shader já vem com essa linha escrita, assim como as funções de processamento já vem declaradas e prontas para serem preenchidas.

A função `fragment()` é executada para cada pixel em um `Sprite2D` e determina qual cor esse pixel deve ter. A função `fragment()` mais básica não faz nada além de atribuir uma única cor a cada pixel. Fazemos isso escrevendo um `vec4` na [valor nativo](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20first%202D%20shader) `COLOR`. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/0ac96d2a-10d3-4fee-a7c3-a6cd4cac3604" />
</p>

> PS: O código do shader não atua apenas no objeto de preview no *Inspector*, ele também atua automaticamente na própria cena no editor.

As coordenadas `UV` são especificadas no seu `Sprite2D` e indicam ao shader onde ler as texturas. Você só pode ler as coordenadas `UV`, mas pode usá-las em outras funções ou para atribuir valores diretamente à `COLOR`. O valor de `UV` varia entre 0 e 1 da esquerda para a direita e de cima para baixo. A figura abaixo ilustra isso claramente.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/66a0a14b-ff1f-45b1-a99f-cbdd994be4de" />
</p>

Vamos usar o comando `COLOR = vec4(UV, 0.5, 1.0);` de exemplo. Esse comando define a cor de cada pixel com base na sua posição na textura. O valor horizontal `UV.x` controla o vermelho, o vertical `UV.y` controla o verde, o azul fica fixo em 0.5 e o alpha em 1.0, resultando em um gradiente onde a posição determina a cor. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/6778c649-5ba3-48b6-9af8-67ea37ef9e06" />
</p>

## Diferença de manipular o COLOR e o modulate

Caso você vá no *modulate* do `Sprite2D` agora, vai notar que o RGB dele está em $(1.0, 1.0, 1.0)$. Esse valor equivale à cor branca e ele é multiplicado pelas cores originais do sprite. Isso significa que isso mantém as cores originais.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/735fe0aa-6cab-47f3-bdd4-8adf768a770f" />
</p>

Por outro lado, o comando `COLOR.b = 1.0;` no shader é diferente. Ele define que todo pixel será da forma `(r, g, 1.0)`, ou seja, define a cor do canal azul diretamente. Portanto, as duas coisas não são equivalentes.

## Usando o uniform

No código abaixo, definimos o `uniform float blue = 1.0;` e o aplicamos no comando `COLOR.b = blue;`. Isso deixará o sprite mais azulado. Lembre-se de que, além do uniform ser uma variável global do shader, ela também é uma variável que pode ser alterada externamente. Você pode notar que é possível alterar esta variável pelo *Inspector* agora.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/217d5588-f59d-4644-8707-d229f3e956b9" />
</p>

## Interagindo com o shader por código

Você pode alterar a variável uniform pelo GDScript através da função `set_shader_parameter`, em que o primeiro argumento é o nome da variável e o segundo é o valor a ser atribuído. Essa funcionalidade foi mencionada [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/Shading%20language#alterando-uniforms-por-c%C3%B3digo-gdscript).

<p align="center">
  <img width="430" src="https://github.com/user-attachments/assets/91b40321-85ef-4287-9b1c-1a944f0c5499" />
  <img width="400" src="https://github.com/user-attachments/assets/59db2b50-75b0-47e2-8c53-8fb99bde1524" />
</p>

Alterar a variável por GDScript não tem efeito imediato no editor, mesmo que você usa a anotação `@export`. Para ter efeito, é necessário que use a anotação `@tool` (talvez precise reiniciar o editor) e que a interação seja após o `_ready`. De todo modo, isso é apenas para poder ver as mudanças em tempo real no editor. Mesmo que você só altere algo no `_ready` e não consigo ver no editor, a mudança acontecerá na execução do jogo.

Abaixo temos um exemplo funcional para ver mudanças ocorrendo no editor a partir de atualizações do GDscript.

<p align="center">
  <img width="580" src="https://github.com/user-attachments/assets/8354fcf9-05b8-405b-9ddb-a0de181d9a52" />
</p>

## Alterando algo na função vertex

Para jogos 2D, estaremos trabalhando com a função `fragment()` na grande maioria das vezes, pois é esta a função que altera cores de pixels e produz os efeitos especiais legais. A função `vertex()` apenas altera a posição dos vértices e os deforma. Isso também tem aplicações, só não são muitas.

No exemplo abaixo, mostramos o sprite sem nada na função `vertex()` e depois com o comando `VERTEX.y += VERTEX.x / 2.0;` implementado na função. Este comando apenas desloca as coordenadas $y$ dos vértices. Esse é o tipo de transformação que podemos esperar com essa função. Não é muito útil para efeitos, mas é útil para movimentos e deformações gerais simples.

<p align="center">
  <img width="260" src="https://github.com/user-attachments/assets/52a46d3e-54f5-4409-a847-7633c3decf7c" />
  <img width="200" src="https://github.com/user-attachments/assets/3de3ae1e-6c37-4ec2-91d9-1afed7ca4984" />
  <img width="200" src="https://github.com/user-attachments/assets/87ae52d1-f6eb-41d9-a127-6127e8cd70c8" />
</p>

> 🟦 **REVISÃO POSTERIOR:** A partir deste exemplo não parece que `vertex()` é muito útil. Porém, a utilidade fica evidente quando a geometria do objeto não é esse simples retângulo, mas sim algo mais complexo.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/CanvasItem%20shaders">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20second%202D%20shader">Próximo ➡</a>
</p>
