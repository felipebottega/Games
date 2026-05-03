# Import process

Ao acrescentar novos arquivos no projeto, a Godot vai criar os arquivos de import automaticamente e também vai guardar os imports na pasta oculta *res://.godot/imported/*. Quando for trabalhar com versionamento em git, você deve fazer commit dos imports, mas não da pasta *.godot/*. Para copiar cenas de outros projetos, prefira ir no *FileSystem*, clique direito do mouse num espaço vazio, e selecione *Open in File Manager*. Caso contrário, terá problemas com uids erradas. 

## Alterando os parâmetros dos imports

Ao selecionar um arquivo no *FileSystem*, ao lado da aba *Scene*, no topo, você pode acessar a aba *Import*. Ela te permite configurar diversos parâmetros do arquivo importado e fazer um "reimport". Nos tutoriais seguintes, iremos nos aprofundar um pouco nestes parâmetros para os principais tipos de arquivos. Ressaltamos que arquivos nativos da Godot não possuem parâmetros de import, como *.tscn, .scn, .tres, .res*.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/8dcb4233-de36-4014-b6c3-af0d9c6333a8" />
</p>

> PS: Depois de alterar os parâmetros para o que você quer, é necessário clicar no botão *Reimport*.

Para fazer o reimport de múltiplos arquivos, é selecionar todos eles no *FileSystem*, alterar os parâmetros e fazer o reimport normalmente.

Você também pode alterar o próprio tipo do objeto, o que leva a uma reconfiguração geral de como o objeto é interpretado pela engine. Com isso, novos parâmetros vão aparecer e este objeto terá um tratamento diferente. Geralmente o default é o que iremos usar, mas podem haver casos em que uma mudança mais profunda no objeto se faz necessária.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/d3b2d901-47da-42b1-a45a-926ae572f680" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Animation/Creating%20movies">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Assets%20pipeline/Importing%20images">Próximo ➡</a>
</p>
