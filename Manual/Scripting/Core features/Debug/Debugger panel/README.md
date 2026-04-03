# Debugger panel

Muitas das ferramentas de debug da Godot podem ser encontradas no painel do debug na parte inferior da tela. Clique em *Debugger* para abri-lo.

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/02c3edcb-d9e5-4fc4-9f5c-b09bd39fa511" />
</p>

## Stack Trace

*Stack Trace* é o rastro das chamadas de função que levou o programa até o erro. É parecido com o *Traceback* do Python: ele mostra a sequência de funções para facilitar encontrar onde o problema começou. 

Sempre que você cria um breakpoint e manda executar o jogo, é esta aba que abre no painel. Veja o tutorial [Overview of debugging tools](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Overview%20of%20debugging%20tools#script-editor-debug-tools-and-options) para relembrar.

## Errors

É aqui que as mensagens de erro e aviso/warning são exibidas durante a execução do jogo.

## Evaluator

Esta aba serve de complemento ao *Stack Trace*. A cada etapa do breakpoint, além de analisar o que está acontecendo pelo *Stack Trace*, você também pode interagir com as variáveis na aba *Evaluator*. A figura abaixo mostra um exemplo de script sendo testado nesta aba em um breakpoint. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/508bddb3-9b1e-464f-a7d6-34308bd0089e" />
</p>

## Profiler

O *Profiler* é usado para ver qual código está sendo executado enquanto seu projeto está em uso e como isso afeta a performance. Veremos o *Profiler* em detalhes no próximo tutorial.

## Visual Profiler

O *Visual Profiler* pode ser usado para monitorar o que está consumindo mais tempo durante a renderização de um quadro na CPU e na GPU, respectivamente. Isso permite rastrear as fontes de possíveis gargalos na CPU e na GPU causados ​​pela renderização. No caso da CPU, ele mede apenas o tempo gasto em tarefas de renderização, como chamadas de desenho (por isso o nome "visual" profiler). Ele não inclui o tempo de CPU gasto em outras tarefas, como scripts e física. 

Para usar, basta clicar no *Start* enquanto o jogo estiver em execução. Caso queira que seja iniciado automaticamente junto do jogo, habilite a opção *Autostart*. Após passado algum tempo, você pode dar *Stop* que as informações vão continuar na tela para você analisar. Na tela abaixo, o gráfico é divido em duas partes: a metade da esquerda é o gráfico da CPU e o da direita é o da GPU.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/bf0ce21a-76ed-45df-9e6b-01f0984f20bb" />
</p>

A opção *Fit to Frame* deixa a escala do gráfico fixa, com a linha horizontal em $16.67 \text{ms}$ (tempo de 1 frame em um jogo de 60 FPS) para referência. Caso haja algum spike no gráfico, isso pode atrapalhar a visualização. Desabilite essa opção para que o zoom do gráfico fique dinâmico. Isso evita este tipo de problema. 

> PS: Os resultados do *Visual Profiler* podem variar bastante dependendo da resolução da viewport, que é determinada pelo tamanho da janela se o *Stretch Mode* estiver em *disabled* ou *canvas_items*. Ao comparar resultados entre diferentes execuções, certifique-se de sempre usar o mesmo tamanho de viewport.

## 
