# Galton Board 2

Este é o último projeto relativo ao tutorial oficial de jogos em 2D da Godot. O próximo passo será abordar o manual da engine.

## Organização de um projeto

Na maioria dos projetos anteriores os arquivos estavam simplesmente jogados na pasta raíz do projeto. Para coisas pequenas isso não tem problema, mas projetos maiores requerem uma organização melhor.

<p align="center">
  <img src="https://github.com/user-attachments/assets/5e7d2eb0-faf2-4a1a-b0a1-6c7f7a6a62e1" width="300">
</p>

Também faz parte de um processo organizado saber como você vai trabalhar o projeto, em vez de sair fazendo o que dá vontade. Não existe uma regra absoluta para isso e depende também do tamanho do projeto. Para este, em particular, eu já tenho a visão geral do que quero: vou começar construindo os pedaços e depois o node principal. Trabalharemos na seguinte ordem:

1) Configurações gerais
2) Cena do pilar
3) Cena da bola
4) Cena do funil
5) Cena das bordas
6) Cena dos pinos
7) Cena principal (Main)
8) Cena do HUD
9) Extras

## Configurações gerais

Estaremos usando tela com dimensões $660 \times 820$, posição inicial *Absolute* e modo *viewport*. O resto ficará no default. De configuração inicial é só isso. 

## Cena do pilar

O pilar são as barreiras verticais que ficam na base do tabuleiro e fazem a separação da distribuição. Neste caso são mini-pilares. Ele é composto de node principal, que é um `StaticBody2D`, e dois pedaços, um do corpo e outro da cabeça do pilar (cada um tem um sprite e um shape de colisão próprio). 

<p align="center">
  <img src="https://github.com/user-attachments/assets/ebe0d2e7-422f-4df0-ab50-9aa165944ca3" width="650">
</p>

## Cena da bola

A criação da cena da bola é bem similar à do pilar, mas dessa vez o node raíz é um `RigidBody2D` já que as bolas vão cair, se movimentar e bater nos obstáculos. Depois de posicionar o sprite e shape de colisão e ajustar graficamente o tamanho do shape para ficar igual ao da bola, fizemos um ajutes de escala em ambos para $0.3$.

<p align="center">
  <img src="https://github.com/user-attachments/assets/049b88c5-c987-42a3-b430-d91ff44a1413" width="650">
</p>

> PS: Mudar o tamanho de um shape de colisão no gráfico (isto é, usando o mouse e arrastando) não altera o valor numérico do parâmetro de escala. Por isso é interessante ajustar o shape de colisão primeiramente na mão, e só depois mexer numericamente, pois assim o shape e o sprite começam exatamente com o mesmo tamanho e escala igual a $1.0$.

## Cena do funil

### Refletindo horizontalmente

Vou começar logo com uma dica valiosa pois eu apanhei bastante com isso. Se você criou um objeto, fez uma rotação por um ângulo $\alpha$ com ele e quer um duplicata refletida horizontalmente (como se o eixo $y$ fosse o espelho), você deve fazer a duplicata (*ctrl+D*, *ctrl+C*) e aplicar uma rotação de $-\alpha$ nela. No exemplo abaixo, o objeto original (da esquerda) foi rotacionado por $120^\circ$, então a sua duplicata refletida foi refletida por $-120^\circ$.

<p align="center">
  <img src="https://github.com/user-attachments/assets/52901bb9-6de8-4ef9-832e-d4c3dc32e998" width="600">
</p>

Depois de ajustar os shapes de colisão e encaixar os sprites adequadamente, o resultado é o que temos abaixo. Cada `Sprite2D{i}` está associado ao `CollisionShape2D{i}`. Se não vamos usar nomes bonitinhos, pelo menos a nomenclatura deve ser consistente. Note que os objetos acima são sobrepostos pelos que vem abaixo, o cenário sempre é desenhado do topo para baixo. A escolha da ordem dos sprites não acidental, queremos que as rampas estejam mais à frente que a pequena parede reta ao fim das rampas. Nesta cena o node raíz *Funnel* é do tipo `StaticBody2D` já que todos os objetos da cena são estáticos.

<p align="center">
  <img src="https://github.com/user-attachments/assets/a784199c-e47b-4f1c-88de-ff1d6de927fe" width="800">
</p>

