# Using TileMaps - Game

Este projeto será o meu primeiro jogo com o objetivo de ser um jogo de fato. O propósito final dele ainda é colocar em prática o que foi aprendido, que no caso são as ferramentas de tiles. Ainda assim, será algo além de um experimento avulso da ferramenta.

## Organização de um projeto

Em um [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Heads%20up%20display/Galton%20Board%202#organiza%C3%A7%C3%A3o-de-um-projeto), vimos superficialmente como organizar um projeto em Godot. Eu olhei essa questão mais a fundo cheguei a uma estrutura de pastas bem organizada e voltada a projetos sérios. 

```text
res://
├── assets/                        # Arquivos brutos de mídia (nunca editados por Godot)
│   ├── graphics/                  # Imagens e sprites (ex: PNG, SVG, sprite sheets)
│   │   ├── characters/            # Personagens (ex: jogador, inimigos)
│   │   ├── environment/           # Cenários, objetos de mapa
│   │   ├── ui/                    # Ícones e imagens para menus e HUD
│   │   └── effects/               # Explosões, partículas, transições visuais
│   ├── audio/                     # Arquivos de áudio organizados por tipo
│   │   ├── music/                 # Músicas de fundo (BGM)
│   │   ├── sfx/                   # Efeitos sonoros (tiros, passos, interações)
│   │   └── voices/                # Vozes dubladas, falas, narrativas
│   ├── fonts/                     # Fontes para a interface (TTF, OTF, bitmap)
│   └── tilemaps/                  # Imagens puras de tilesets (antes de virar TileSet)
│
├── scenes/                     # Todas as cenas organizadas
│   ├── game/                   # Cenas principais de gameplay
│   │   ├── levels/             # Fases do jogo
│   │   ├── objects/            # Objetos interativos do jogo
│   │   └── items/              # Itens como chaves, armas, etc.
│   ├── ui/                     # HUD, menus, diálogos
│   ├── characters/             # Personagens jogáveis e NPCs
│   └── system/                 # Cenas de controle geral (loader, pausas, cenas utilitárias, carregamento)
│
├── scripts/                    # Scripts alinhados com as cenas
│   ├── game/                   # Scripts gerais do gameplay
│   │   ├── levels/             # Scripts para fases e mapas
│   │   ├── objects/            # Lógica de objetos do jogo
│   │   └── items/              # Lógica de itens coletáveis
│   ├── ui/                     # Scripts que controlam interface, menus, HUD e diálogos
│   ├── characters/             # Scripts específicos para personagens e NPCs
│   └── system/                 # Scripts do sistema (loader, pause, save/load)
│
├── autoload/                   # Scripts globais (singletons)
│   ├── GameState.gd            # Estado global do jogo (pontuação, progresso)
│   ├── AudioManager.gd         # Controle centralizado de som e música
│   └── Config.gd               # Configurações persistentes (áudio, idioma, gráficos)
|
├── resources/                  # Arquivos .tres ou .res (ex: materiais, perfis de personagem, configurações de inimigos)
│   ├── materials/              # Materiais padrão e shaders customizados
│   ├── configs/                # Arquivos de configuração, curvas, timers, balanceamento
│   └── profiles/               # Dados estruturados de personagens/inimigos
│
├── addons/                     # Plugins da Godot
├── tests/                      # Cenas e scripts de teste ou debug
└── main.tscn                   # Cena inicial (ex: menu principal)
```

Obviamente eu ainda não devo precisar nem da metade dessa estrutura toda, mas vou deixar aqui registrada para futura referência. Além disso, ela será útil para o jogo que farei agora, pois quero que ele fique organizado (não só ele, mas os próximos que virão depois). 

## Plataforma com tiles

Começaremos com o objeto principal deste tutorial, os tiles! De maneira análoga ao tutorial sobre tiles, iremos utilizar o [Kenney's "Abstract Platformer" pack](https://kenney.nl/assets/abstract-platformer). Devemos criar um node `TileMapLayer` e ir em *Inspector → TileSet → NewTileSet*. Daí clicamos novamente neste ícone para abrir as opções e colocamos o *Tile Size* para $64 \times 64$. Chamaremos esta cena de "Platforms", pois ela é constituída apenas das plataformas de tiles. Como queremos bastante espaço para praticar tiles, teremos uma viewport de tamanho $4000 \times 1600$. Ajuste isso no *Project Settings* e coloque *Size/Mode = Maximized* e *Stretch/Mode = viewport".

Iremos trabalhar principalmente com os 3 tiles destacados abaixo. Adicione uma camada de colisão à eles, conforme ensinado no tutorial de tiles.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/c880212a-0f5f-4951-bbba-fc7d37b20cbe" />
</p>

O chão foi feito com os dois primeiros tiles indicados acima (o da esquerda e o do meio). Colocamos o primeiro tile mais à esquerda individualmente e depois utilizamos a ferramenta de traçar retas para fazer a linha de tiles repetidos até o final da tela. Para a parte inferior (a terra, talvez), usamos a ferramenta de retângulo para fazer um retângulo preenchido. Depois selecionamos os dois tiles selecionados na figura abaixo e colocamos uma probabilidade para a ferramenta. Daí repetimos o desenho retangular para estes desenhos serem alocados aleatoriamente em alguns pontos. Isso deixa a imagem mais dinâmica e agradável aos olhos.

<p align="center">
    <img width="900" src="https://github.com/user-attachments/assets/14bb95b6-0659-4a43-a9b9-1021b32fd203" />
</p>

Depois disso acrescente mais daqueles 3 tiles para criar plataformas flutuantes.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/097f0b63-5e65-4bdf-9de1-2465e869d351" />
</p>

Agora selecione as plantas e a ferramenta de traçar reta, com o modificador de probabilidade. Então trace uma reta logo acima do chão para acrescentar algumas plantas. Depois disso, colocamos algumas plantas grandes manualmente.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/0134dbf4-38ba-47ac-ab66-b7cdbb346bdc" />
</p>

Depois de salvar esta cena, vamos criar uma nova, que vamos chamar de "PlatformsFront". Vá em *FileSystem*, crie uma duplicata da cena anterior e altere o nome.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/320f049c-628f-4224-a400-cdb7a012aff7" />
</p>

Nesta cena, deixe um `Node2D` como node raíz, crie uma duplicate do node `Platforms` mas apague todo o desenho deste novo node. Você vai repetir o procedimento que fizemos para colocar as plantas no chão do cenário.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/13feca19-bc87-4934-8bab-f3082f126bfd" />
</p>

Após ter feito o desenho, faça com que o node *PlatformsFront* fique um pouco mais abaixo que o *Platforms*, como indicado na figura. Feito isso, você pode remover o *Platforms* da cena, colocar o *PlatformsFront* como raíz e remover o `Node2D`. A ideia é que o personagem do jogo ficará entre as duas camadas de plantas, o que dará uma sensação de profundidade sutil. É um detalhe, mas vale a pena.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/4874c6fc-e337-4022-914b-678a54489f65" />
</p>

> PS: A engine vai reclamar que você não deveria mudar a posição do node raiz, e talvez não precise mesmo. Poderíamos deixar na origem e mover só na cena principal, mas preferi fazer agora para já ter esse passo evidenciado no tutorial.

Crie a cena *Level* como um `Node2D` sem nada por enquanto. Aos poucos vamos popular esta cena com os objetos necessários. No momento atual, já é possível colocar as duas cenas de plataforma sobrespostas.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/734b7bba-6ef6-41bc-af75-8e3594ac18b5" />
</p>

## Personagem principal

A cena do personagem será um `CharacterBody2D`. Primeiramente, vamos configurar as animações. As spritesheets da *Vampire Girl* foram obtidas no [Craftpix](https://craftpix.net/freebies/free-vampire-pixel-art-sprite-sheets/?num=1&count=80&sq=vampire%20girl&pos=3). Iremos utilizar as animações *idle, jump, run* e *walk*. Ao fim das configuraçõs, o resultado deve estar como mostrado abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/3462d798-6820-4a8f-84e5-92dd5be7ddda" />
</p>

Adicione uma caixa de colisão para o personagem, se baseando na animação idle para decidir o tamanho do shape. Aumente em 3 vezes a escala do personagem. Adicione os 3 efeitos sonoros na cena (`AudioStreamPlayer`), como mostrado abaixo.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/f40ca28c-9d90-4493-add4-b75b791640a6" />
</p>

Depois disso, adicione o script abaixo ao `CharacterBody2D`. Agora já é possível adicionar o personagem na cena *Level*. Lembre-se de colocá-lo após *Platforms* e antes de *PlatformsFront*. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/6b59b2b1-6265-4841-a9f9-b761f9ffc358" />
</p>

> PS: A partir daqui já entramos em um ponto que podemos começar a testar o jogo na prática, basta executar a cena *Level*. Duas coisas que eu fiz neste estágio: coloquei manualmente lgumas plantas grandes no *PlatformsFront* e ajustei os volumes dos efeitos sonoros.

