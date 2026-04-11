# Using multiple threads

Threads é o que permite você obter paralelismo com o seu script na Godot. A Godot não limita o número de threads ao número de núcleos, mas é recomendado que não se use mais threads que o número de núcleos da sua CPU. Criar threads é um processo lento, por isso é recomendado criar as threads previamente (em um loading de jogo, por exemplo) e requisitá-las posteriormente durante o jogo.

## Método bind

Antes de falar de threads, devemos introduzir o método `bind`, pois ele será necessário. Este é um método aplicado sobre funções. Ele tem o papel de fixar alguns argumentos da função e retornar uma função nova, que é uma cópia da orignal mas com menos argumentos. Por exemplo, considere a função matemática $f(x, y, z) = x + y -z$. Se quisermos travar ela em $z = 1$, na Godot faríamos `f.bind(1)`, o que seria equivalente a definir a função $g(x, y) = f(x, y, 1)$. A nova função `f.bind(1)` recebe $x, y$ como argumentos. Por exemplo, podemos ter `f.bind(1).call(2, 3) = 2 + 3 - 1 = 4`.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7204e92e-72da-4675-8b8f-92e84e7f1d60" />
</p>

É importante notar que os argumentos em `bind` sempre vem após os argumentos que você usará em `f.bind`. Por exemplo, se fosse definida a função `f.bind(1, 2)`, internamente a engine esperaria apenas um argumento para ela, que seria $x$, com $y = 1$ e $z = 2$ fixados. Também é possível criar uma função com o `bind` usando todos os argumentos da função. Deste modo, a função será simplesmente uma constante.

## _exit_tree

A função nativa `_exit_tree()` é chamada automaticamente pela Godot quando um node está prestes a sair da árvore de cena (remoção, troca de cena, fechar o jogo, etc.). Ela é usada para limpeza final (parar threads, liberar recursos, etc.). 

## Criando uma thread

Abaixo segue um exemplo minimal do uso de threads em um script Godot. Um thread é criada, depois é chamada para executar uma função que contém um argumento fixadop com `bind`, e por fim a thread é finalizada após a sua execução.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/2965bc08-9aa7-412d-80f5-dfe9a72cccde" />
</p>

É totalmente possível passar apenas a função para a thread, descartando o uso do `bind`. Neste caso, é necessário que a função não tenha argumentos de entrada. O exemplo com `bind` foi para mostrar como se faz quando você quer passar uma função e um argumento para a thread. 

> PS: A função `_thread_function.bind("123456789")` não faz nenhuma execução da função, ela apenas mantém registrada as instruções para executar a função com certos argumentos já fixados. É o método `call` que de fato executa a função, como vimos acima. No caso das threads, é o comando `thread.start` que irá chamar a `call` para executar a função.

Executar uma única thread tem utilidade. Se o teu jogo tiver algum processamento pesado para fazer, você pode criar uma thread para executar este processamento em paralelo, sem afetar a performance da thread main do jogo.

<p align="center">
  <img width="430" src="https://github.com/user-attachments/assets/f812ef55-4401-4592-9a63-dd9498bc34f6" />
</p>

Na maioria dos casos, os jogo precisam apenas de uma thread extra para tirar coisa pesada da main thread. Alguns exemplos clássicos são: gerar mapa procedural, carregar e processar dados, pathfinding pesado, compressão/parsing. Isso já evita stutter e travadas.

## Criando múltiplas threads

É possível trabalhar com múltiplas threads usando as chamadas vistas até aqui, mas não é indicado (mais frágil e suscetível a erros). O modo indicado na Godot para se trabalhar com múltiplas threads é através do `WorkerThreadPool`. Mostramos um exemplo prático abaixo.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/0101d76a-de7b-4960-8f34-5974e15d3a28" />
</p>

## Mutex

Quando diversas threads estão acessando os mesmos dados, podemos ter comportamentos inesperados e erros. É importante que as threads acessem os mesmo dados de forma sequencial, isto é, uma thread de cada vez. Neste caso há perda de paralelismo, mas acessos simultâneos aos mesmos dados é algo que é bastante problemático. A Godot possui a classe *Mutex* (também chamados de *semáforos binários*) para organizar melhor estes acessos. A ideia é simples: quando uma thread for acessar um dado que outras threads vão acessar, ela "trava" este dado momentaneamente. A thread pode liber o dado assim que terminar de trabalhar com ele. 

O script abaixo mostra um exemplo simples de uso. A função `_ready` chama a thread e continua a execução. Logo depois ela trava a variável `counter` e faz um incremento nela. Isso é necessário pois a thread também vai acessar esta variável. Não é certo quem vai acessar primeiro a variável, se é a main thread ou a thread criada. Mas ambas travam a variável assim que o código chega nela. Desta maneira, é garantido que uma thread vai esperar a outra liberar a variável. Assim o resultado final será `counter = 2`.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/4fc2da54-13b5-4160-9035-2250517d6867" />
</p>

⚠️ **Atenção:** Neste exemplo em particular a chamada `thread.wait_to_finish()` foi feito dentro do `_ready`. Nunca faça isso em produção! Esta chamada trava tudo até as threads finalizarem as suas execuções. O único motivo de termos colocado este chamada na `_ready` é porque o print não aparece quando a `_exit_tree` é chamada.

## Semáforos

*Semáforos* basicamente são comandos que mandam a thread ficar em espera (semáforo vermelho) até ser enviado um sinal dizendo que pode continuar a execução (semáforo verde). Este sinal sempre vem de fora, nunca da própria thread. 

Abaixo temos um exemplo simples onde a thread fica esperando a thread main enviar o sinal. A main envia este sinal quando o usuário pressiona o *ui_accept* (tecla de espaço em teclado). O comando de espera é o `semaphore.wait()` e o comando de execução é o `semaphore.post()`. Importante esclarecer que o `semaphore.wait()` de fato trava a thread naquela linha de código. O while ali não fica girando e checando toda hora se chegou algum sinal. Ele é para repetir a execução toda do início após a thread executar a tarefa. 

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/e6d27c41-6ccf-480a-b270-830807ab2c9f" />
</p>

Para finalizar, colocamos abaixo uma pequena tabela com um resumo do que cada ferramenta faz. Pode ser útil quando você quer lembrar rapidamente de algo.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/a92585c4-8b71-4571-ba58-65f27c38b650" />
</p>
