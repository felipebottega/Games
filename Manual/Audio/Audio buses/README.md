# Audio buses

## Escala de decibel 

A escala de decibéis (dB) é uma escala logarítmica que determina o volume do som. Para cada 6 dB, a amplitude do som dobra ou cai pela metade. Por exemplo, 12 dB representa um fator de 4 vezes 1 dB, 18 dB um fator de 8 vezes, e assim por diante. Como a escala é logarítmica, o zero verdadeiro (sem áudio) não pode ser representado.

0 dB é a amplitude máxima possível em um sistema de áudio digital. Este limite não é o limite humano, mas sim um limite do hardware de som. Áudios com amplitudes muito altas para serem representadas corretamente abaixo de 0 dB criam um tipo de distorção chamado *clipping*. Para evitar este efeito, sua mixagem sonora deve ser organizada de forma que a *master bus* (falaremos mais sobre isso adiante) nunca exceda 0 dB.

Ao trabalhar com decibéis, o som é considerado inaudível entre -60 dB e -80 dB. Isso torna sua faixa de trabalho geralmente entre -60 dB e 0 dB.

## Audio buses

Um *audio bus* (também chamado de *audio channel*/*canal de áudio*) pode ser considerado um local por onde o áudio passa e pode ser modificado antes de ser passado para o próximo canal de áudio. Desta maneira, temos uma sequência de canais de áudio antes de chegar no canal master (*master bus*), cada um acrescentando uma camada de modificações sobre o áudio.

> PS: Iremos utilizar ambos os termos "canal de áudio" e "áudio bus" neste e nos tutoriais seguintes. A ideia é reforçar que estes termos são equivalentes.

## Testando o som do seu audio bus

Crie uma cena com um `AudioStreamPlayer` como node raíz e abra o painel de Audio, mostrado abaixo, na imagem.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/896029c6-65a1-4e53-b8e4-caa5b77d589c" />
</p>

Agora selecione algum audio no *FileSystem* e o arraste para a propriedade *Stream* no *Inspector* do `AudioStreamPlayer`. Lembre que Godot apenas aceita *ogg, wav* e *mp3*. Para adicionar algum efeito, basta clicar em *Add Effect* no painel de audio e selecionar algum. Depois disso, você pode escutar o audio com o efeito no próprio editor, bastante habilitar a propriedade *Playing* no *Inspector*.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/177de6b9-d161-4656-9af1-08b5fdc21e98" />
</p>


