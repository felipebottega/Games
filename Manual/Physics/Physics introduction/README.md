# Physics introduction

Já fizemos diversas aplicações de física em tutoriais anteriores, mas agora chegou o momento de encarar este tópico de maneira mais organizada. Por enquanto iremos ver tudo no contexto 2D, futuramente abordaremos os tópicos espeíficos de 3D. A primeira coisa a se ter em mente é que os principais nodes de física são: `Area2D`, `StaticBody2D`, `RigidBody2D` e `CharacterBody2D`. É a partir deles que aplicamos a maioria das propriedades físicas da engine.

## Physics material

Tanto o `StaticBody2D` quanto o `RigidBody2D` possuem a capacidade de terem suas propriedades físicas configuradas através do *Physics material*, que fica no *Inspector*. 

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/a53e9a17-fc05-4460-8405-0660768d271f" />
</p>

  - **Friction:** Como o nome indica, esse parâmetro define o nível de fricção de um corpo.
  - **Rough:** Quando há colisão entre dois objetos, a fricção deve ser levada em conta. Por default, o engine sempre escolhe a menor fricção para aplicar entre os objetos. Caso apenas um deles esteja com a *rough* habilitada, a fricção deste objeto será utilizada na colisão. Caso ambas estejam com a *rough* habilitada, a maior fricção entre eles será utilizada.
  - **Bounce:** Nível do quanto um objeto pode quicar ao colidor com outros objetos.
  - **Absorbent:** Por default essa opção vem desabilitada, o que significa que o *bounce* dele é adicionado ao objeto que está colidindo. Quando a opção está desabilitada, ele passa a subtrair, diminuindo a ação de quicar.

Os nodes `Area2D` e `CharacterBody2D` não possuem *Physics material* por serem "menos físicos" que os dois nodes mencionados acima. O `Area2D` serve apenas para detectar colisão, mas não reage fisicamente a essas colisões (você pode interpretá-lo como um sensor simplesmente). O `CharacterBody2D` já responde mais a física, mas não tanto assim, pois ele também deve responder aos inputs do jogador, então ele é mais meio termo.

## Diversas shapes de colisão por objeto

Em alguns projetos anteriores, se tivéssemos que criar diversas paredes em um cenário (por exemplo), criaríamos um `StaticBody2D` por parede, cada um contendo um `CollisionShape2D`. Este approach no estilo "cada objeto é um node" teve como objetivo a didática. Uma outra maneira de abordar este exemplo seria criar um único `StaticBody2D` e colocar todas as shapes de colisão neste único node. Esta solução é mais simples e ideal para objetos que pertencem ao mesmo "pacote". Pode-se fazer isso para o `RigidBody2D` também, mas é necessário ter mais precaução neste caso. No caso de haver diversas shapes de colisão em um único `RigidBody2D`, cada shape é considerada como uma "parte" do corpo. Se um `RigidBody2D` com diversas partes cai no chão, por exemplo, ele pode quicar, e o modo como o corpo reage dependerá do centro de massa em relação a essas shapes.

> PS: Apesar do `CollisionShape2D` ser o modo mais prático de atribuir um shape para um corpo físico, também é possível utilizar o `CollisionPolygon2D`

## Mudança de escala e física

Quando quiser alterar o tamanho ou formato de um shape de colisão, nunca faça isso alterando o *Scale* do *Inspector* (destacado em vermelho na imagem abaixo). Dê preferência aos marcadores em torno do shape no próprio editor (destacado em verde na imagem abaixo). A engine física não lida bem com mudanças de escala, o que pode acarretar em comportamentos inesperados ou erros. Alterar a escala por código também deve ser evitado, pois é equivalente a alterar pelo *Inspector*.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/237a6ef0-61b3-4cda-b3d9-edef8c9e6f01" />
</p>

## Physics process

A engine física da Godot roda a uma taxa constante de 60 iterações por segundo (60 Hz). Isso é diferente de 60 FPS, pois não há nenhum frame a ser renderizado, apenas cálculos de física ocorrendo no servidor/backend. A Godot possui dois tipos de processamento, o de física que já mencionamos, e o processamento "normal" (em inglês é chamado de *idle processing*). Este segundo é o que de fato é executado em cada frame, e não possui taxa constante. Tudo que depende de FPS cai nesse tipo de processamento e pode ter variação de velocidade. Como não se espera que processos físicos variem de velocidade por conta de mais ou menos FPS, ele possuem essa taxa constante.

> PS: Para exemplificar porque a física não pode depender de física, imagine que a gravidade fosse executada no processamento normal e dependesse de FPS. Em um computador fraco, o boneco iria cair em câmera lenta (FPS baixo), enquanto que num computador potente ele poderia cair absurdamente rápido (FPS alto). Como a gravidade atua num processamento de taxa constante, o boneco pode "teleportar" de um ponto a outro se estiver rodando num computador fraco. Esse "teleporte" serve para compensar a lentidão da máquina mas mantendo o boneco caindo de acordo com tempo "real" que deveria cair. Em outras palavras, se é esperado que ele leve $t$ segundos para cair no chão, esse é o tempo que ele vai levar, não importa a máquina nem o FPS.

