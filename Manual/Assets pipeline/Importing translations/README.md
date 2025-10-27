# Importing translations

Por enquanto vamos apenas ter uma ideia geral da funcionalidade de múltiplas linguagens no jogo, com o intuito de mostrar as opções de import. Mais para frente teremos tutoriais voltados para ver isso mais a fundo.

Para inserir múltiplas linguagens no seu jogo, o approach mais comum é fazer isso através de um arquivo CSV. Cada índice contém um identificador único da palavra/frase da linha e cada coluna está associada a uma língua. A imagem abaixo mostra um exemplo claro da estrutura.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/ca98a28b-f6d9-44dc-8808-eeb1ec75e27e" />
</p>

Os nomes das colunas não são arbitrários, a engine reonhece a língua através de nomes específicos. Você pode ver quais deve utilizar [neste link](https://docs.godotengine.org/en/stable/tutorials/i18n/locales.html#doc-locales). 

> PS: Todo arquivo CSV será considerado como um arquivo de tradução de linguagem pela engine. 

## Opções de import

Você pode habilitar compressão das traduções importadas e selecionar o delimitador a ser usado ao analisar o arquivo CSV.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/09ddc82f-e5f8-4a43-bfcd-1ded4a52c8e0" />
</p>
