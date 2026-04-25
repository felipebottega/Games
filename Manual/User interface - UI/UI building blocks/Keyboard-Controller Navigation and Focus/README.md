# Keyboard/Controller Navigation and Focus

Neste tutorial, vamos falar da navegação entre nodes control e "foco" ("focus" em inglês). Por default, a Godot já deixa os inputs `ui_down`, `ui_up`, `ui_left`, `ui_right` e `ui_focus_next` funcionais para a navegação dos nodes control, tanto teclado quando joystick. Por isso é recomendado não usar estes inputs para gameplay, para evitar possíveis conflitos. A engine tambérm detecta automaticamente se o jogador pressionou alguma tecla do teclado ou botão do joystick e se adapta na hora.

## Foco

Um node control está "focado" (ou "em foco") quando ele está marcado para ser selecionado. Ele não foi selecionado de fato ainda, mas caso o jogador pressiona o input de confirmação, ele será selecionado. A imagem abaixo deixa isso claro. O botão *BUTTON 1* está em foco, então se o jogador pressionar o input de confirmação agora, é este botão que será selecionado. Por default a engine sempre tem algum destaque visual para indicar qual node control está em foco no momento.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/5f5d20d9-46cb-46cd-85f7-53c8cffb8518" />
</p>

Nenhum node control começa focado automaticamente, mas é interessante que sempre tenha ao inicializar uma cena com nodes control. Isso porque o jogador pode apenas usar teclado ou joystick, e nesses casos ele necessita de algum node focado inicialmente para depois trocar, caso queira. Você pode definir o node a ser focado inicialmente com o comando `{my_node}.grab_focus.call_deferred()`. O uso do `call_deferred()` geralmente se faz necessário quando a chamada é no `_ready`.

## Navegação

A navegação é simplesmente a maneira como o jogador altera o foco entre os nodes control. Normalmente isso é feito com os inputs descritos no início dste tutorial. 

Usando a imagem acima como exemplo, a engine não sabe que o input `ui_right` deveria alterar o foco de *BUTTON 1* para *BUTTON 2*. Para implementar este comportamento, a partir do node do *BUTTON 1*, você deve ir em *Inspector → Control → Focus → Neighbor Right* e selecionar o botão que está à direita. Esse procedimento deve ser feito para todos os nodes control. Feito isso, a navegação entre os botões está finalizada. A engine vai detectar automaticamente se o jogador está usando teclado ou joystick, e vai reagir de acordo. 

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/a7512d1d-6b11-4e23-8d24-d85d6abc4d09" />
</p>

> PS: Se a interação com o jogo for apenas com mouse, nada disso é necessário. Porém, se o jogo for restrito apenas ao mouse, ele pode acabar excluindo muitos outros jogadores que preferem usar teclado ou joystick.

O input `ui_focus_next` está associado com o *Next* na imagem acima. Este input serve para efetuar uma navegação que não seja direcional, mas sim sequencial nos nodes control. No teclado é o botão *Tab* que está associado a este input.

A propriedade de *Mode* define como um node pode ser focado. Segue a baixo a descrição de cada uma das opções.

- **All:** Significa que o node pode ser focado clicando nele com o mouse ou selecionando-o com o teclado ou joystick.
- **Click:** Significa que o node só pode ser focado clicando nele.
- **None:** Significa que o node não pode ser focado de forma alguma. Por exemplo, nodes de label são definidos como *None* por padrão, enquanto botões são definidos como *All*
