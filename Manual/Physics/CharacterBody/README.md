# CharacterBody

Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código.

O node `CharacterBody2D` (`CharacterBody3D`) Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código. Um `CharacterBody2D` pode ser afetado pela gravidade e outras forças, mas você precisa calcular o movimento no código. Embora isso signifique que você precisa escrever algum código para criar o comportamento deles, também significa que você tem um controle mais preciso sobre como eles se movem e reagem.

Os dois principais modos de movimentação do `CharacterBody2D` são o `move_and_collide` e o `move_and_slide`. O segundo já foi utilizado diversas vezes em outros tutoriais e, de fato, ele é o mais prático para implementar a dinâmica de personagens nos jogos. O primeiro método, apesar de ser mais genérico, é menos prático e acaba que sua utilidade é mais específica. Por conta disso, a maioria das propriedades e métodos descritas aqui só servem para o `move_and_slide`. Vale a pena lembrar também que estamos descrevendo apenas as principais propriedades e métodos, mas há outras na [documentação oficial](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html#class-characterbody2d). Não falaremos de sinais pois o `CharacterBody2D` não possui sinais próprios, apenas sinais herdados de classes pai.

## Propriedades

- **Motion Mode:** Define o modo de movimentação para o `move_and_slide`. Os modos são *Grounded* e *Floating*. O modo *Grounded* é para jogos do tipo *side-scrolling* (jogos onde você anda para a direita ou esquerda, como jogos de plataforma). Neste modo as noções de chão, parede e teto existem. Você pode usar os métodos `is_on_floor`, `is_on_wall()` e `is_on_ceiling()` para detectar se o corpo está em contato com algum destes. O modo "Floating" é para jogos *top-down* (jogos com visão de cima para baixo, como os RPGs clássicos). Neste modo tudo é "parede" e os métodos mostrados anteriormente não se aplicam. O método que você pode usar para detectar colisão com paredes é o `is_on_wall`.

A partir daqui vale a pena separar as propriedades entre *Grounded* e *Floating*, pois elas possuem poucas coisas em comum.

### Propriedades Grounded

- **Up Direction:** Vetor que define o que é "para cima" para o `move_and_slide` no modo *Grounded*. É a partir deste vetor que os métodos `is_on_floor`, `is_on_wall()` e `is_on_ceiling()` são capazes de reportar onde o corpo se encontra.
- **Slide on Ceiling:** Se estiver habilitada, o corpo desliza pela teto quando o corpo pula e colide no teto. Caso contrário, o corpo para assim que colide com o teto e cai na vertical. Essa propriedade é apenas para o `move_and_slide` no modo *Grounded*. Nos meus testes não fez nenhuma diferença esta propriedade estar habilitada ou não.
- **Floor/Stop on Slope:** Se estiver habilitada, o corpo não desliza quando estiver parado em chãos inclinados na chamada do `move_and_slide`. Vale notar que o deslizamento só ocorre se existir velocidade vertical sobre o corpo, e ainda assim a própria velocidade do deslizamento pode precisar de ajustes no código.
- **Floor/Constant Speed:** Se estiver habilitada, a velocidade do corpo é a mesma subindo e descendo chãos inclinados na chamada do `move_and_slide`.
- **Floor/Snap Length:** Esta propriedade deve ser aplicada em conjunto com as duas acimas (todas relativas ao comportamento do corpo em chão inclinado). Se não houver força na direção para cima (*Up Direction* definida acima), este parâmetro determina o máximo de pixels até onde o corpo não pode sair do chão. Por exemplo, ao descer um chão inclinado, o corpo pode se projetar para frente devido a velocidade $x$, isso faz com que ele dê um pequeno salto para frente em vez de ficar no chão. O *Snap Length* anula este salto e faz com que o corpo fique "grudado" no chão durante a descida. Só é aplicável para o `move_and_slide`.
- **Floor/Block on Wall:** Se estiver habilitada, o corpo só pode caminhar pelo chão. Caso contrário, ele poderá caminhar pelas paredes também. Note que ele não fica grudado na parede, assim que ele para de andar, a gravidade vai puxá-lo de volta para o chão. Só é aplicável para o `move_and_slide`.
- **Floor/Max Angle:** Ângulo máximo para terminar o que é um chão inclinado. Qualquer inclinação maior que essa faz com que a engine trate o objeto como parede. Só é aplicável para o `move_and_slide`.

> PS: É importante estar atento a qndo uma "parede inclinada" não é um chão inclinado, pois o personagem pode pular a partir de chão inclinado, mas não a partir de parede inclinada. Caso o ângulo *Max Angle* não seja muito alto (o default é $45^\circ$), você pode se confundir visualmente e começar a caçar o bug para resolver o problema do seu personagem não estar conseguindo pular no chão inclinado. Mas como não é um chão (é parede), você pode facilmente perder horas tentando debugar isso.

### Propriedades Floating

- **Wall Min Slide Angle:** Ângulo mínimo que o corpo pode deslizar ao encontrar uma parede. O valor default é $15^\circ$.

### Propriedades Grounded e Floating

Vamos ver agora as propriedades em comum à ambos os modos *Grounded* e *Floating*.

- **Moving Platform/On Leave:** Controla como deve ser a dinâmica de velocidade quando o corpo sai de uma plataforma.
- **Moving Platform/Floor Layers:** Camadas de colisão para chão que o corpo irá detectar como plataforma móvel.
- **Moving Platform/Wall Layers:**  Camadas de colisão para parede que o corpo irá detectar como plataforma móvel.
- **Collision/Safe Margin:** Valor, em pixels, para determinar quando houve colisão na chamada do `move_and_slide`. Por exemplo, se este valor for de 2 pixels, o corpo vai considerar que houve collisão quando estiver a 2 pixels de outro corpo com colisão. O default é de $0.08$ pixels.
- **velocity:** É a velocidade vetorial do corpo, em pixels por segundo. Não é necessário usar o *delta* para definir este vetor, pois o `move_and_slide` lida com essa parte.

## Métodos

- **is_on_floor, is_on_wall, is_on_ceiling:** Estes métodos já foram mencionados acima. Eles retornam booleanos indicando se o corpo está no chão, na parede ou no teto, respectivamente.
  
  > PS: Também existem as versões `is_on_floor_only`, `is_on_wall_only`, `is_on_ceiling_only`. Por exemplo, Estes o método `is_on_floor_only` retorna *true* quando a colisão detectada é unicamente no chão e mais em nenhum outro lugar. O método `is_on_floor` pode retornar *true* se houver uma colisão com o chão, não importando se há diversas colisões com vários corpos ou até parede.
  
- **get_floor_normal:** Retorna o vetor normal ao ponto de colisão do corpo quando ele está no chão. Só é aplicável para o `move_and_slide`.
- **get_wall_normal:** Retorna o vetor normal ao ponto de colisão corpo quando ele está na parede. Só é aplicável para o `move_and_slide`.
- **get_position_delta:** Retorna um vetor que representa a variação do movimento desde a última chamada do `move_and_slide`. Este vetor é o delta da posição do corpo. É bastante útil para saber a direção do movimento do corpo naquele instante.
-  **get_slide_collision_count:** Retorna o número de colisões que ocorreram na última chamada do `move_and_slide`.
-  **get_slide_collision(i):** Retorna informações sobre a $i$-ésima colisão na última chamada do `move_and_slide`.
- **move_and_slide:** Método que move o corpo baseado na sua velocidade. Esse método deve rodar dentro de um `_physics_process`, pois usa o *delta* da física para cálculos internos. Se tiver colisão com outro corpo, vai deslizar sobre o corpo, vai alterar a velocidade, e também vai afetar o outro corpo com a colisão, se for um corpo físico. Retorna *true* se houve colisão naquele frame físico, caso contrário retorna *false*.

## move_and_collide

O método `move_and_collide` costuma ser usado no `CharacterBody2D`, mas na verdade ele é um método do `PhysicsBody2D`, que é a classe abstrata pai do `CharacterBody2D`, `RigidBody2D` e `StaticBody2D`. Este método é utilizada para disparar um corpo em uma direção e parar assim que colide com algum outro corpo. Após esta colisão, o método retorna informação sobre a colisão. Diferentemente do `move_and_slide`, este método não possui nenhuma continuação natural após a colisão, é necessário implementar um código para ter uma resposta à colisão.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/8af7852e-6b9c-4e81-9208-1f9c1bd0f03a" />
</p>

Em teoria o `move_and_collide` pode fazer tudo que o `move_and_slide`, mas requer mais código. O `move_and_slide` já vem com muita coisa implementada internamente, com o objetivo de ser mais conveniente para personagens em jogos. Normalmente o `move_and_collide` é utilizado para projéteis, testar colisões, etc.

## Exemplo

Implementei um pequeno "jogo" para exemplificar algumas coisas do `move_and_collide` e do `move_and_slide`. 

Para o `move_and_slide`, temos uma cena que mostra a diferença entre parede e chão inclinado, além de uma solução para deslizamento no chão. 

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/1214b844-fa7a-4762-be3c-abfd1a5cd9e7" />
</p>

Destacamos abaixo apenas o trecho de código que lida com chão inclinado. Lembre que um `CharacterBody` considera que um chão é inclinado enquanto seu ângulo for menor que *floor_max_angle*. Para saber que o personagem está sobre um chão inclinado, devemos ter as duas condicionais `is_on_floor()` e `get_floor_normal() != Vector2(0, -1)` retornando *true*. Após isso, verificamos se `get_position_delta().y < 0`. Caso seja *true*, o personagem está se deslocando para cima sobre o chão inclinado, caso contrário ele estará se deslocando para baixo sobre o chão inclinado. 

<p align="center">
  <img width="420" src="https://github.com/user-attachments/assets/9277f3e8-b93e-4a08-bf02-39f540fd8725" />
</p>

No caso de estar subindo, mantemos a velocidade do input normalmente. Veja abaixo que a propriedade *constant Speed* está desativada. Isso significa que o personagem vai deslizar para baixo aos poucos no chão inclinado, então essa velocidade do input não é total. No entanto, vale notar que a velocidade default do deslizamento é muito fraca, por isso que temos uma outra lógica quando a direção é para baixo. Se o input for de subir (condição `direction and direction * get_position_delta().x < 0`) enquanto o personagem estiver descendo, simplesmente fazemos o que já era feito antes, usar a velocidade e o input. Se o input for para descer, o jogo aplica uma velocidade para baixo que depende da inclinação, mas ignora totalmente o input (só a gravidade age sobre o personagem).

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/1a1dccbf-69c6-42e2-85b8-1ebeef45e934" />
</p>

Para o `move_and_collide`, temos uma cena que demonstra algumas funcionalidades básicas deste método.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/a93824df-dc9d-4ad7-8144-49554d666b68" />
</p>

No caso do `move_and_collide`, é necessário aplicar o *delta* nas iterações físicas, como podemos ver no código abaixo. O método `move_and_collide` sempre recebe um vetor como argumento. Este vetor determina a direção e rapidez do movimento.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/495ee774-3fbd-456f-976b-ce22674d185e" />
</p>

Quando houver colisão, a condicional `if collision` será satisfeita, então uma nova direção é calculada, sendo exatamente a direção da reflexão da colisão. É o método `bounce` que calcula esta nova direção, mas ela só será usada no próximo frame. Pode acontecer (quase sempre) que, dada a velocidade do projétil, ele ainda tenha "pixels sobrando" naquele frame, antes da colisão. Se você não mandar ele se mover novamente, ele ficará "grudado" no ponto de colisão até o próximo frame. Isso é perceptível. Por isso que é necessário aplicar o método `move_and_collide` mais uma vez no mesmo frame físico.
