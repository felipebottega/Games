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
6) Cena principal (Main)
7) Cena do HUD
8) Extras

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


## Main

A cena principal é um node do tipo `Node2D`, pois é basicamente um conteiner de objetos 2D. Inicialmente ela apenas contém a cena `Funnel` e `Border`. Note que não é precio fazer nenhum ajustes pois construímos essas cenas de modo que elas já entram na main adequadas.

<p align="center">
  <img src="https://github.com/user-attachments/assets/02860918-af2c-43f9-92d5-2e16054f5dc7" width="700">
</p>

### Inserindo objetos de maneira programática

Agora que começa a parte cerebral. Em vez de colocar os pinos e pilares manualmente como fizemos no [Galton Board 1](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Creating%20instances/Galton%20Board%201), eles serão inseridos automaticamente quando a cena iniciar, via script. Dado uma distância *step* entre os pinos (em pixels), o programa vai inserir os pinos de modo a formar um quadriculado na tela (em uma região delimitada) e vai inserir os pilares na base, em função dessa distância também. Tudo isso é possível pela lógica do código abaixo que está na main.

<p align="center">
  <img src="https://github.com/user-attachments/assets/64138cda-2754-4e09-b5ab-c3efc77e6100" width="500">
</p>

Não vou explicar o código nos mínimos detalhes mas vale a pena falar como ele funciona de maneira geral. 

**Pilares:** Aquele loop inicial percorre as posições dos pilares no eixo $x$. Ele começa num valor *initial_step* que é ligeiramente maior que zero apenas para o pilar não ficar muito escondido. Depois disso ele anda em passos de *step* + 10 pixels inserindo os pilares na base da tela. 

**Pinos:** O primeiro nível do loop representa cada fileira (horizontal), enquanto que o segundo loop insere cada um dos pinos daquela fileira. Note que o segundo loop é muito parecido com o lop dos pilares, com a exceção que o passo é de tamanho *step*. Por definição *step* é a distância entre os pinos, emntão tem que ser isso mesmo. Nos pilares nós demos um espaço a mais para acomodar mais bolas. A variável *x_shift* é para fazer o intercalamento da posição dos pinos que tem nas fileiras. A figura abaixo ilustra o que está acontecendo. A fórmula de *y_shift* foi modelada para que o quadriculado seja formado por quadrados de fato, e não losangos.

<p align="center">
  <img src="https://github.com/user-attachments/assets/b2bf6798-841b-43bb-ae50-ba3fb58c6ea4" width="250">
</p>



