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
5) Cena principal (Main)
6) Cena do HUD
7) Extras

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

## Main

Inicialmente, a cena principal contém apenas a cena `Funnel`. O chão e as paredes poderiam ser outra cena, mas 
