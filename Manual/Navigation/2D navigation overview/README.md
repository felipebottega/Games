# 2D navigation overview

Este é o nosso primeiro tutorial sobre o tópico de navegação. Para deixar claro, "navegação" se refere a métodos para fazer os NPCs "navegarem" pelo mapa, isto é, se locomoverem pelo mapa. Iremos começar com um exemplo simples de um NPC que persegue um alvo móvel pelo espaço 2D.

## NavigationRegion2D

Começamos criando uma cena com um `Node2D` como raíz e um `NavigationRegion2D` como filho. A região de navegação é a região onde a engine é permitida a buscar uma rota entre o NPC e o target que ele está perseguindo.  Note que o node vai emitir um alerta, pois ele não possui uma shape ainda e isso é necessário.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/3e72156b-4c0e-41d2-bafd-b59c5de1b29c" />
</p>

Vá em *Inspector → Navigation Polygon → New Navigation Polygon*. Assim que você fizer isso, opções de desenhar polígonos vão aparecer no topo do editor, como mostrado abaixo. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/95f72eb4-bdd9-4c45-85b5-ea76d14ce1a6" />
</p>

A convenção é que você desenhe os pontos no sentido anti-horário, e a região de dentro do polígono será a região de navegação. Caso desenho no sentido horário, a engine os interpreta como "buracos", ou seja, regiões para não haver navegação. Quando terminar de desenhar o polígono, clique em *Bake NavigationPolygon* (no momento é opcional, veremos em um tutorial futuro como isso funciona).

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/e9563e63-75a3-457a-a1cc-b97b7c9cd5f6" />
</p>

## NavigationAgent2D

Uma vez que temos a região navegável pelo NPC, precisamos do NPC em si. Ele pode ser simplesmente um `CharacterBody2D`, mas o que o faz navegar pela região é o node `NavigationAgent2D`. Então criamos um `CharacterBody2D`com um node filho `NavigationAgent2D`. Este node apenas precisa ser adicionado ao agente que irá navegar, toda a sua lógica é feito via script.

<p align="center">
  <img width="250" height="179" alt="image" src="https://github.com/user-attachments/assets/417d2916-867a-4892-8f97-b04fecc7ef6e" />
</p>

Antes mesmo de pensar no script, vamos adicionar o target à cena. No fim das contas, o NPC vai perseguir o target, então faz mais sentido que ele seja adicionado primeiro. Para o nosso exemplo, target será apenas um `Sprite2D` se movendo de maneira circular pela tela. Feito isso, adicionamos o script abaixo ao NPC.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/7ea31bc2-169d-4855-a889-82672a8d6dd9" />
</p>

Vamos esclarecer o que fazem os atributos e métodos utilizados do `NavigationAgent2D`.

  - **NavigationAgent2D.path_desired_distance:** A cada frame, o `NavigationAgent2D` calcula uma sequência de pontos dentro da região de navegação. Esta sequência de pontos define um caminho válido entre o NPC e o target. O atributo `NavigationAgent2D.path_desired_distance` é a distância (em pixels) para a engine considerar que o NPC já atingiu o próximo ponto da sequência. Por exemplo, se `NavigationAgent2D.path_desired_distance`  = 10, então a engine considera que o NPC atingiu um ponto da sequência quando ele está a $10$ pixels deste ponto. Daí o NPC passa a se dirigir para o próximo ponto da sequência. Essa folga na exatidão evita situações em que um ou mais NPCs podem travar para chegar num ponto poiss um colidiu com o outro e ambos se bloquearam. Ao colocar essa folga, ele considera que já atingiu o ponto um pouco antes mesmo de tocar nele.
  - **NavigationAgent2D.target_desired_distance:** Semelhante ao anterior, mas é relativo ao target. Inclusive, quando o NPC alcança o target, o atributo `NavigationAgent2D.is_navigation_finished()` (não utilizado neste exemplo) muda de *False* para *True*. Esta mudança de estado algo pode ser o trigger para alguma coisa no jogo.
  - **NavigationAgent2D.target_position:** A posição do target a ser perseguido. É importante ressaltar que esta posição será usada no próximo frame, não no frame corrente. Ao alterar a posição do target, no próximo frame será calculada uma nova rota até este novo ponto.
  - **NavigationAgent2D.get_next_path_position():** Retorna o próximo ponto da rota do NPC. Caso ele ainda esteja a caminho deste ponto, ele se mantém repetido entre os frames, a menos que a rota seja alterada.
  - **NavigationAgent2D.path_max_distance:** Diz o máximo de distância (em pixels) que o agente pode estar afastado caminho. Enquanto o agente se move, às vezes ele se desvia do caminho ideal, para evitar colisões com outros objetos ou agentes. Se o agente acabar mais longe do que esse valor, o sistema entende que o caminho não faz mais sentido e recalcula uma nova rota.

Abaixo temos uma amostra de como está o nosso jogo até o momento. Note que só é possível visualizar a região de navegação indo em *Debug → Visible Navigation*. Normalmente ela fica invisível durante o jogo de verdade.

https://github.com/user-attachments/assets/5b98946a-8c7e-49cf-a937-5c5e842b1294

## Visualizando a rota de navegação

Pelo que foi exposto acima, está claro que a cada frame existe um rota calculada entre o NPC e o target. Porém, esta rota não é visível na engine, é apenas numérico. É possível ativar essa visualização indo em *Inspector → Debug* e ativando a propriedade *Enabled* do `NavigationAgent2D`. Logo abaixo desta propriedade há outras para customizar a aparência do caminho.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/75c9751b-cd7e-4bfb-bdc9-85ca6a10377f" />
</p>

O resultado final está no video abaixo. 

https://github.com/user-attachments/assets/b02d99cf-1ee9-4717-b581-1f5ecd73a648
