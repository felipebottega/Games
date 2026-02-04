# Godot Rapier Physics

No [tutorial de engines físicas](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20engines) nós vimos como adicionar uma nova engine física ao seu projeto. Vamos fazer o passo a passo na prática aqui. 

Primeiramente, crie o seu projeto e crie uma pasta chamada *addons* dentro da pasta do projeto. O segundo passo é baixar a engine física que você quer utilizar. É possível fazer isso através da aba *AssetLib* que já faz parte da Godot.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/85690ff7-f923-4a35-880a-92a9d53dba3a" />
</p>

Para este exemplo, prefiro baixar diretamente do repositório oficial, pois assim tenho certeza de que estou com a versão mais atual. Acesse os downloads mais recentes em [https://github.com/appsinacup/godot-rapier-physics/releases](https://github.com/appsinacup/godot-rapier-physics/releases). Para este exemplo, vamos escolher o *godot-rapier-2d-single-simd-parallel.zip*. Copie a pasta *godot-rapier2d* e a cole dentro da pasta *addons* do seu projeto.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/38a85a44-656a-4ddf-b46f-3b8959981002" />
</p>

Feito isso, vá para *Project → Project Settings → General → Physics → 2D (3D) → Physics Engine* e a opção *Rapier 2D* deve estar lá para ser selecionada. É necessário reiniciar a engine após selecionar.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/86ce4f66-0291-4764-b9da-116ed8615566" />
</p>
