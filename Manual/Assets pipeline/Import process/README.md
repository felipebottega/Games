# Import process

Você pode arrastar arquivos e pastas diretamente para o *FileSystem* do editor, mas é mais recomendado fazer essa movimentação pelo explorer do sistema operacional mesmo. Ao fazer isso, a Godot vai criar os arquivos de import automaticamente e também vai guardar os imports na pasta oculta *res://.godot/imported/*. Quando for trabalhar com versionamento em git, você deve fazer commit dos imports, mas não da pasta *.godot/*.

## Alterando os parâmetros dos imports

Ao selecionar um arquivo no *FileSystem*, ao lado da aba *Scene* no topo, você pode acessar a aba *Import*. Ela te permite configurar diversos parâmetros do arquivo importado e fazer um "reimport". Nos tutoriais seguintes, iremos nos aprofundar um pouco nestes parâmetros para os principais tipos de arquivos. Ressaltamos que arquivos nativos da Godot não possuem parâmetros de import, como *.tscn, .scn, .tres, .res".

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/8dcb4233-de36-4014-b6c3-af0d9c6333a8" />
</p>

> PS: Depois de alterar os parâmetros para o que você quer, é necessa´rio clicar no botão *Reimport*.

Para fazer o reimport de múltiplos arquivos, é selecionar todos eles no *FileSystem*, alterar os parâmetros e fazer o reimport normalmente.

Você também pode alterar o próprio tipo do objeto, o que leva a uma reconfiguração geral de como o objeto é interpretado pela engine. Com isso, novos parâmetros vão aparecer e este objeto terá um tratamento diferente. Geralmente o default é o que iremos usar, mas podem haver casos em que uma mudança mais profunda no objeto se faz necessária.

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/d3b2d901-47da-42b1-a45a-926ae572f680" />
</p>
