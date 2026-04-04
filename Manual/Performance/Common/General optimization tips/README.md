# General optimization tips

Este será um tutorial breve, apenas com algumas noções breves relacionadas a performance. O nosso maior foco não é na parte teórica, mas sim na prática. 

## A natureza da lentidão

Lentidão no jogo é algo pode ocorrer de diversas maneiras diferentes. Mostramos alguns dos mais conhecidos abaixo.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/1cf5e3f7-53ac-4031-8842-b5bcca855653" />
</p>

## Dicas gerais

1. **Teste hipóteses:** Se, por exemplo, você acha que o problema da lentidão do seu jogo é a quantidade alta de sprites na tela, aumente ou reduza substancialmente essa quantiadde e veja se afeta a lentidão.
2. **Busca binária:** Se você não tem certeza onde está o gargalo do seu jogo, comente metade dos trechos pesados e veja se altera algo. Se não alterar, descomente e comente a outra metade. Uma vez que você encontrar a metade responsável pelo gargalo, repita o processo de testar as metades nesse trecho, e continue cortando pela metade até encontrar o culpado.
3. Caso a busca binária acima não funcione por não ser possível comentar trechos do código, você pode colocar medições de tempo dentro do código para saber quanto tempo leva (coloque prints para mostrar os tempos no console). Você pode usar os comandos `var start = Time.get_ticks_usec()` e `var end = Time.get_ticks_usec()` em torno do trecho de código para este monitoramento. Depois é só fazer `end - start` para saber quanto tempo levou. O retorno destas chamadas é em microssegundos, então deve-se dividir a resposta por um milhão para converter para segundos. Também existe a função `Time.get_ticks_msec()`, que retorna em milissegundos. Neste caso, deve-se dividir a resposta por mil para converter par segundos. 
4. **Otimize o que importa:** Não é porque algo pode ser otimizado que você deve otimizar. O tempo do desenvolvedor é escasso. É uma habilidade importante saber quando vale a pena gastar tempo otimizando algo e quando não vale a pena.
5. **Sempre comece pelo que impacta mais:** Quando for resolver gargalos, sempre busque o que tem mais peso primeiro. Uma vez resolvido, vá para o segundo mais pesado, e assim por diante.
