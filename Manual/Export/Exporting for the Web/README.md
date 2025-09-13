# Exporting for the Web

Tudo que temos para falar sobre exportar jogos para a web pode ser colocado em uma lista de observações. 

1. Quando for exportar para web, prefira salvar usando o nome *index.html*, pois na maioria das vezes o servidores vão buscar este arquivo para rodar o jogo.
2. Se vocÊ for criar um jogo e quer que ele possa ser jogado na web, ele tem que ser criado no modo *Compatibility*, pois os outros dois modos não funcionam na web.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/5954efc1-a04c-4917-a330-32bdb23acf70" />
</p>

3. Jogos exportados para web também funcionam em celular, mas com performance inferior aos exportados para *Android* ou *iOS* diretamente.
4. Como observado no [tutorial Audio Server](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Extras/Audio%20Server#adicionando-efeitos-de-%C3%A1udio-por-c%C3%B3digo), os efeitos de áudio não funcionam na web se você deixar o *Playback Type* do `AudioStreamPlayer` no default, que é o *Sample*. Então ele deve ser alterado para *Stream*. A principal diferença entre estes dois é que o *Sample* carrega o áudio inteiro na memória antes de tocar, enquanto que o *Stream* carrega o áudio em partes, à medida que toca (streaming do arquivo do disco ou da rede).

> Dica: Para jogos web, use *Sample* para efeitos curtos e *Stream* para música de fundo, para não sobrecarregar o navegador.

5. 
