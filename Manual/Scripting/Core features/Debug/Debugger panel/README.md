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

O *Profiler* é usado para monitorar como cada código/objeto executado afeta a performance enquanto o jogo é executado. Já abordamos este tópico no tutorial de [otimização da CPU](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/CPU/CPU%20optimization). O próximo tutorial será inteiramente dedicado a este tema.

## Visual Profiler

O *Visual Profiler* pode ser usado para monitorar o que está consumindo mais tempo durante a renderização de um frame na CPU e na GPU, respectivamente. Isso permite rastrear as fontes de possíveis gargalos na CPU e na GPU causados ​​pela renderização. No caso da CPU, ele mede apenas o tempo gasto em tarefas de renderização, como chamadas de desenho (por isso o nome "visual" profiler). Ele não inclui o tempo de CPU gasto em outras tarefas, como scripts e física. 

Para usar, basta clicar no *Start* enquanto o jogo estiver em execução. Caso queira que seja iniciado automaticamente junto do jogo, habilite a opção *Autostart*. Após passado algum tempo, você pode dar *Stop* que as informações vão continuar na tela para você analisar. Na tela abaixo, o gráfico é divido em duas partes: a metade da esquerda é o gráfico da CPU e o da direita é o da GPU. Quando você clica em um frame específico, duas linhas verticais aparecem. Uma marca o frame no gráfico da CPU e outra marca o mesmo frame no gráfico da GPU.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/bf0ce21a-76ed-45df-9e6b-01f0984f20bb" />
</p>

A opção *Fit to Frame* deixa a escala do gráfico fixa, com a linha horizontal em $16.67 \text{ms}$ (tempo de 1 frame em um jogo de 60 FPS) para referência. Caso haja algum spike no gráfico, isso pode atrapalhar a visualização. Desabilite essa opção para que o zoom do gráfico fique dinâmico. Isso evita este tipo de problema. 

> PS: Os resultados do *Visual Profiler* podem variar bastante dependendo da resolução da viewport, que é determinada pelo tamanho da janela se o *Stretch Mode* estiver em *disabled* ou *canvas_items*. Ao comparar resultados entre diferentes execuções, certifique-se de sempre usar o mesmo tamanho de viewport.

## Monitors

Já falamos sobre esta aba no tópico de [monitoramento da pipeline da GPU](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/GPU/Reducing%20stutter%20from%20shader%20(pipeline)%20compilations#monitoramento-do-pipeline). Nesta aba, temos monitores de gráficos de diversos aspectos do jogo enquanto ele está em execução, como FPS, uso de memória, quantidade de nodes em uma cena e muito mais. Todos os monitores rastreiam as estatísticas automaticamente, então mesmo que um monitor não esteja aberto enquanto o jogo estiver rodando, você pode abri-lo mais tarde e ver como os valores mudaram.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/45990395-51e6-4456-bb8b-8e6603705c74" />
</p>

É possível também criar seus próprios monitores customizados. Veremos mais adiante como fazer isso.

## Video RAM

Esta aba mostra o uso de RAM de vídeo do jogo enquanto ele está em execução. Ela fornece uma lista de todos os recursos que utilizam RAM de vídeo, incluindo o caminho do recurso, o tipo de recurso, o formato e a quantidade de RAM de vídeo que ele está utilizando. Há também um número total de uso de RAM de vídeo no canto superior direito do painel.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/55f292d0-2eb6-48a4-b2b4-a3e5b04af7ba" />
</p>

## Misc

Esta aba contém ferramentas para identificar os nodes de `Control` nos quais você está clicando em tempo de execução.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/df0ed4b5-6d18-46d5-89de-91d25838b315" />
</p>

## Network Profiler

Esta aba contém uma lista de todos os nodes que se comunicam pela API multiplayer e alguns contadores sobre a quantidade de interações de rede de entrada e saída. Ele também apresenta um medidor de largura de banda que exibe o uso total de largura de banda em qualquer momento.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/c7568b5f-d8ef-4e3a-b97e-4f9eb080ab0c" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Output%20panel">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/The%20Profiler">Próximo ➡</a>
</p>