## Cena das bordas

Essa é a cena mais fácil, basta colocar shapes de colisão retangulares no chão a nas laterais. Apenas deixamos o chão com alguma textura pois apenas ele será visível ao jogador. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/98f35ca6-174a-4512-8c5a-dde4ab7bc9fa" width="700">
</p>

## Cena dos pinos 

Não há muito o que dizer, é apenas a bola amarela bastante diminuída, como um `StaticBody2D`.

<p align="center">
  <img src="https://github.com/user-attachments/assets/6e82ac41-66ec-43d2-a2bb-6c8ce640272b" width="600">
</p>

## Cena principal (Main)

A cena principal é um node do tipo `Node2D`, pois é basicamente um conteiner de objetos 2D. Inicialmente ela apenas contém a cena `Funnel` e `Border`. Note que não é precio fazer nenhum ajustes pois construímos essas cenas de modo que elas já entram na Main adequadas.

<p align="center">
  <img src="https://github.com/user-attachments/assets/02860918-af2c-43f9-92d5-2e16054f5dc7" width="700">
</p>

### Inserindo objetos de maneira programática

Agora que começa a parte cerebral. Em vez de colocar os pinos e pilares manualmente como fizemos no [Galton Board 1](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Creating%20instances/Galton%20Board%201), eles serão inseridos automaticamente quando a cena iniciar, via script. Dado uma distância *step* entre os pinos (em pixels), o programa vai inserir os pinos de modo a formar um quadriculado na tela (em uma região delimitada) e vai inserir os pilares na base, em função dessa distância também. Tudo isso é possível pela lógica do código abaixo que está na Main.

<p align="center">
  <img src="https://github.com/user-attachments/assets/f696f1f2-6921-425c-9c76-7cef770649ce" width="500">
</p>

Não vou explicar o código nos mínimos detalhes mas vale a pena falar como ele funciona de maneira geral. 

**Pilares:** Aquele loop inicial percorre as posições dos pilares no eixo $x$. Ele começa num valor *initial_step* que é ligeiramente maior que zero apenas para o pilar não ficar muito escondido. Depois disso ele anda em passos de *step* + 10 pixels inserindo os pilares na base da tela. 

**Pinos:** O primeiro nível do loop representa cada fileira (horizontal), enquanto que o segundo loop insere cada um dos pinos daquela fileira. Note que o segundo loop é muito parecido com o lop dos pilares, com a exceção que o passo é de tamanho *step*. Por definição *step* é a distância entre os pinos, emntão tem que ser isso mesmo. Nos pilares nós demos um espaço a mais para acomodar mais bolas. A variável *x_shift* é para fazer o intercalamento da posição dos pinos que tem nas fileiras. A figura abaixo ilustra o que está acontecendo. A fórmula de *y_shift* foi modelada para que o quadriculado seja formado por quadrados de fato, e não losangos. Note que os pinos ficam limitados a $30\%$ e $68\%$ do espaço vertical do tabuleiro. 

<p align="center">
 <img src="https://github.com/user-attachments/assets/9ad5d24e-9303-4a7a-b3e3-96d3d94405d1" width="250">
</p>

> PS: Em vez de criar a cena do pino, minha primeira abordagem foi reutilizar os pilares, diminuindo a escala até eles terem o tamanho de pinos. Isso bugou a física das bolinhas quando elas caíam. Acredito que diminuir a escala não diminui a quantidade de informação que tem no objeto, e acabou sendo muita conta de colisão em um espaço pequeno da tela. Fica a lição.

Agora crie um script na Main e coloque o código a seguir antes da *set_stage*. Isso já basta para mostrar a geração automática do tabuleiro. Você pode testar os valores de *step* para produzir dinamicamente diversas configurações.

<p align="center">
  <img src="https://github.com/user-attachments/assets/f4c87e79-d93e-4a31-aa56-3d856ab3b5d6" width="400">
</p>

A ideia do jogo é que as bolas caiam automaticamente do céu e de maneira randomizada. O método de gerar objetos recém discutido se aplica a esta situação. Vamos alterar o código um pouco para obter esse resultado. Ao carregar a cena, também acrescentamos a variável *ball*, e definimos um contador para dar um efeito de delay entre cada bola que é chamda pelo *_physics_process*. Poderíamos ter usado um timer também se quiséssemos. Se for necessário ajustar a escala da bola, faça isso na cena original dela, que isso será refletido automaticamente quando o programa for gerá-las.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e13666f4-82af-4822-91db-a4ce927bd13d" width="350">
  <img src="https://github.com/user-attachments/assets/1147f601-21b5-4546-9675-e0fb80a0c39c" width="500">
