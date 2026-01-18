# Connecting navigation meshes

Dadas duas malhas de navegação (cada malha é um `NavigationPolygon2D`, tema visto [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20navigation%20meshes)), podemos conectá-las de duas maneiras. Vamos ver estas duas maneiras neste tutorial.

## Mescla de duas malhas de navegação

Diferentes malhas de navegação são mescladas automaticamente pelo servidor de navegação quando pelo menos 2 vértices de uma aresta se sobrepõem exatamente. É necessário que sejam malhas distintas e não dois pedaços da mesma malha, pois neste caso não ocorre nenhuma mescla. 

## Conexão de duas malhas de navegação

Duas malhas de navegação são consideradas "conectadas" pelo servidor de navegação quando suas arestas são quase paralelas e estão suficiente próximas entre si. A distância de conexão é definida pela propriedade *edge_connection_margin* para cada mapa de navegação. Esta propriedade é encontrada em *Project → Project Settings → General → Navigation → 2D → Default Edge Connection Margin*. Também é necessário que a propriedade *Use Edge Connections* esteja habilitada no *Inspector*.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/41021faa-bc86-4fb9-87f8-0c6216be8666" />
  <img width="250" src="https://github.com/user-attachments/assets/f352f0a8-d532-492a-83ab-d2ae30603ac3" />
</p>

Caso a opção de debug *Visible Navigation* esteja ativada, a conexão é indicada na execução do jogo, como podemos ver abaixo. Neste caso, a conexão serve como uma "ponte" entre uma região e outra. Note que conexões só conectam regiões praticamente paralelas e próximas, não tem a mesma flexibilidade que os links de navegação. Essa falta de flexibilidade é compensanda pelo fator da conexão acontecer automaticamente, sem precisar de criação de nodes. É um trade-off.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/d2e10e88-b972-4cd1-9998-9b9d51502da9" />
</p>

> PS: Em muitos casos, as arestas da malha de navegação não podem ser conectadas corretamente quando se sobrepõem parcialmente. É melhor evitar qualquer sobreposição de malhas de navegação para ter um comportamento consistente. 
