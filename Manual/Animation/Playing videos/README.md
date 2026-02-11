# Playing videos

O node `VideoStreamPlayer` é bem simples de usar, é basicamente criar o node, arrastar o video e mexer em algumas customizações simples. Como veremos adiante, o único problema em relação a vídeos é o formato do vídeo. Veremos isso no final deste tutorial.

## Primeiros passos com o VideoStreamPlayer

Começamos criando uma cena com um `Node2D` como raíz e depois adicionamos o node `VideoStreamPlayer` como filho. Feito isso, arraste o vídeo do *FileSystem* para a aba *Stream* que está no *Inspector* do seu node de vídeo.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/63f6bf83-23f2-4a3f-a98e-17959f738fc4" />
  <img width="300" src="https://github.com/user-attachments/assets/8dad4ccf-d0af-4c1d-9790-0e9f68f87145" />
</p>

Quando adicionar o vídeo, vai aparecer um retângulo laranja na tela do editor. Esse é o espaço exato que o vídeo vai ocupar na tela. Você pode mexer nas dimensões com o mouse como se fosse qualquer outro objeto de Godot. É importante ressaltar que as dimnesões iniciais são iguais as dimensões do vídeo original.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/30bb09cb-b0bb-4ea1-bdd3-37351d1e566f" />
</p>

## Propriedades do VideoStreamPlayer

- **Audio Track:** É o número da track onde está o áudio do vídeo. O default é ser em zero mesmo, mas pode ser que um vídeo tenha múltiplas tracks e você precise alterar.
- **Volume dB:** Volume do vídeo. O default zero seria um volume normal.
- **Autoplay:** Se estiver habilitado, o vídeo começar a tocar automaticamente assim que a cena se inicia.
- **Paused:** Se estiver habilitado, o vídeo é pausado.
- **Expand:** Se estiver habilitado, o vídeo pode se deformado conforme você deforma o retângulo com o shape do vídeo no editor.
- **Loop:** Se estiver habilitado, o vídeo fica repetindo em loop.

As outras propriedades eu não sei o que fazem, mas não são muito importantes neste estágio de aprendizado.

## Encoding dos vídeos

A Godot não trabalha com os clássicos formatos como *mp4, avi, mkv, mpg*, entre outros. Apenas o formato *ogv* (Ogg Theora) é aceito. É interessante que você tenha o [FFmpeg](https://ffmpeg.org/) instalado para poder converter vários formatos de vídeo em *ogv*. No terminal, onde está o arquivo a ser convertido, você tem duas possibilidades:

  1. O comando `ffmpeg -i input.mp4 -q:v 6 -q:a 6 -g:v 64 output.ogv` converte o vídeo mantendo a resolução original. A taxa de bits do vídeo e do áudio será variável para maximizar a qualidade, economizando espaço em partes do vídeo/áudio que não exigem uma taxa de bits alta (como cenas estáticas).
  2. O comando `ffmpeg -i input.mp4 -vf "scale=-1:720" -q:v 6 -q:a 6 -g:v 64 output.ogv` redimensiona um vídeo para 720 pixels de altura (720p), preservando sua proporção de tela atual. Isso ajuda a reduzir significativamente o tamanho do arquivo se a fonte for gravada em uma resolução superior a 720p.

Se quiser ver uma demonstração deste node na prática, fiz um mini-game de exemplo que pode ser acessado [neste link](https://felipebottega.github.io/Games/Manual/Animation/Playing%20videos/html/).
