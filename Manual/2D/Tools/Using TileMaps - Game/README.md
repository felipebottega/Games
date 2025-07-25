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


