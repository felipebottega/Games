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