Use o `_physics_process` para qualquer processo do jogo que você precise que seja executado de maneira mais controlada e sem depender de FPS. Caso contrário, use o `_process`. Essas duas funções nativas da Godot recebem o parâmetro `delta`. Este valor equivale a quanto tempo se passou desde a última iteração. No caso do `_process` este será o tempo que levou entre o último frame e o atual. No caso do `_physics_process`esse valor é constante, sendo igual a $\frac{1}{60} = 0.0166 \ldots$.

## Collision layers e masks

Já vimos o suficiente deste asunto [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Layers%20e%20Masks#defini%C3%A7%C3%A3o-de-layer-e-mask), mas vamos dar uma recapitulada assim mesmo.

Todo objeto que possui colisão, também possui *Collision Layers* e *Collision Masks*, um total de 32 para cada. 

  - **Layer:** Se um objeto tem a layer X marcado, isso significa que ele pertence a uma certa camada X. Outros objetos que buscarem colisão nesta camada vão encontrar este objeto.
  - **Mask:** Se um objeto tem a mask X marcada, isso significa que ele é capaz de detectar objetos na camada X (isto é, objetos que tem a layer X marcada).

Pense nas layers como sendo as camadas em que o objeto está presente e masks como sendo as camadas com as quais camadas ele quer colidir. A colisão é registrada do ponto de vista do corpo ou outro objeto ativo (que está buscando a colisão). É possível adicionar o objeto a múltiplas layers ou masks.

> Corner case: Suponha um RigidBody que não está em nenhuma layer e mask=1, e um StaticBody que está na layer 1 mas nenhuma mask. Neste caso, o RigidBody busca ativamente por corpos na layer 1 e vai encontrar o StaticBody, de modo que haverá colisão se eles se encontrarem. Agora suponha o contrário, o RigidBody na layer 1 sem nenhuma mask, e um StaticBody sem nenhuma layer mas com mask=1. Neste caso não haverá colisão pois o StaticBody não faz nada ativamente. Aliás, adicionar masks em corpos estáticos não tem efeito algum por eles serem passivos.

É possível editar os nomes das layers/masks indo em *Project → Project Settings → General → Layers Names → 2D Physics*. Isso altera os nomes das layers e masks ao mesmo tempo.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/93020d1f-37cd-478f-95e2-724f5a1d2aaf" />
  <img width="350" src="https://github.com/user-attachments/assets/9a926d19-5b01-4701-8d82-111c768a3b10" />
</p>

Neste [tutorial de navegação](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationPathQueryObjects#par%C3%A2metros-para-o-caminho), falamos um pouco sobre a codificação para referenciar as layers e masks (propriedade *navigation_layers*). Isso é útil quando se quer manipular estes valores por código.

## CollisionObject2D

Todos os principais objetos físicos herdam de `CollisionObject2D`, então é relevante saber um pouco dessa classe. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/b15bbd05-84c8-4815-a2be-de161a086111" />
</p>

`CollisionObject2D` é a classe base abstrata para objetos físicos 2D. Uma instância de `CollisionObject2D` pode conter qualquer número de objetos `Shape2D` para colisões. Também colocamos abaixo a estrutura desta última classe para referência.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/c4643a71-4cba-4453-a01b-8e4888113e4f" />
</p>

No próprio *Inspector*, podemos ver que as layers e masks de colisão são atributos do `CollisionObject2D`. Agora vamos ver sobre as outras propriedades que estão ali.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/90ef9f85-d3a4-4c86-9cfc-1abcd0730521" />
</p>

  - **Disable Mode:** Todos os objetos que herdam da classe `Node`, possuem o atributo `process_mode`, que controla se aquele node deve ser pausado ou não (apenas o node, o não o jogo). A propriedade *Disable Mode* determina como a física do node deve reagir no caso de uma pausa. Há três possibilidades:
    - **Remove:** Remove toda a física da cena e para qualquer simulação que estava em andamento.
    - **Make Static:** Faz com que todos os objetos físicos sejam estáticos.
    - **Keep Active:** A física continua rodando normalmente.
  - **Collision/Priority:** A prioridade utilizada ao se resolver penetrações entre objetos durante colisões. Prioridades mais altas impedem mais estas penetrações.
  - **Input/Pickable:** Faz o objeto físico detectar eventos de mouse (cliques, passar o ponteiro pela área de colisão, etc.). Isso apenas ativa a detecção. Se quiser que algo aconteça, é necessário fazer um script para isso. Na figura abaixo temos um exemplo onde a propriedade foi ativada e o node correspondente tem um trecho no script que faz o objeto alterar a cor quando o usuário clica no objeto.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/064b735f-db55-492e-86c4-f8dac5eaaee6" />
</p>
