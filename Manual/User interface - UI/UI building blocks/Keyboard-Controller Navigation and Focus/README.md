# Keyboard/Controller Navigation and Focus

Neste tutorial, vamos falar da navegação entre nodes control e "foco" ("focus" em inglês). Por default, a Godot já deixa os inputs `ui_down`, `ui_up`, `ui_left`, `ui_right` e `ui_focus_next` funcionais para a navegação dos nodes control, tanto teclado quando joystick. Por isso é recomendado não usar estes inputs para gameplay, para evitar possíveis conflitos. A engine tambérm detecta automaticamente se o jogador pressionou alguma tecla do teclado ou botão do joystick e se adapta na hora.

## Foco

Um node control está "focado" (ou "em foco") quando ele está marcado para ser selecionado. Ele não foi selecionado de fato ainda, mas caso o jogador pressiona o input de confirmação, ele será selecionado. A imagem abaixo deixa isso claro. O botão *BUTTON 1* está em foco, então se o jogador pressionar o input de confirmação agora, é este botão que será selecionado. Por default a engine sempre tem algum destaque visual para indicar qual node control está em foco no momento.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/5f5d20d9-46cb-46cd-85f7-53c8cffb8518" />
</p>

Nenhum node control começa focado automaticamente, mas é interessante que sempre tenha ao inicializar uma cena com nodes control. Isso porque o jogador pode apenas usar teclado ou joystick, e nesses casos ele necessita de algum node focado inicialmente para depois trocar, caso queira. Você pode definir o node a ser focado inicialmente com o comando `{my_node}.grab_focus.call_deferred()`. O uso do `call_deferred()` geralmente se faz necessário quando a chamada é no `_ready`.

## Navegação

A navegação é simplesmente a maneira como o jogador 
