# Your first 2D shader

Este será um tutorial simples, apenas vamos ver os passos básicos para começar a trabalhar com shaders em 2D.

## Primeiros passos

Vamos trabalhar com um `Sprite2D` filho de um node raíz `Node2D`, mas poderia ser outro node fiho do `CanvasItem` possuindo material. Clique para abrir a aba *Material* no *Inspector* e depois clique no campo onde está o *empty* ao lado. Feito isso, clique em *Shader Material*. Vai aparecer um campo novo contendo uma imagem de uma esfera 3D.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/0fa8c6c8-b23d-4898-a1e1-6ca95328c35e" />
</p>

Repare que no lado esquerdo da imagem da esfera, há 3 ícones. Cada um altera o objeto, podendo ser uma esfera, um cubo, ou um plano. Estes objetos estão aí para dar um preview do efeito dos shaders em objetos simples.  

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

Em Godot, todos os shaders começam com uma linha especificando o tipo de shader que são. Neste caso a linha deve ser `shader_type canvas_item;`. Note que o template inicial do shader já vem com essa linha escrita, assim como as *funções de processamento* já vem declaradas e prontas para serem preenchidas.

A função `fragment()` é executada para cada pixel em um `Sprite2D` e determina qual cor esse pixel deve ter. A função `fragment()` mais básica não faz nada além de atribuir uma única cor a cada pixel. Fazemos isso escrevendo um `vec4` na valor nativo `COLOR`. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/0ac96d2a-10d3-4fee-a7c3-a6cd4cac3604" />
</p>

> PS: O código do shader não atua apenas no objeto de preview no *Inspector*, ele também atua automaticamente na própria cena no editor.

Existem várias entradas para a função `fragment()` que você pode usar para calcular a cor. `UV` é uma delas. As coordenadas `UV` são especificadas no seu `Sprite2D` e indicam ao shader onde ler as texturas. Você só pode ler as coordenadas `UV`, mas pode usá-las em outras funções ou para atribuir valores diretamente à `COLOR`. O valor de `UV` varia entre 0 e 1 da esquerda para a direita e de cima para baixo. A figura abaixo ilustra isso claramente.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/66a0a14b-ff1f-45b1-a99f-cbdd994be4de" />
</p>

Vamos usar o comando `COLOR = vec4(UV, 0.5, 1.0);` de exemplo. Esse comando define a cor de cada pixel com base na sua posição na textura. O valor horizontal `UV.x` controla o vermelho, o vertical `UV.y` controla o verde, o azul fica fixo em 0.5 e o alpha em 1.0, resultando em um gradiente onde a posição vira cor. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/6778c649-5ba3-48b6-9af8-67ea37ef9e06" />
</p>
