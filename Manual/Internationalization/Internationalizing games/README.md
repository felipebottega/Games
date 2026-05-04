# Internationalizing games

Vimos um pouco sobre linguagens no tutorial [Importing translations](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Assets%20pipeline/Importing%20translations). Agora chegou a hora de aprofundar neste tópico. Faremos isso através de um exemplo prático que pode ser encontrado [neste link](https://godotengine.org/asset-library/asset/2776).

## Assets 

A ideia deste projeto é fazer uma tela interativa para selecionar linguagens e ouvir áudios da mesma frase em três línguas. Começamos colocando todos os assets na mesma pasta. Teremos as bandeiras dos respectivos países, os arquivos de áudio e o CSV que foi explicado no tutorial mencionado.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/9e060bfe-9e22-4056-923e-0e8aadaa5645" />
  <img width="600" src="https://github.com/user-attachments/assets/0b1f0e97-dc3f-452d-9abc-5d50ce57dd83" />
</p>

Ao importar o arquivo CSV com as traduções, a engine vai criar automaticamente os arquivo de extensão *translation*. Cada um corresponde a uma coluna do CSV, que é uma das linguagens. Se certifique de que isso ocorreu antes de prosseguir.

<p align="center">
  <img width="240" src="https://github.com/user-attachments/assets/1cc49f8c-c2fe-4a8e-964d-6bd5c2a3a182" />
</p>

Depois do import do CSV ter sido efetuado, vá em *Project → Project Settings → Localization → Translations* e importe todos os arquivos de extensão *translation*. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/0d3d306e-d925-450d-ac7b-3af008a2678f" />
</p>

## Nodes da cena

A maioria dos nodes da cena já são conhecidos: `Button`, `Label` e `AudioStreamPlayer`. A única novidade é o uso do `HSeparator`, que é apenas uma linha horizontal na cena, como podemos ver abaixo. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/5d174913-2a02-4fc8-8193-e7d0a3b8f61f" />
</p>

Também adicionamos um ícone no node `Button`. 

<p align="center">
  <img width="280" src="https://github.com/user-attachments/assets/1c3839f1-de13-4e60-a7d3-5f86efcb9bc7" />
  <img width="200" src="https://github.com/user-attachments/assets/ffe3f4fa-d7f2-4f81-8b25-de9e3f97dc6a" />
</p>

## Script inicial

Inicialmente o script é o que está mostrado abaixo. Ele apenas altera o texto do node *TextLabel*, incluindo o valor associado à chave *KEY_TEXT* após o texto. A linguagem default é inglês. Se você checar o CSV, verá que o texto associado à chave *KEY_TEXT* é a string "This is translated!". Então é assim que começa a cena, por default.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/288bfccb-26cf-4596-83f4-a36a9b5093af" />
  <img width="500" src="https://github.com/user-attachments/assets/e642fbb3-06da-468a-8919-1ccd372cdf0b" />
  <img width="750" src="https://github.com/user-attachments/assets/08dd7aca-0bb7-4a3b-8940-e818e2b2eb5f" />
</p>

A função `tr` é a responsável por acessar o CSV e selecionar a tradução de acordo com a linguagem que está sendo utilizada no momento.

## Sinais para alterar a linguagem

Para cada botão, vamos criar um sinal `pressed` para alterar a linguagem. Para a inglês, por exemplo, selecione o node do botão e depois vá para *Node → BaseButton → pressed* e crie o sinal no script do node principal.

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/73fb9829-1a33-4514-b5e9-9dc5c0973a65" />
  <img width="680" src="https://github.com/user-attachments/assets/e37c5e47-48fb-49cf-a0ea-ef22b1d2a89f" />
</p>

Seu script principal deve estar como mostrado abaixo. A função `TranslationServer.set_locale` é nativa de Godot e serve justamente para alterar a linguagem utilizada no jogo. Repit este procedimento para os outros botões, colocando a linguagem correspondente.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/592a5c03-a545-4030-a798-14efd29239ae" />
</p>

Curiosamente, após estas alterações, os textos associados às chaves *KEY_HELLO* e *KEY_PUSH* na imagem abaixo são alterados, mas não a do texto ao lado (*KEY_TEXT*). Isto ocorre porque as duas chaves já estão imbutidas no node, enquanto que a terceira começa vazia e apenas no `_ready` um valor é inserido ali.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/8a875cb6-4284-499d-8870-34a769b33f1c" />
  <img width="700" src="https://github.com/user-attachments/assets/394097a2-169e-4c38-89eb-28d471831fb1" />
</p>

Também adicione um sinal de `pressed` para tocar o áudio.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/462153e6-e592-407c-9bd1-a18e212d0988" />
</p>

## _notification

O problema acima pode ser resolvido com a função nativa `_notification`. Basicamente é uma função que fica escutando notificações emitidas pelo jogo durante a execução. O argumento de entrada desta função é um número inteiro associado ao evento que foi notificado. Uma lista completa das notificações e seus respectivos números pode ser encontrada [aqui](https://docs.godotengine.org/en/stable/classes/class_node.html). No nosso caso, queremos o evento *NOTIFICATION_TRANSLATION_CHANGED*, que é associado ao número 2010. Podemos usar o número ou a própria variável *NOTIFICATION_TRANSLATION_CHANGED* nativa de Godot que representa este número. 

Logo após as funções dos sinais, adicionamos a função abaixo. Ela ficará escutando constantemente as notificações. Quando a notificação desejada ocorrer, ela chama a função para atualizar a mensagem de acordo com a nova linguagem selecionada.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/f8dfdd34-6e3d-46fc-8069-14f6a60591fa" />
</p>

## Assets associados a linguagens

Podemos ver que, para textos, tudo já está que engatilhado na engine. Para assets, como as bandeiras e áudios, o tratamento é diferente. Primeiramente, vá em *Project → Project Settings → Localization → Remaps*. No quadro de cima (*Resources*), coloque os assets da linguagem default. Neste caso é inglês.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/2f473c9f-51b6-4c1b-81c0-981acff4604d" />
</p>

Feito isso, selecione um dos assets e vá para o quadro de baixo (*Remaps by Locale*). Clique em *Add*, selecione o asset da outra linguagem e selecione a linguagem e localização de acordo. Faça isso para todos os itens.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/dca97d95-3363-441a-b1d2-7bc75e67ad34" />
</p>

Segue abaixo como devem estar as configurações para as bandeiras e áudios.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/64d8bd41-f878-4363-be36-c4b4b03d31d9" />
  <img width="900" src="https://github.com/user-attachments/assets/e5367482-dcc6-4168-bc3f-c23ac056c734" />
</p>

Lembre-se que o áudio é um `AudioStreamPlayer` que inicia com o áudio em inglês automaticamente. Esse remapeamento que fizemos altera este recurso assim que a linguagem é alterada através do `TranslationServer.set_locale` ao pressionar um dos botões de trocar de linguagem. De maneira análoga, a figura da bandeira também é remapeada.

> PS: Os caracteres japoneses não renderizam no HTML. Deve ter um modo de resolver isso mas não me preocupei para esse exemplo. Outra questão é o remap dos áudios no HTML. Por alguma razão o HTML fica travado no primeiro áudio que é tocado.

## Outras funcionalidades

  1. O comando `OS.get_locale_language()` sempre retorna a localidade de onde o jogador está. Isto pode ser útil para fazer com que o jogo já inicie com a linguagem local do jogador automaticamente.

  2. No [tutorial de file paths](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/File%20paths%20in%20Godot%20projects) nós vimos como usar strings formatadas através de dicionários. Isso é bastante conveniente para tradutores já que tudo é referenciado por keywords. O código abaixo funciona perfeitamente com o CSV mostrado logo abaixo. A engine primeiro usa a chave `{character} picked up the {weapon}` e a linguagem para buscar a string correspondente. Como essa string ainda é ums string formatada, a engine busca novamente no CSV as traduções para as chaves `{character}` e `{weapon}`.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/4663f113-b3a0-4486-85f4-135bb6afffc3" />
  <img width="900" src="https://github.com/user-attachments/assets/da09c306-e0dd-4729-8a5f-e7f05b3ffc1e" />
</p>

> PS: Ao atualizar o CSV, é necessário apagar os arquivos importados para a engine reimportar e depois repetir os passos da seção "Assets" para incluir os arquivos *translate* no projeto (exclua os antigos).

  3. O *break iterator data* é um conjunto de regras e dicionários linguísticos usados pela ICU (International Components for Unicode) para determinar onde uma palavra ou linha pode ser quebrada corretamente. Isso é importante porque nem todas as línguas usam espaços entre palavras, por exemplo o japonês e o chinês. Para incluí-lo, vá em *Project → Project Settings → General → Internationalization → Locale → Include Text Server Data*. Isso é necessário para exportar o jogo, pois durante a edição ele já fica habilitado.
  
  4. Para testar o jogo em outra linguagem, você pode alterar a linguagem inicial indo em *Project → Project Settings → General → Internationalization → Locale → Test* e colocando a sigla da linguagem desejada. Não se esqueça de deixar este campo em vazio após os testes.

Os temas de contexto, pluralização, texto bidirecional, espelhamento, texto BiDi foram explicitamente evitados pois são muito específicos e de pouca aplicação.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Saving%20games">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Internationalization/Pseudolocalization">Próximo ➡</a>
</p>
