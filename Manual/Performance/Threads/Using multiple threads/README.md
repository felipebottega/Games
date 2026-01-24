# Using multiple threads

Threads é o que permite você obter paralelismo com o seu script na Godot. A Godot não limita o número de threads ao número de núcleos, mas é recomendado que não se use mais threads que o número de núcleos da sua CPU. Criar threads é um processo lento, por isso é recomendado criar as threads previamente (em um loading de jogo, por exemplo) e requisitá-las posteriormente durante o jogo.

## Método bind

Antes de falar de threads, devemos introduzir o método `bind`, pois ele será necessário. Este é um método aplicado sobre funções. Ele tem o papel de fixar alguns argumentos da função e retornar uma função nova, que é uma cópia da orignal mas com menos argumentos. Por exemplo, considere a função matemática $f(x, y, z) = x + y -z$. Se quisermos travar ela em $z = 1$, na Godot faríamos `f.bind(1)`, o que seria equivalente a definir a função $g(x, y) = f(x, y, 1)$. A nova função `f.bind(1)` recebe $x, y$ como argumentos. Por exemplo, podemos ter `f.bind(1).call(2, 3) = 2 + 3 - 1 = 4`.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7204e92e-72da-4675-8b8f-92e84e7f1d60" />
</p>

É importante notar que os argumentos em `bind` sempre vem após os argumentos que você usará em `f.bind`. Por exemplo, se fosse definida a função `f.bind(1, 2)`, internamente a engine esperaria apenas um argumento para ela, que seria $x$, com $y = 1$ e $z = 2$ fixados. Também é possível criar uma função com o `bind` usando todos os argumentos da função. Deste modo, a função será simplesmente uma constante.

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

## Criando múltiplas threads
