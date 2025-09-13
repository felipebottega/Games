# Exporting for the Web

Tudo que temos para falar sobre exportar jogos para a web pode ser colocado em uma lista de observações. 

1. Quando for exportar para web, prefira salvar usando o nome *index.html*, pois na maioria das vezes o servidores vão buscar este arquivo para rodar o jogo.
2. Se você for criar um jogo e quer que ele possa ser jogado na web, ele tem que ser criado no modo *Compatibility*, pois os outros dois modos não funcionam na web.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/5954efc1-a04c-4917-a330-32bdb23acf70" />
</p>

3. Jogos exportados para web também funcionam em celular, mas com performance inferior aos exportados para *Android* ou *iOS* diretamente.
4. Como observado no [tutorial Audio Server](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Extras/Audio%20Server#adicionando-efeitos-de-%C3%A1udio-por-c%C3%B3digo), os efeitos de áudio não funcionam na web se você deixar o *Playback Type* do `AudioStreamPlayer` no default, que é o *Sample*. Então ele deve ser alterado para *Stream*. A principal diferença entre estes dois é que o *Sample* carrega o áudio inteiro na memória antes de tocar, enquanto que o *Stream* carrega o áudio em partes, à medida que toca (streaming do arquivo do disco ou da rede).

> Dica: Em jogos web, use *Sample* para efeitos curtos e *Stream* para música de fundo, para não sobrecarregar o navegador.

5. O jogo será pausado pelo navegador quando a aba não estiver mais ativa no navegador do usuário. Isso significa que funções como `_process` e `_physics_process` não serão mais executadas até que o usuário volte para a aba.
6. Browsers não entram automaticamente em fullscreen. Por conta disso, é melhor não configurar para que o jogo não comece em fullscreen e deixa isso como opção. Se o usuário escolher a opção fullscreen dentro do jogo, aí sim vai funcionar.
7. Browsers só tocam áudios do jogo após o usuário interagir. Por conta disso, deixe um botão para o usuário clicar para começar o jogo. Caso contrário, você corre o risco de ter a sua abertura ou menu rodando toalmente no silêncio.
8. Fique atento aos *addons* que usa, pois nem todos funcionam em jogos web (o perigo é que as mensagens de erro podem não ajudar a detectar que o problema é o addon).
9. Depois de ter exportado seu jogo como HTML5 (com o nome *index.html*), você pode ir na pasta do jogo, abrir o *cmd* e executar o comando `python -m http.server`. Esse comando roda o seu jogo em um servidor local através da porta $8000$. Você pode testá-lo pelo endereço *http://127.0.0.1:8000/*.
