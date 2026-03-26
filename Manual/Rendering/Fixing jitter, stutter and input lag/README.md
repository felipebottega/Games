# Fixing jitter, stutter and input lag

Falamos brevemente sobre *jitter* no [tutorial de otimização de CPU](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/CPU/CPU%20optimization), sobre *stutter* no [tutorial de redução de stutter](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/GPU/Reducing%20stutter%20from%20shader%20(pipeline)%20compilations) e input lag no [tutorial de dicas gerais de otimização](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/General%20optimization%20tips). Agora chegou a hora de abordar mais diretamente estes três problemas.

## Diferenciando jitter de stutter

Começamos mostrando a animação normal, sem nenhum problema.

![motion_normal](https://github.com/user-attachments/assets/4212537d-a780-410a-82ca-7e2569c7fc80)

Abaixo temos a mesma animação com jitter. Como dito anteriormente, jitter é quando o movimento do jogo parece tremido, mesmo sem queda de FPS. Normalmente acontece quando a taxa de atualização da física não coincide com a taxa de frames renderizados.

![motion_jitter](https://github.com/user-attachments/assets/ac4aef86-32ed-498d-a981-1942f3b17918)

Abaixo temos a mesma animação com stutter. Essas pequenas travadas na animação são o que chamamos de stutter.

![motion_stutter](https://github.com/user-attachments/assets/294fceaf-dc12-4276-b376-cf3dd87bf384)
