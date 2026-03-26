# Fixing jitter, stutter and input lag

Falamos brevemente sobre *jitter* no [tutorial de otimização de CPU](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/CPU/CPU%20optimization), sobre *stutter* no [tutorial de redução de stutter](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/GPU/Reducing%20stutter%20from%20shader%20(pipeline)%20compilations) e input lag no [tutorial de dicas gerais de otimização](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/General%20optimization%20tips). Agora chegou a hora de abordar mais diretamente estes três problemas.

## Diferenciando jitter de stutter

Começamos mostrando a animação normal, sem nenhum problema.

![motion_normal](https://github.com/user-attachments/assets/4212537d-a780-410a-82ca-7e2569c7fc80)

Abaixo temos a mesma animação com jitter. Como dito anteriormente, jitter é quando o movimento do jogo parece tremido, mesmo sem queda de FPS. Normalmente acontece quando a taxa de atualização da física não coincide com a taxa de frames renderizados.

![motion_jitter](https://github.com/user-attachments/assets/ac4aef86-32ed-498d-a981-1942f3b17918)

Abaixo temos a mesma animação com stutter. Essas pequenas travadas na animação são o que chamamos de stutter.

![motion_stutter](https://github.com/user-attachments/assets/294fceaf-dc12-4276-b376-cf3dd87bf384)

## Resolvendo jitter

Às vezes, apenas alguns objetos apresentam jitter (personagens ou o plano de fundo). Isso acontece quando eles são processados ​​em momentos diferentes. Um é processado no frame de física  (`physics_process`)enquanto outro é processado no frame idle (`_process`).

É possível reduzir o jitter ativando a interpolação física no [Project Settings](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20Interpolation). A interpolação física suaviza as atualizações da física interpolando as transformações dos objetos físicos entre os frames de física. Dessa forma, a representação visual dos objetos físicos sempre parecerá suave, independentemente da taxa de quadros e da taxa de atualização da física. A ativação da interpolação física apresenta algumas ressalvas importantes. Por exemplo, deve-se ter cuidado ao teletransportar objetos para que eles não interpolem visivelmente entre a posição antiga e a nova quando não for intencional. 

## Resolvendo stutter

O stutter pode ocorrer por diversos motivos. Um deles é o jogo não conseguir manter a taxa de frames máxima devido a um gargalo na CPU ou na GPU. A solução para esse problema é específica para cada jogo e requer otimização.

Outra causa comum de stutter é o [shader stutter](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/GPU/Reducing%20stutter%20from%20shader%20(pipeline)%20compilations). Isso ocorre quando um shader precisa ser compilado ao gerar um novo material ou efeito de partícula pela primeira vez no jogo. Isso geralmente acontece apenas na primeira execução do jogo ou após uma atualização do driver da placa de vídeo.

Em plataformas que suportam a desativação do V-Sync, o stutter pode ser atenuado desativando o V-Sync no Project Settings. Se o monitor for compatível, considere ativar a taxa de atualização variável (G-Sync/FreeSync) mantendo o V-Sync ativado. Contudo, não ajudará com stutter maiores, como as causados pela compilação de shaders.

> PS: V-Sync (Vertical Synchronization) é uma técnica usada em jogos e gráficos para sincronizar a taxa de quadros (FPS) da GPU com a taxa de atualização do monitor (Hz). Por exemplo, suponha que o monitor atualiza a imagem 60 vezes por segundo (60 Hz). Se a GPU gera frames fora desse ritmo (mais rápido ou mais lento), pode dar problema visual. O V-Sync obriga a GPU a entregar um novo frame exatamente no momento certo, evitando desenhar imagens "no meio" de uma atualização da tela. Isso elimina o "screen tearing" (quando a imagem parece cortada no meio). O lado negativo é que ele aumenta o input lag (o jogo responde um pouco mais lento aos seus comandos) e pode causar stutter se o FPS cair abaixo da taxa do monitor (ex: monitor 60 Hz → jogo cai pra 50 FPS → pode travar em 30 FPS). Alternativas modernas ao V-sync são o G-Sync (NVIDIA) e FreeSync (AMD). Essas tecnologias são melhores porque sincronizam o monitor com a GPU, ao invés do contrário, Isso reduz o screen tearing sem aumentar tanto o lag.

## Input lag

Desativar o V-Sync pode diminuir o input lag. No entanto, isso causará o aparecimento de tearing (discutido acima), especialmente em monitores com baixas taxas de atualização. O recomendado é disponibilizar a opção de ativar/desativar o V-sync para os jogadores.

Aumentar o número de iterações físicas por segundo também pode reduzir o input lag induzido pela física. Para isso, vá em *Project → Project Settings → General → Physics > Common > Physics Ticks Per Second* e ajuste para um valor maior que o padrão 60 (outra maneira é definir pelo comando `Engine.physics_ticks_per_second` em tempo de execução). Valores que são múltiplos da taxa de atualização do monitor (normalmente 60 Hz) funcionam melhor quando a interpolação física está desativada, pois evitam jitter. Isso significa que valores como 120, 180 e 240 são bons pontos de partida. A desvantagem de aumentar o FPS de física é que o uso da CPU aumentará, o que pode levar a gargalos de desempenho em jogos com código de simulação física complexo. Isso pode ser atenuado aumentando o FPS de física apenas em situações específicas ou permitindo que os jogadores ajustem o FPS de física de acordo com seu hardware. 

> PS: Diferentes taxas FPS de física levarão a resultados diferentes na simulação física, mesmo se o *delta* for usado consistentemente na lógica do jogo. Isso pode dar vantagem a certos jogadores sobre outros. Portanto, permitir que o jogador altere as taxas de quadros por segundo da física deve ser evitado em jogos multiplayer competitivos.