</p>

## Cena do HUD

"HUD" significa "heads-up display", uma exibição informativa que aparece como uma sobreposição na parte superior da visualização do jogo. É comum usar o node `CanvasLayer` para elementos de UI ("user interface"), como botões, menus, barras de vida, painéis, sliders, HUD, entre outros. Vamos adicionar um cena chamada "HUD", do tipo `CanvasLayer`. Assim como no exemplo do tutorial, essa cena terá o propósito duplo de servir como heads-up display e menu inicial. 

Nosso HUD terá 5 elementos. Vamos descrever um por vez abaixo.   um `Button` paras sair do jogo, um `Hslider`para escolher o tamanho do step (distância entre os pinos) e um `Label` para descrever ao usuário o que o slider faz. 

**Message:** É um node do tipo `Label` para mostrar quantas bolas já caíram. Podemos deixar a caixa de texto vazia, pois ela será preenchida dinamicamente por uma função do script associado ao HUD. Inicialmente a cena do HUD estará como mostrado abaixo. Claro que no momento essa função não faz nada, já que o HUD não faz parte da Main ainda. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/74275ffa-fdbd-4379-be68-928e0f8147f4" width="700">
</p>

Para o estilo da fonte, vá em *Inspector → Theme Overrides → Fonts → Load* e selecione a fonte da pasta *fontes*. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/83c611d6-769f-453a-ba9f-51eac7240464" width="200">
</p>

Agora adicione HUD à cena Main e acrescente a linha `$HUD.update_num_balls(1 + int(counter/10))` dentro do if do `_physics_process`. Para mover a caixa da label na Main você deve marcar o HUD como *Editable Child*, recomendo fazer isso. Após seguir estes passos a contagem já deve estar automática.

<p align="center">
  <img src="https://github.com/user-attachments/assets/61def68c-af75-48a2-868a-268ccaf7c995" width="400">
</p>

> PS: Lembre-se que quando você cria uma cena, está criando um template. Toda função de um script de uma cena será usado na Main de uma maneira ou de outra.

**Start:** É um node do tipo `Button` que o usuário aperta para começar o jogo. Em uma única imagem tentamos resumir todo o processo que foi feito na criação deste botão, com exceção do script e sinais. Para alterar a cor, vá em *Theme Overrides → Colors → Font Color*.

<p align="center">
  <img src="https://github.com/user-attachments/assets/0ade2bee-1b69-4fe1-8485-632c0b849f47" width="800">
</p>

Anteriormente o script do HUD só tinha a função `update_num_balls`. Agora vamos criar um sinal para este botão. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/c8b45d32-797c-4eb8-a26a-e7bab4d3cc94" width="200">
  <img src="https://github.com/user-attachments/assets/a6a1f160-d74f-4015-8a9f-75ead37c561a" width="500">
</p>

Como podemos ver, criamos o sinal que é acionado quando o botão de Start é pressionado. Este sinal faz o HUD esconder obotão de Start e emitir um [sinal customizado](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Using%20signals/Signals%203) que chamamos de `start_game`. Note que este sinal customizado envia um float junto, isto também é possível. 

Tudo que fizemos até agora diz respeito apenas à própria cena do HUD, são ações independentes do ambiente externo. Para conectar o sinal `start_game` à Main, precisamos ir na HUD instanciada na Main. Clique na HUD da Main e vá em Node do painel à direita, ali deve estar presente o sinal `start_game`. Clique no sinal e defina a função `new_game` na Main.  

<p align="center">
  <img src="https://github.com/user-attachments/assets/9dfecccc-ebba-4779-99cd-961eddd3278c" width="900">
</p>

