# Audio streams

"Audio stream", no contexto de Godot, é qualquer objeto que emite som. Existe o node `AudioStream`, que é uma classe abstrata (classe que não é diretamente manipulável em Godot) com vários filhos que lidam com áudios de maneiras distintas. Todos esses filhos são, basicamente, apenas atalhos de certas funcionalidades. Tudo pode ser feito com `AudioStreamPlayer` e um pouco de código. Portanto, neste tutorial nós vamos focar no único node que realmente vale a pena aprender, o `AudioStreamPlayer2D`.

## AudioStreamPlayer2D

É bem parecido com o `AudioStreamPlayer`, o que muda é que o som pode vir de apenas um dos lados, de acordo com a posição na tela. Com isso, obtemos um efeito sonoro espacial. Uma vez que o node `AudioStreamPlayer2D` foi colocado na cena, o que determina se estamos à direita ou à esquerda dele é o centro da tela. Se você fizer um player e quiser que o som mude de acordo com ele, a câmera deve se mover junto para o centro da tela ao se deslocar. Tenha isso em mente.

Para iniciar um node `AudioStreamPlayer2D`, o processo é o mesmo do `AudioStreamPlayer`. Basta criar o node e arrastar um arquivo de áudio do *FileSystem* para a aba *Stream* no *Inspector*; 

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/8473ede0-5d36-4ad3-a323-a2e7fbf52c93" />
</p>

## Propriedades do AudioStreamPlayer2D

- **Volume dB:** É o volume base do som.
- **Pitch Scale:** Distorção de *pitch* aplicada no som. Basicamente muda a tonalidade. Pode-se usar isso para simular o [efeito Doppler](https://en.wikipedia.org/wiki/Doppler_effect).
- **Playing:** Toca o áudio na hora da edição. Bom para fazer testes.
- **Autoplay:** O áudio toca automaticamente assim que o node entra na cena.
- **Max Distance:** A distância máxima (em pixels) que o áudio pode ser ouvido.
- **Attenuation:** Curva de atenuação do volume. Se deixar o default o volume aumenta linearmente conforme nos aproximamos da fonte de som.
- **Max Polyphony:** Número máximo de áudios que o node pode tocar ao mesmo tempo. Caso ultrapasse esse valor, ele começa a cancelar áudios antigos para a entrada dos novos.
- **Panning Strength:** Quanto mais alto, mais a diferença entre som esquerdo e direito é realçado.
- **Bus:** Canal de áudio por onde o som vai sair.
- **Playback Type:** Como já observado [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Extras/Audio%20Server#adicionando-efeitos-de-%C3%A1udio-por-c%C3%B3digo), quando esta propriedade está em *Stream*, é possível ter os efeitos de áudio rodando em HTML5.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Audio/Audio%20effects">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Export/Exporting%20projects">Próximo ➡</a>
</p>
