# File system

O sistema de arquivos da Godot armazena recursos no disco. Qualquer coisa, desde um script até uma cena ou uma imagem PNG, é um recurso para a engine. Você pode interagir com os arquivos pela aba *FileSystem* do editor. 

É recomendado que você mova e delete arquivos sempre pelo *FileSystem*. Você pode importar recursos externos pelo explorador de arquivos do sistema operacional desde que não sejam recursos nativos da Godot (*.tscn*, *.gd*, etc.). Caso seja um recurso nativo da Godot, é recomendado importar pelo *FileSystem*, através do *Open in File Manager*. Vale a pena conferir [este tutorial](https://github.com/felipebottega/Games/blob/gh-pages/Manual/Export/Exporting%20for%20Windows/README.md#copiando-cenas-entre-projetos-e-problemas-com-uid) para relembrar. Também é recomendado sempre usar letras minúsculas para os arquivos, pois a Godot faz essa diferenciação e o padrão dela é colocar tudo em minúsculo.

## project.godot

O arquivo `project.godot` é o arquivo de descrição do projeto e está sempre localizado na raiz do projeto. Na verdade, sua localização define onde fica a raiz. Este é o primeiro arquivo que a Godot procura ao abrir um projeto. Este arquivo contém a configuração do projeto em texto simples. Mesmo um arquivo `project.godot` vazio pode funcionar como a definição básica de um projeto em branco.

## Delimitador para caminhos

O Godot só aceita `/` como delimitador de caminho. Isso é feito por motivos de portabilidade. Todos os sistemas operacionais suportam isso, inclusive o Windows, então um caminho como `C:\project\project.godot` precisa ser digitado como `C:/project/project.godot`.

## Resource path e user path

Este tópico foi abordado anteriormente no tutorial [File paths in Godot projects](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/File%20paths%20in%20Godot%20projects#res-e-user), mas vamos dar uma revisada. 

O caminho `res://` sempre apontará para a raiz do projeto (onde o arquivo project.godot está localizado, portanto, res://project.godot é sempre válido). O sistema de arquivos é leitura e escrita quando o projeto é executado localmente no editor. Porém, ao exportar o projeto ou ao executá-lo em dispositivos diferentes (como celulares, consoles ou a partir de um DVD), o sistema de arquivos se tornará somente leitura.

A escrita em disco ainda é necessária para tarefas como salvar o estado do jogo ou baixar pacotes. Para isso, a engine garante que exista um caminho especial `user://` que sempre permite escrita. Esse caminho é definido de forma diferente dependendo do sistema operacional em que o projeto está sendo executado. Explicamos em detalhes como são definidos estes caminhos no tutorial mencionado acima.

## 
