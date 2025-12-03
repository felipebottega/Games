# 2D navigation overview

Este é o nosso primeiro tutorial sobre o tópico de navegação. Para deixar claro, "navegação" se refere a métodos para fazer os NPCs "navegarem" pelo mapa. Iremos começar com um exemplo simples de um NPC que persegue um alvo móvel pelo espaço 2D.

## NavigationRegion2D

Começamos criando uma cena com um `Node2D` como raíz e um `NavigationRegion2D` como filho. A região de navegação é a região onde a engine é permitida a buscar uma rota entre o NPC e o target que ele está perseguindo.  Note que o node vai emitir um alerta, pois ele não possui uma shape ainda e isso é necessário.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/3e72156b-4c0e-41d2-bafd-b59c5de1b29c" />
</p>

Vá em *Inspector → Navigation Polygon → New Navigation Polygon*. Assim que você fizer isso, opções de desenhar polígonos vão aparecer no topo do editor, como mostrado abaixo. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/95f72eb4-bdd9-4c45-85b5-ea76d14ce1a6" />
</p>

A convenção é que você desenhe os pontos no sentido anti-horário, e a região de dentro do polígono será a região de navegação. Caso desenho no sentido horário, a engine os interpreta como "buracos", ou seja, regiões para não haver navegação. Quando terminar de desenhar o polígono, clique em *Bake NavigationPolygon*.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/e9563e63-75a3-457a-a1cc-b97b7c9cd5f6" />
</p>