> PS: O sinal vem do node HUD e não do botão Start, apesar de ser este o botão que aciona o trigger. Porém, no script você pode notar que o sinal foi criado no cabeçalho, sendo uma variável global do HUD e, a princípio, sem relação direta com o botão de Start. Essa relação ocorre quando a função `_on_start_pressed` é acionada, pois ela emite o sinal `start_game`. Sendo assim, o evento de pressionar o botão não aciona diretamente a função `new_game`, ele aciona um outro sinal que aciona a função `new_game`. É importante ter isso em mente para não ter confusão na hora e, por exemplo, procurar o sinal `start_game` no botão de Start (eu fiz isso).

Altere o script da Main para ocultar todos os elementos e o processamento da física, exceto o botão de Start. Ao apertar o botão, a `new_game` vai trazer tudo de volta e o jogo vai começar.

<p align="center">
  <img src="https://github.com/user-attachments/assets/eb785366-0755-45f0-8e87-28e8316359b2" width="350">
</p>

**Quit:** Quando todas as bolinhas caírem, o jogador pode querer recomeçar. Do jeito que está agora isso não é possível, então vamos resolver esta questão. Adicione um node do tipo `Button` como mais um filho do HUD e renomeie este botão para *Quit*. Em *Inspector → Text*, escreva "Quit". Pode usar a mesma fonte especial que tem na pasta de fontes e faça os ajustes estético que preferir. A posição do botão na cena do HUD não é tão relevante, podemos deixar pra arrumar na cena principal (aliás, essa observação vale para todos os itens do HUD). Deixamos o botão alinhado com a caixa de contagem.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d5053e46-b96b-47b7-81c7-fd8c659c5b1a" width="800">
</p>

Queremos que todo o jogo reinicie quando este botão for pressionado. Além disso, só faz sentido que ele esteja na tela após o Start ter sido pressionado. Para obter o primeiro comportamento, criamos um sinal ao pressionar o botão de Quit. O comando `get_tree().reload_current_scene()` busca o nível mais alto da árvore de execução e recomeça tudo dali. Ou seja, dentro da Main este botão terá o efeito de retroceder toda a Main, nos levando ao início do jogo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/32ecccaa-69e5-4cbd-81ba-4fe312877875" width="200">
  <img src="https://github.com/user-attachments/assets/3a18c2e5-ef9b-40cd-926b-80f511616042" width="300">
  <img src="https://github.com/user-attachments/assets/42cbe785-13d2-42d3-8822-0cee70d4b4b2" width="350">
</p>

**StepSlider:** Existe um node em Godot chamado `HSlider`, que é um slider na horizontal. O usuário pode clicar e arrastar para mudar um parâmetro dentro de um range de valores. Usaremos isso no menu principal para o usuário definir o valor do parâmetro *step*. Adicione ele ao HUD, renomeie para "StepSlider" e defina os valores `Min Value` = 18, `Step` = 1 e `Value` = 40, como mostrado abaixo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/eb632954-f877-46f5-a005-4bf31d5855f3" width="1000">
</p>

Desse jeito ele é apenas um slider bonito na tela. Para ter funcionalidade, precisamos que o seu valor defina o novo *step* de fato. Lembra que na Main o step estava definido no topo como sendo igual a 70? Vamos redefinir este valor com base no atributo `value` do nosso novo slider. Alteramos a função `_on_start_pressed` para enviar a variável `step_value` com algum valor (antes ela foi inicializada mas nunca usada, mas por default vale zero), e esse valor é o `value` do slider. Esse valor entra no `emit` do sinal `start_game` que entra na `new_game` e substitui o antigo valor do `step`. Assim o `set_stage` usará esse valor novo para montar o cenário. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/8f60d2a1-96d2-47d9-9bd6-5a3b4c42482c" width="250">
  <img src="https://github.com/user-attachments/assets/77cc2492-4382-4724-aa31-5991c8d35ac7" width="250">
</p>

**StepSliderInfo:** Nosso último elemento do HUD é um node do tipo `Label` que apenas informa ao usuário o que aquele slider faz. A imagem abaixo deve ser o suficiente para explicar tudo. Não esquecer que ele também deve ser omitido após o jogador pressionar o Start. Coloque isso no `new_game` junta das outras chamadas do mesmo tipo. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/a7fb3c6c-8221-473c-9dbc-52f107a2b640" width="1000">
</p>

> PS: Não precisa se preocupar com o reaparecimento deste botão e de todos os outros que foram omitidos e queremos de volta na tela incial, pois o Quit dá um hard reset no jogo, então tudo é carregado novamente.
