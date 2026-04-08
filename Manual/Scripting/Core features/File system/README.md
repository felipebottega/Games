# File system

O sistema de arquivos da Godot armazena recursos no disco. Qualquer coisa, desde um script até uma cena ou uma imagem PNG, é um recurso para a engine. Você pode interagir com os arquivos pela aba *FileSystem* do editor. 

> PS: Uma questão relevante que vimos sobre o assunto foi a transferência de recursos entre projetos. Vale a pena conferir [este tutorial](https://github.com/felipebottega/Games/blob/gh-pages/Manual/Export/Exporting%20for%20Windows/README.md#copiando-cenas-entre-projetos-e-problemas-com-uid) para relembrar.

## project.godot

O arquivo `project.godot` é o arquivo de descrição do projeto e está sempre localizado na raiz do projeto. Na verdade, sua localização define onde fica a raiz. Este é o primeiro arquivo que a Godot procura ao abrir um projeto. Este arquivo contém a configuração do projeto em texto simples. Mesmo um arquivo `project.godot` vazio pode funcionar como a definição básica de um projeto em branco.

## Delimitador para caminhos

O Godot só aceita `/` como delimitador de caminho. Isso é feito por motivos de portabilidade. Todos os sistemas operacionais suportam isso, inclusive o Windows, então um caminho como `C:\project\project.godot` precisa ser digitado como `C:/project/project.godot`.

