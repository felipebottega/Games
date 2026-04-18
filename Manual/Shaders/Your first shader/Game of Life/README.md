# Game of Life

Um clássico alvo para a aplicação de shaders é o [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) de Conway. Para implementar este jogo, devemos trabalhar em coordenadas de grid, algo que [já vimos](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20third%202D%20shader#experimento-2) como fazer. Também será necessário armazenar a textura do frame para poder passar como entrada para o shader do frame seguinte, isso também já vimos como fazer no [tutorial passado](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20third%202D%20shader#leitura-da-texturas-do-frame-anterior-no-shader). Com exceções dessas duas técnicas recém aprendidas, o restante é apenas aplicação do conhecimento básico de shaders.

## Estrutura geral

A árvore de nodes segue a mesma estrutura discutida anteriormente para pasasr texturas entre frames, mas dessa vez foi usado  um `ColorRect` em vez de um `Sprite2D`. Um detalhe para apontar é que o bloco do `CanvasLayer` é irrelevante aqui e no tutorial anterior, isso é apenas um display de certas coisas e não tem nada a ver com o método de passar texturas entr frames.

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/9657573a-1a9f-480f-9822-818cf916eaf1" />
  <img width="580" src="https://github.com/user-attachments/assets/cb9e992b-53ba-4884-a01d-d413e4fce184" />
</p>

Na inicialização do tabuleiro, a função `_ready()` recebe alguns parâmetros da Main, altera o valor de `Engine.max_fps` e também desabilita o [V-Sync](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Rendering/Fixing%20jitter%2C%20stutter%20and%20input%20lag#resolvendo-stutter) com `DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)`. Estes dois últimos servem para poder manipular livremente o FPS máximo do jogo. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/95f36058-c257-4ef4-94f2-1009128c6abd" />
</p>

## Shader

A primeira coisa que acontece na `fragment()` é a declaração de variáveis básicas. Elas precisam ser definidas para que seja possível trabalhar em grid. Depois disso a função verifica se é a primeira iteração ou não, para decidir se deve executar a inicialização ou atualização do tabuleiro. Não discutiremos como a inicialização funciona, mas não tem nada demais ali. A parte interessante é a atualização. 

A primeira coisa que a função faz é extrair os dados da célula central com o comando `float center = texture(input_texture, uv).r`. Basta extrair o valor do canal *red*, pois as células/pixels são apenas preto ou branco. Isso significa que *red* $= 1.0$ equivalente a célula branca e *red* $= 0.0$ equivale a célula preta. Depois disso o mesmo procedimento é aplicado par extrair os dados das células vizinhas. O resto do código é aplicação direta das regras do jogo: conta-se a quantidade de células vivas vizinhas, verifica se a célula central está viva ou não, e atualiza de acordo.

<p align="center">
  <img width="660" src="https://github.com/user-attachments/assets/0791dca4-6664-4641-8b82-856cf7372c9a" />
</p>

## Dimensões

Esta parte requer um pouco de cuidado, porque todas as dimensões destes objetos devem estar de acordo: `SubViewportContainer`, `SubViewport`, `ColorRect` e `Camera2D`. Primeiro, o `SubViewportContainer` e `SubViewport` devem estar com as mesmas dimensões, como mostrado abaixo. Na minha experiência, só precisa alterar o `SubViewport` que o `SubViewportContainer` atualiza junto automaticamente, mas pode ser que o contrário também seja possível. Depois disso o `ColorRect` é atualizado também.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/03a04cb0-9010-4362-90b3-ed30ed0dfa18" />
  <img width="250" src="https://github.com/user-attachments/assets/68a8db4e-773e-4e14-bcb0-48d264bcc2d7" />
  <img width="250" src="https://github.com/user-attachments/assets/18e7e7ab-ac8e-4fc9-9cef-729e4220f7c9" />
</p>

Por default, a câmera estará posicionada com centro na origem, mas com a resolução já correta. Deve-se alterar a posição de modo que as coordenadas sejam metade da dimensão cada uma.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/2db5b612-fa9b-4330-aa5d-b5922746fc21" />
</p>

O projeto está configurado para a resolução máxima e isso não é alterado. O que se altera são as dimensões dos objetos e o zoom da câmera. O jogador tem a possibilidade de alterar as dimensões no menu do jogo, e o código abaixo garante que o tabuleiro gerado e o zoom estarão corretos ao carregar a cena.

<p align="center">
  <img width="840" src="https://github.com/user-attachments/assets/b01a3212-4b33-431e-bf96-514f1121178d" />
  <img width="440" src="https://github.com/user-attachments/assets/86727f99-ae2a-42b4-b181-276870bdccca" />
  <img width="400" src="https://github.com/user-attachments/assets/2fb918e8-1e7e-4618-a8a3-168f91291356" />
</p>

> PS: Note que as dimensões do node `SubViewportContainer` não foram atualizadas no código. Como foi dito acima, as dimensões deste objeto se ajustam automaticamente para ficarem iguas às do `SubViewport`. Portanto basta alterar este último.

## Ping-Pong Rendering

A implementação utilizada neste tutorial não é ótima. A cada frame a CPU precisa salvar a textura para passar para a GPU no frame seguinte. Essa constante passagem de dados entre CPU e GPU é um gargalo enorme. Esta implementação foi utilizada por ser simples e didática, mas vamos apresentar uma abordagem melhor para esse problema.

A técnica "Ping-Pong Rendering" ou "Feedback loop", consiste em usar duas texturas A e B que ficam alternando os papéis: em um frame o shader lê a textura de A e escreve a nova em B, no frame seguinte o shader lê a textura de B e escreve em A, e assim sucessivamente. Ao fazer as coisas desta maneira, evita-se a cópia de dados entre CPU e GPU, mantendo toda a simulação dentro da própria GPU.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/313a666e-7452-4ffd-a7df-ec5abc0b5862" />
</p>

Na prática, isso é feito usando dois `SubViewport` (ou duas texturas). Cada um possui um `ColorRect` com o shader aplicado. A cada frame, você alterna:
  - Um `SubViewport` serve como entrada (`input_texture`).
  - O outro serve como saída (onde o shader escreve).

No frame seguinte, eles trocam de papel. Assim, em vez de salvar a textura com `get_image()` e reenviá-la, você apenas passa diretamente a `ViewportTexture` de um `SubViewport` para o shader do outro. Isso evita o gargalo de transferência de dados e mantém o processamento eficiente, mesmo em resoluções altas. 

Uma boa leitura sobre o assunto é [esse artigo](https://ostefani.dev/tech-notes/ping-pong-technique) aqui. Recomendo também testar a [minha implementação](https://felipebottega.github.io/Games/Manual/Shaders/Your%20first%20shader/Game%20of%20Life/html/) do Game of Life. 
