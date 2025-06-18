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

