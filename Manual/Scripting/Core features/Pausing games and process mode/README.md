# Pausing games and process mode

Para pausar o jogo, basra executar o comando `get_tree().paused = true`. Fazer isso causará duas coisas. Primeiro, a física 2D e 3D será interrompida para todos os nodes. Segundo, o comportamento de certos nodes será interrompido ou iniciado dependendo do seu *modo de processamento* (*process mode*).

## Process Mode

Todo node de Godot possui um *modo de processamento*, fica em *Inspector → Node → Process → Mode*.  

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/fa9f6453-eab7-4df8-8904-8aca9b04343f" />
</p>

- **Inherit:** Processa dependendo do estado do pai, pai do pai, etc. Vai copiar o modo de processamento do primeiro pai que tiver um modo diferente de *Inherit*.
- **Pausable:** Processa o node somente quando o jogo não estiver pausado.
- **WhenPaused:** Processa o node somente quando o jogo estiver pausado.
- **Always:** Processa o node independentemente de qualquer coisa. Pausado ou não, este node será processado.
- **Disabled:** O node não será processado de forma alguma.

Por padrão, todos os nodes começam no modo *Inherit*. Se o node pai estiver definido como *Inherit*, o node avô será verificado e assim por diante. Se nenhum modo diferente de *Inherit* for encontrado em nenhum dos nodes na hierarquia acima, o estado de pausa na `SceneTree` será usado. Isso significa que, por padrão, quando o jogo é pausado, todos os nós também serão pausados, pois o `SceneTree` é *Pausable*. 

## O que acontece no pause

Várias coisas acontecem quando um node para de processar. As funções `_process`, `_physics_process`, `_input` e `_input_event` não serão mais chamadas. No entanto, os sinais ainda funcionam e fazem com que a função conectada a eles seja executada, mesmo que o script dessa função esteja associado a um node que não esteja sendo processado no momento.

Os nodes de animação pausarão a animação atual, os nodes de áudio pausarão o áudio atual e as partículas também pausarão. Tudo isso será retomado automaticamente quando o jogo sair do pause.

Mesmo que um node esteja processando enquanto o jogo estiver pausado, a física não funcionará para ele. Como mencionado anteriormente, isso ocorre porque os servidores de física estão desativados. No entando, é possível ativar os servidores de física enquanto o jogo estiver pausado usando seus métodos `set_active`.
