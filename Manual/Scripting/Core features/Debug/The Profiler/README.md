# The Profiler

Como dito [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Debugger%20panel#profiler), o Profiler é usado para monitorar como cada código/objeto executado afeta a performance enquanto o jogo é executado. Veremos agora como utilizar esta ferramenta.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/5af43c6c-a1c1-4298-be86-6414f854cc84" />
</p>

Para começar a monitorar, você pode clicar no botão de *Start* durante a execução do jogo. Daí é só clicar no *Stop* para parar. Caso você clique no gráfico, vai pausar o jogo e o monitoramento. Caso queira que o monitoramento comece junto do jogo, é só habilitar a opção *Autostart*.

## Métricas

As principais métricas são o *Frame Time*, *Physics Frame Time*, *Process Time* e *Physics Time*.

- **Frame Time:** É o tempo que a engine leva para executar toda a lógica de um frame inteiro, da física à renderização.
- **Physics Frame Time:** É o tempo que a engine alocou entre as atualizações de física. Em um cenário ideal, o tempo de frame é o valor que você escolher: $16.66 \text{ms}$ por padrão, o que corresponde a 60 FPS. É um parâmetro de referência que você pode usar para tudo o mais relacionado a ele.
- **Process Time:** É o tempo que a engine levou para atualizar a lógica que não seja de física, como o código que reside em `_process`.
- **Physics Time:** É o tempo que a engine levou para atualizar tarefas de física, como `_physics_process`.

## Funcionalidade Measure e Time

No painel do profiler, há mais duas funcionalidades para te auxiliar: *Measure* e *Time*.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/cd741ef7-a91c-4432-b342-32468b006b33" />
  <img width="150" src="https://github.com/user-attachments/assets/24710271-871a-48f4-9ed6-f858621fccfd" />
  <img width="140" src="https://github.com/user-attachments/assets/638c4ee1-a7ab-42a6-a96b-36330157d63b" />  
</p>

Por padrão, ele começa com a opção *Frame Time*, que lista o tempo necessário para percorrer o frame atual de cada item, em milissegundos. O *Average Time (ms)* é o tempo médio que qualquer função levou para ser chamada mais de uma vez. Se a contagem precisa de milissegundos não for importante e você quiser ver as proporções de tempo em relação ao frame, use as métricas de porcentagem. *Frame (%)* é relativa ao *Frame Time* e *Physics Time (%)* é relativa ao *Physics Time* (ambos definidos acima).

A última opção é o *Time*. A opção *Inclusive* mede o tempo que uma função levou, incluindo quaisquer chamadas de outras funções dentro dela. Com a opção *Self*, a engine mede o tempo gasto na função sem considerar as chamadas de função que ela mesmo fez.

## Medição manual com timer

Você pode refinar a medição contando manualmente os ticks enquanto o código é executado com algumas funções temporárias. As duas funções fazem parte do objeto da classe `Time`. Elas são `get_ticks_msec` e `get_ticks_usec`. A primeira mede em milissegundos (mil por segundo) e a segunda mede em microssegundos (um milhão por segundo). Ambas retornam a quantidade de tempo decorrido desde que o jogo foi iniciado em seu respectivo intervalo de tempo.

Se você envolver um trecho de código com uma contagem de início e fim em microssegundos, a diferença entre as duas representa a quantidade de tempo que levou para executar esse trecho de código.

<p align="center">
	<img width="350" src="https://github.com/user-attachments/assets/ca723f19-40d2-4df7-8da3-72a6c9bd623b" />
</p>

> PS: Esta dica de usar o timer já foi dada no tutorial de [dicas de otimização](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/General%20optimization%20tips#dicas-gerais), mas com menos detalhes que aqui.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Debugger%20panel">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Using%20the%20ObjectDB%20profiler">Próximo ➡</a>
</p>
