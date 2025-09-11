# Creating movies

A Godot possui a funcionalidade da gravar uma gameplay sua. Para isso, clique no ícone destacado na figura abaixo. Ele fica no canto superior direito do editor.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/b673deaf-d3bc-4c58-a27a-72ad687d0728" />
</p>

Após isso, basta executar o jogo. Quando você fechar, o vídeo será salvo. Para que tudo funcione como esperado, é necessário configurar o caminho para o video. Vá em *Project Settings → Editor → Movie Writer → Movie File* e preencha o caminho (relativo) até o arquivo, incluindo o nome do arquivo, que deve ser da extensão *avi*. 

## Customizações na criação de vídeo

Ainda no *Movie File*, ative as opções avançadas. O parâmetro *MJPEG Quality* controla a qualidade. É recomendado deixar um valor alto, mas cabe a você decidir na hora o quanto aumentar. O *FPS* por default vem como $60$, e eu diria que é melhor deixar assim. Caso vá mudar, tenha em mente que o parâmetro *Mix Rate* deve ser um múltiplo inteiro do *FPS* para o áudio ficar sincronizado. 

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/94e1641e-2fea-4ca9-b4c0-e03e0014c6e7" />
</p>

> PS: Com FPS = 60 em um jogo 2D simples, a jogo rodou mais rápido que o normal com a opção *Movie Maker* ativada, mas na hora de ver o vídeo a velocidade estava normal. Acredito que depende de cada caso. Abaixo a mensagem do output da Godot deixa claro o que aconteceu.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/e240297e-ab0e-4117-88dc-4f09cb97bd4e" />
</p>

