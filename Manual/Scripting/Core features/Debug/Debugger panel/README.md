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

