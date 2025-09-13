# Exporting projects

Vimos algumas coisas sobre exportação de projeto conforme a necessidade surgia, mas agora vamos abordr este tema de maneira sistemática e mais completa.

## Básico de exportação

Após ter feito o seu jogo em Godot, para exportar você deve ir em *Project → Export*. 

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/cd5497e4-da47-4d61-b847-46545a851d5d" />
</p>

Depois disso, uma janela com as opções de exportação irá abrir. A primeira coisa que você deve fazer é clicar em *Add* para selecionar as plataformas em que o jogo será executado. 

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/5d4ac10b-1d72-4729-9f46-44568ed4fd93" />
</p>

Dependendo da escolha, na hora de exportar a Godot pode reclamar que faltam algumas ferramentas (SDKs) e templates para a exportação funcionar. A própria mensagem de erro serve de guia para o que deve ser instalado. [Neste link](https://godotengine.org/download/windows/) você encontra os templates da Godot que devem ser instalados. Depois de baixar os templates, vá em *Editor → Manage Export Templates* e selecione os templates para instalar. Note que você também baixar a partir daí. Faça o que for mais conveniente para você.

Antes mesmo de tentar exportar o seu jogo, é bom saber que tipo de exportação você quer fazer. Existem três alternativas.

  - **Export All:** Exporta o jogo para todas as plataformas selecionadas de uma vez.
  - **Export Project:** Exporta o jogo para uma platafoprma selecionada.
  - **Export PCK/ZIP:** Exporta os recursos do jogo como um arquivo PCK ou ZIP. Não é jogável.

Cada plataforma possui seus próprios parâmetros a serem customizados antes da exportação. O que vem por default na Godot muito provavelmente já está correto e você só vai querer alterar parâmetros mais superficiais, como ícones, metadados e o destino para onde exportar. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/712b5742-9a5d-4d6f-94ac-32a6e2b2748d" />
  <img width="500" src="https://github.com/user-attachments/assets/74bfa58b-fe65-43d1-9a6f-5cd6809ea524" />
</p>

Eu recomendo usar apenas a opção *Export Project* e exportar para uma plataforma de cada vez. Isto te dá mais controle sobre o que está acontecendo. Caso você queria exportar para todas de uma vez, é necessário que o campo *Export Path* esteja preenchido para todas as plataformas. Em relação a exportar para PCK/ZIP, eu ainda prefiro ter o projeto no GitHub ou simplesmente compactar tudo em um zip (em ambos os casos a pasta `.godot` deve ser omitida). Caso queira fazer esta exportação, prefira o PCK pois é o oficial e não possui report de bugs (o ZIP possui).

> PS: Quando for exportar, não se esqueça de desmarcar a opção *Export With Debug*.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/f45dc6ae-4ffd-40be-89a1-a59fef52d9dd" />
</p>

## Configuration files 

A configuração de exportação é armazenada em dois arquivos, ambos encontrados no diretório do projeto:

  - **export_presets.cfg:** Este arquivo contém a grande maioria da configuração de exportação e pode ser submetido com segurança ao controle de versão. Não há nada aqui que você normalmente precisaria manter em segredo.
  - **.godot/export_credentials.cfg:** Este arquivo contém opções de exportação consideradas confidenciais, como senhas e chaves de criptografia. Geralmente, ele não deve ser submetido ao controle de versão nem compartilhado com terceiros, a menos que você saiba exatamente o que está fazendo.

Como o arquivo de credenciais geralmente é mantido fora dos sistemas de controle de versão, algumas opções de exportação estarão ausentes se você clonar o projeto para uma nova máquina. A maneira mais fácil de lidar com isso é copiar o arquivo manualmente do local antigo para o novo.

Abaixo nós temos o conteúdo que tipicamente aparece no `export_presets.cfg`. Note que o *preset.0* se refere à exportação Web, como mostramos em uma imagem acima. Depois disso, no mesmo arquivo de texto, vem o *preset.1*, referente à exportação Windows, e assim por diante. 

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/8e89c06e-7522-49d9-845d-692e66425177" />
  <img width="400" src="https://github.com/user-attachments/assets/f0545703-5016-4e2c-a393-f20852626d2e" />
</p>

Abaixo temos o conteúdo do `export_credentials.cfg`. Para este projeto nenhum tipo de credencial foi criada, por isso não há nada no arquivo.

<p align="center">
  <img width="170" src="https://github.com/user-attachments/assets/1cccb600-bc2a-4d66-8898-d4a39b21c70d" />
</p>

