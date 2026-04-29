# Tween

*Tweens* são mais úteis para animações que exigem a interpolação de uma propriedade numérica em um range de valores. O nome "tween" vem de "in-betweening", uma técnica de animação em que você especifica keyframes e o computador interpola os quadros que aparecem entre eles. Animar algo com um Tween é chamado de "tweening".

O Tween é mais adequado do que o `AnimationPlayer` para animações em que você não conhece os valores finais antecipadamente. Tweens também são mais leves do que o `AnimationPlayer`, portanto, são muito adequados para animações simples ou tarefas gerais que não exigem ajustes visuais fornecidos pelo editor. 

Você deve evitar usar mais de um Tween por propriedade de um objeto. Se dois ou mais Tweens animarem uma propriedade ao mesmo tempo, o último criado terá prioridade e atribuirá o valor final. Se você quiser interromper e reiniciar uma animação, considere atribuir o Tween a uma variável.

As animações Tween não foram projetadas para serem reutilizadas e tentar fazer isso resulta em um comportamento indefinido. Crie uma nova animação Tween para cada animação e sempre que você reproduzir uma animação desde o início. Lembre-se de que as animações Tween iniciam imediatamente, portanto, crie uma animação Tween somente quando desejar começar a animação. Pense que toda a configuração de uma animação Tween deve ser feito em um único frame. A animação em si pode levar mais frames, mas a configuração não (então usar coisas como `await` em um `Timer` entre as configurações pode resultar em erro).

## create_tween()

É possível criar um Tween com os comandos `get_tree().create_tween()` e `create_tween()`. No primeiro caso ele está atrelado à cena, enquanto que no segundo caso está atrelado ao node que o chamou. O primeiro é mais global e mais suscetível a erros, pois se o node associado ao script que chamou este Tween for removido. isto vai causar um erro. No segundo caso o Tween é removido junto do node.

Em todos os exemplos de código abaixo, vamos supor que o comando `tween = create_tween()` foi executado previamente.

## tween_property()

Este é de longe o método mais importante do Tween. Ele recebe 4 argumentos, em ordem: objeto, propriedade, valor final e tempo em segundos. Você diz ao programa que uma certa propriedade de um certo objeto deve ser alterada até chegar a um certo valor em um certo tempo. Abaixo segue um exemplo em que o programa altera a cor de um sprite para vermelho em $1$ segundo, depois reduz a escala até zero em $1$ e depois volta a escala ao normal, também em $1$ segundo.


```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
```

## tween_callback()

Chama uma função qualquer para ser executada.

```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
tween.tween_callback(sprite.queue_free)
```

## set_trans()

Define como a transição de valores do `tween_property` ocorre. A transição default é a linear. Todas as possíveis transições podem ser encontradas [aqui](https://docs.godotengine.org/en/stable/classes/class_tween.html#enum-tween-transitiontype).

```python
tween.tween_property(sprite, "modulate", Color.RED, 2.0).set_trans(Tween.TRANS_SINE)
tween.tween_property(sprite, "modulate", Color.RED, 2.0).set_trans(Tween.TRANS_BOUNCE)
```

## tween_interval()

Cria um tempo de espera no meio das animações.

```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.tween_interval(1.0)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
```

## tween_method()

Chama uma função que recebe um único parâmetro e executa essa função várias vezes dentro de um range de valores estabelecido e dentro de um tempo estabelecido. Por exemplo, o comando do exemplo abaixo vai chamar a função `set_flash` várias vezes durante 2 segundos. Nesse tempo, os valores na função irão varias de $0.0$ a $1.0$.

```python
func set_flash(amount: float) -> void:
	sprite.modulate = Color(1.0, amount, amount)

tween.tween_method(set_flash, 1.0, 0.0, 2.0)
```

## set_ease()

Controla a velocidade da transição. O `Tween.EASE_IN` começa devagar e acelera no final. O `Tween.EASE_OUT` começa rápido e desacelera no final.

```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0).set_ease(Tween.EASE_OUT)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
```

## parallel()

Esse método faz com que o o próximo comando de Tween seja executado junto do anterior. Por exemplo, o código abaixo vai executar as duas primeiras linhas em paralelo e depois a terceira linha é executada.

```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.parallel().tween_property(sprite, "scale", Vector2.ZERO, 1.0)
tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
```

## set_parallel() e chain()

Todos os Tweens após o `set_parallel(true)` são executados em paralelos. Assim como é o caso do `parallel()`, o Tween logo antes do comando também é executado em paralelo aos que vem depois. O comando `chain()` encerra passo anterior e começa um novo. Por exemplo, no código abaixo todos os Tweens são executados em paralelo, com exceção do último que é executado depois.

```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.set_parallel(true)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
tween.tween_property(sprite, "rotation_degrees", 180.0, 1.0)
tween.chain().tween_property(sprite, "scale", Vector2.ONE, 1.0)
```

## set_loops()

Esse método faz com que o Tween repita toda a sequência de animações um determinado número de vezes. No exemplo abaixo, a sequência completa será executada 3 vezes.

```python
tween = tween.set_loops(3)
tween.tween_property(sprite, "modulate", Color.RED, 0.5)
tween.tween_property(sprite, "scale", Vector2.ZERO, 0.5)
tween.tween_property(sprite, "scale", Vector2.ONE, 0.5)
```

## bind_node()

Esse método faz com que o Tween esteja vinculado ao node. Assim que o node é removido da cena, o Tween é removido junto. No exemplo abaixo, a última linha não é executada pois o node foi removido da cena (não precisa ser removido pelo próprio Tween). 

```python
tween = tween.bind_node(sprite)
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
tween.tween_callback(sprite.queue_free)
tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
```

##  stop() e play()

Esse par de métodos serve para interromper e depois retomar um Tween. O `stop()` pausa o tweening e o `play()` retoma um Tween que estava pausado. No exemplo abaixo, o Tween começa normalmente. Após $1.5$ segundos vem o `stop()`, que pausa a animação no ponto atual. Ele espera mais $1.5$ segundos e vem dá o `play()`, que retoma de onde parou. A retomada da animação será na metade da animação da linha `tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)`.

```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0)
tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
await get_tree().create_timer(1.5).timeout
tween.stop()
await get_tree().create_timer(1.5).timeout
tween.play()
```

> PS: Se um Tween estiver parado e não estiver preso a um node, ele pode continuar existindo indefinidamente até ser retomado ou invalidado manualmente (com o método `kill`).

## set_delay()

Esse método adiciona um atraso antes de iniciar um Tweener específico. No exemplo abaixo, ele executa a primeira linha e espera $1$ segundo para executar a segunda. à primeira vista isso pode parecer equivalente ao `tween_interval()`, mas o comportamento será diferente quando `parallel()` estiver sendo usado também.

```python
tween.tween_property(sprite, "modulate", Color.RED, 1.0)
tween.tween_property(sprite, "scale", Vector2.ZERO, 1.0).set_delay(1)
tween.tween_property(sprite, "scale", Vector2.ONE, 1.0)
```

Existem muitos outros métodos que podem ser usados no Tween. A lista mostrada aqui contém apenas os mais usuais. Os outros métodos podem ser encontrados [aqui](https://docs.godotengine.org/en/stable/classes/class_tween.html#).
