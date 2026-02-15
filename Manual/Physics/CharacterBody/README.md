# CharacterBody

Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código.

O node `CharacterBody2D` (`CharacterBody3D`) Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código. Um `CharacterBody2D` pode ser afetado pela gravidade e outras forças, mas você precisa calcular o movimento no código. Embora isso signifique que você precisa escrever algum código para criar o comportamento deles, também significa que você tem um controle mais preciso sobre como eles se movem e reagem.

Os dois prinicpais métodos do `CharacterBody2D` são o `move_and_collide` e o `move_and_slide`. O segundo já foi utilizado diversas vezes em outros tutoriais e, de fato, ele é o mais prático para implementar a dinâmica de personagens nos jogos. O primeira método, apesar de ser mais genérico, é menos prático e acaba que sua utilidade é mais específica. Por conta disso, a maioria das propriedades e métodos descritas aqui só servem para o `move_and_slide`. Vale a pena lembrar também que estamos descrevendo apenas as principais propriedades e métodos, mas há outras na [documentação oficial](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html#class-characterbody2d).

## Propriedades

- **Motion Mode:** Define o modo de movimentação para o `move_and_slide`. Os modos são *Grounded* e *Floating*. O modo *Grounded* é para jogos do tipo *side-scrolling* (jogos onde você anda para a direita ou esquerda, como jogos de plataforma). Neste modo as noções de chão, parede e teto existem. Você pode usar os métodos `is_on_floor`, `is_on_wall()` e `is_on_ceiling()` para detectar se o corpo está em contato com algum destes. O modo "Floating" é para jogos *top-down* (jogos com visão de cima para baixo, como os RPGs clássicos). Neste modo tudo é "parede" e os métodos mostrados anteriormente não se aplicam. O método que você pode usar para detectar colisão com paredes é o `is_on_wall`.

A partir daqui vale a pena separar as propriedades entre *Grounded* e *Floating*, pois elas possuem poucas coisas em comum.

## Propriedades Grounded

- **Up Direction:** Vetor que define o que é "para cima" para o `move_and_slide` no modo *Grounded*. É a partir deste vetor que os métodos `is_on_floor`, `is_on_wall()` e `is_on_ceiling()` são capazes de reportar onde o corpo se encontra.
- **Slide on Ceiling:** Se estiver habilitada, o corpo desliza pela teto quando o corpo pula e colide no teto. Caso contrário, o corpo para assim que colide com o teto e cai na vertical. Essa propriedade é apenas para o `move_and_slide` no modo *Grounded*. Nos meus testes não fez nenhuma diferença esta propriedade estar habilitada ou não.
- **Floor/Stop on Slope:** Se estiver habilitada, o corpo não desliza quando estiver parado em chãos inclinados na chamada do `move_and_slide`. Vale notar que o deslizamento só ocorre se existir velocidade vertical sobre o corpo, e ainda assim a própria velocidade do deslizamento pode precisar de ajustes no código.
- **Floor/Constant Speed:** Se estiver habilitada, a velocidade do corpo é a mesma subindo e descendo chãos inclinados na chamada do `move_and_slide`.
- **Floor/Snap Length:** Esta propriedade deve ser aplicada em conjunto com as duas acimas (todas relativas ao comportamento do corpo em chão inclinado). Se não houver força na direção para cima (*Up Direction* definida acima), este parâmetro determinar o máximo de pixels até onde o corpo não pode sair do chão. Por exemplo, ao descer um chão inclinado, o corpo pode se projetar para frente devido a velocidade $x$, isso faz com que ele dê um pequeno salto para frente em vez de ficar no chão. O *Snap Length* anula este salto e faz com que o corpo fique "grudado" no chão durante a descida. Só é aplicável para o `move_and_slide`.
- **Floor/Block on Wall:** Se estiver habilitada, o corpo só pode caminhar pelo chão. Caso contrário, ele poderá caminhar pelas paredes também. Note que ele não fica grudado na parede, assim que ele para de andar, a gravidade vai puxá-lo de volta para o chão. Só é aplicável para o `move_and_slide`.
- **Floor/Max Angle:** Ângulo máximo para terminar o que é um chão inclinado. Qualquer inclinação maior que essa faz com que a engine trate o objeto como parede. Só é aplicável para o `move_and_slide`.

> PS: É importante estar atento a qndo uma "parede inclinada" não é um chão inclinado, pois o personagem pode pular a partir de chão inclinado, mas não a partir de parede inclinada. Caso o ângulo *Max Angle* não seja muito alto (o default é $45^\circ$), você pode se confundir visualmente e começar a caçar o bug para resolver o problema do seu personagem não estar conseguindo pular no chão inclinado. Mas como não é um chão (é parede), você pode facilmente perder horas tentando debugar isso.

## Propriedades Floating

- **Wall Min Slide Angle:** Ângulo mínimo que o corpo pode deslizar ao encontrar uma parede. O valor default é $15^\circ$.

## Propriedades Grounded e Floating

Vamos ver agora as propriedades em comum à ambos os modos *Grounded* e *Floating*.

- **Moving Platform/On Leave:** Controla como deve ser a dinâmica de velocidade quando o corpo sai de uma plataforma. Veremos mais sobre isso no tutorial de `AnimatableBody2D`.
- **Moving Platform/Floor Layers:** Camadas de colisão para chão que o corpo irá detectar como plataforma móvel.
- **Moving Platform/Wall Layers:**  Camadas de colisão para parede que o corpo irá detectar como plataforma móvel.
- **Collision/Safe Margin:** Valor, em pixels, para determinar quando houve colisão na chamada do `move_and_slide`. Por exemplo, se este valor for de 2 pixels, o corpo vai considerar que houve collisão quando estiver a 2 pixels de outro corpo com colisão. O default é de $0.08$ pixels.
