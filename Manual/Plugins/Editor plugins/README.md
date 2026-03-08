# Editor plugins

Um "plugin" é basicamente um conjunto de nodes e scripts que servem a um propósito específico na engine. A implementação deles geralmente fica por trás dos panos, geralmente o usuário não manipula diretamente estes nodes e scripts. O [tutorial  oficial de plugins] fala sobre o uso e criação de plugins. No meu caso, só tenho interesso em usar plugins, por isso só vou falar disso. Você pode ver como é a criação de plugins indo no tutorial oficial. 

## Encontrando plugins

Você pode encontrar plugins para a Godot através de repositórios na internet ou no site [Asset Library](https://godotengine.org/asset-library/asset) ou pelo próprio editor da Godot. No último caso, você busca os plugins indo na aba *AssetLib* no editor, como mostrado na figura abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/fbeb5780-18b5-4385-9baf-eefaa4d4f001" />
</p>

Normalmente eu prefiro baixar diretamente do repositório, para ter certeza de que estou com a versão mais atual do plugin. No tutorial de [Rapier Physics](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Extras/Godot%20Rapier%20Physics) este foi o approach utilizado para baixar o plugin deles.

## Instalando plugins

Primeiramente você deve baixar o zip do plugin, seja por repositório ou asset library. Feito isso, extraia o conteúdo do zip na pasta *addons* dentro da pasta do seu projeto (esta pasta deve ser criada). Muitas vezes o zip já vem com essa pasta, então é só copiar a pasta para o seu projeto. É possível utilizar múltiplos plugins, basta colocar todos eles nesta pasta.

## Habilitando o plugin

Normalmente basta ir em *Project → Project Settings → Plugins* e habilitar o plugin por ali. Porém, alguns plugins podem exigir outros alterações no *Project Settings*. Esse foi o caso do [Rapier Physics](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Extras/Godot%20Rapier%20Physics), onde foi necessário habilitar o *Rapier 2D* nas configurações.

> PS: Pode ser necessário reiniciar a engine após habilitar o plugin, depende de cada caso.

