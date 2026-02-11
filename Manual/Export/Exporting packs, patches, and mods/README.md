# Exporting packs, patches, and mods

Primeiro vamos estabelecer algumas definições.

- **Conteúdo para Download:** Capacidade de adicionar recursos e conteúdo ao jogo.
- **Patches:** Capacidade de corrigir um bug presente em um produto lançado.
- **Mods:** Permitem que outras pessoas criem conteúdo para o jogo.

É possível utilizar os arquivos PCK para lidar com conteúdos extras como assets, cenas, scripts, entro outros. Porém, o caminho mais simples é só criar uma versão nova do jogo e colocar por cima da anterior. Inclusive, isso é o que muitos estúdios fazem. É direto e simples. Portanto, vamos evitar qualquer coisa com PCK no momento. 

## Exportando o executável sem gerar o PCK

Anteriormente, vimos como exportar o executável do jogo. Você deve ter notado que ele sempre gera um arquivo PCK junto. Este arquivo não é necessário e até pode ser deletado que o jogo ainda roda normalmente. O mais recomendado é marcar a opção *Embed PCK* para gerar apenas o executável. Com isso, eliminamos de vez qualquer vestígio de arquivos PCK no projeto.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/ab058298-c82e-4532-896e-c80433b68a8d" />
</p>
