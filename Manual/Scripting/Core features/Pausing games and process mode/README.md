# Pausing games and process mode

Para pausar o jogo, basra executar o comando `get_tree().paused = true`. Fazer isso causará duas coisas. Primeiro, a física 2D e 3D será interrompida para todos os nodes. Segundo, o comportamento de certos nodes será interrompido ou iniciado dependendo do seu *modo de processamento* (*process mode*).

> PS: Os servidores de física ainda podem ser ativados enquanto o jogo está pausado usando seus métodos `set_active`.

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
