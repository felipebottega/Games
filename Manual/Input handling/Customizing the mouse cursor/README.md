# Customizing the mouse cursor

Você pode querer alterar a aparência do cursor do mouse no seu jogo para que ele se adeque ao design geral. Existem duas maneiras de personalizar o cursor do mouse. Veremos as duas a seguir.

## Pelo Project Settings

Para alterar a aparência do cursor do mouse pelo Project Settings, vá em *Project → Project Settings → General → Display → Mouse Cursor*. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/f8c0bff5-cafd-46d8-a3fd-b980e523633f" />
</p>

A opção *Custom Image* é o caminho para o arquivo de imagem do cursor. *Custom Image Hotspot* é o ponto da imagem que servirá para detecção de cliques. *Tooltip Position Offset* é a posição para aparecer as tooltips, em relação ao *Custom Image Hotspot*. 

O máximo tamanho de imagem permitido é de $256 \times 256$. Caso seja na plataforma web, esse tamanho cai para $128 \times 128$. 

## Por código

A limitação do approach pelo Project Settings é que a configuração do cursor é a mesma para o jogo inteiro. Caso você queria mudar a configuração dinamicamente, tem que ser por código. Mostramos abaixo um código simples que alterna entre dois tipos de cursor conforme você clica com o mouse na tela. Usamos a função `load` para carregar um arquivo de imagem e depois `Input.set_custom_mouse_cursor()` para definir o novo cursor. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/c0d3957c-3044-4c08-8248-0c12e3d62876" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Mouse%20and%20input%20coordinates">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Controllers%2C%20gamepads%2C%20and%20joysticks">Próximo ➡</a>
</p>
