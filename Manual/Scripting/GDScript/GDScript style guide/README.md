# GDScript style guide

Este tópico tem como propósito ser um conjunto de estilos de escrita de código para mim mesmo. Não espero que isso seja usado por terceiros, é algo pessoal. Inclusive, algumas convenções da documentação oficial eu vou ignorar e usar o meu estilo no lugar. Dito isso, vamos começar!

## Indentação

- Use Tabs em vez de espaços para indentação.
- Cada nível é um Tab a mais que o nível anterior.
- Para variáveis com diversos elementos, usar um Tab para quebra de linhas entre os elementos. Os símbolos limitadores (parênteses, chaves, etc) ficam separados dos elementos, sendo que o primeiro fica na mesma linha da variável e o segundo uma linha após os elementos, e alinhado verticalmente com a variável.

```python
var character_dict = {
    "Name": "Bob",
    "Age": 27,
    "Job": "Mechanic",
}
```

Se for uma variável com muitos elementos, eu considero ok aproveitar cada linha para inserir múltiplos elementos. Idealmente, fazer isso de maneira organizada.

```python
var character_dict = {
    "Name": "Bob", "Age": 27, "Job": "Mechanic",
    "Name": "Suzy", "Age": 25, "Job": "Singer",
    "Name": "Rachel", "Age": 32, "Job": "Investor",
}
```

> PS: O Tab é em relação à variável. Se ela estiver dentro de outra estrutura e for necessário dar 5 Tabs para checar ao nível dela (por exemplo), então cada elemento vai necessitar de 6 Tabs. Em muitos editores (incluindo a Godot), ao dar ENTER de uma linha para a outra, automaticamente ele já vai posicionar corretamente.

Se for uma função, sempre preferir usar uma única linha, tanto para a definição quanto para a chamada.

```python
func change_color(node, red, green, blue):
    node.modulate = Color(r, g, b)

change_color($Sprite2D, 0.4, 0.5, 0.8)
```

Caso a linha fique muito longa, aí sim é necessário usar indentação. Usamos a mesma regra descrita acima.

```python
func change_color(
    node,
    red,
    green,
    blue,
    alpha
):
    node.modulate = Color(red, green, blue, alpha)

change_color(
    $Sprite2D,
    0.4,
    0.5,
    0.8,
    0.3
)
```

A ideia de usar vários elementos por linha continua valendo, caso isso ajude na organização.


```python
func change_color(
    node,
    red, green, blue,
    alpha
):
    node.modulate = Color(red, green, blue, alpha)

change_color(
    $Sprite2D,
    0.4, 0.5, 0.8,
    0.3
)
```

> PS: Em geral, indentação de funções vai ocorrer mais nas chamadas do que nas definições, pois as chamadas tem inputs que geralmente vão ocupar mais espaço de linha.

> PS: Sempre coloque uma vírgula no último elemento da variável, mesmo que ocupe uma única linha. Você pode ver que fizemos isso nos exemplos acima (a função não entra nessa regra). É interessante fazer isso pois, caso você queira adicionar mais elementos futuramente, o diff não vai acusar o último elemento que estava antes.

## Linhas em branco

Use uma linha em branco para separar funções/métodos. Use duas linhas em branco para separar grupos de estruturas. 

No exemplo abaixo, temos 3 estruturas: extends, variáveis globais e funções. Note que as variáveis globais possuem uma separação interna, sempre organizando com uma linha em branco entre as partes. A ideia geral é essa: grandes estruturas separadas por duas linhas em branco, partes internas de cada estrutura separadas por uma linha em branco.

<p align="center">
    <img width="400" src="https://github.com/user-attachments/assets/6a15d305-7fdd-4fb5-ae1d-77d4b29c3605" />
</p>

Eu sei que muito programador prefere usar duas linhas em branco para separar as funções, e um argumento para isso é que dentro das funções já se usa uma linha em branco para organizar as partes internas da função. Seguindo essa lógica, deveríamos ter 3 linhas para separar as grandes estruturas, o que eu já acho demais. E deixar de usar essa separação das grandes estruturas eu não considero aceitável. Para mim, apenas uma linha de diferença entre as funções já é o suficiente para identificar visualmente.

## Comprimento da linha

O recomendado é limitar cada linha a no máximo 100 caracteres. O próprio editor já mostra uma linha vertical para identificar este limite (ela já é mostrada ali por default).

<p align="center">
    <img width="650" src="https://github.com/user-attachments/assets/fc59d34e-b80b-46cd-a8bb-c265d442adfb" />
</p>

## Múltiplas condicionais

Se tiver um `if` com múltiplas condições para serem verificadas, é possível colocar tudo em uma linha, desde que esteja no limite de 100 caracteres.

```python
if position.x > 200 and position.x < 400 and position.y > 300 and position.y < 400:
	pass
```

Aqui é opcional usar a convenção de quebra de linhas, seguindo a mesmo ideia das variáveis com múltiplos elementos:

```python
if (
    position.x > 200 and position.x < 400
    and position.y > 300 and position.y < 400
):
	pass
```

[Anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#controle-de-fluxo), introduzimos o if ternário mas usamos uma convenção antiga de escrita. Vamos colocar aqui o estilo antigo e o novo (recomendado) para referência.

**Antigo**

```python
var fruit = ("apple" if x == 2
              else "pear" if x == 1
              else "banana" if x == 0
              else "orange"
             )
var fruit = "apple" if x == 2\
             else "pear" if x == 1\
         	 else "banana" if x == 0\
             else "orange"
```

**Novo**

```python
var fruit = (
    "apple" if x == 2
    else "pear" if x == 1
    else "banana" if x == 0
    else "orange"
)
var fruit = \
    "apple" if x == 2\
    else "pear" if x == 1\
    else "banana" if x == 0\
    else "orange"
```

Confesso que eu prefiro o estilo antigo, não apenas para o if ternário, mas para funções e variáveis com múltiplos também. O problema deste estilo é a falta de praticidade dele. Você tem que ficar alinhando tudo na mão. Quaçquer mudança de nome de variável e tudo tem que ser realinhando novamente. O estilo novo requer apenas um Tab e está pronto. 

## Parênteses

- Evite parênteses redundantes como `if (is_colliding())`. Usar `if is_colliding()` é equivalente e é mais legível.
- Para expressões lógicas é recomendado o uso de parênteses (explícito) em vez de se valer de como a engine resolve a expressão internamente (implícito). Prefira usar `if (red and blue) or not green` em vez de `if red and blue or not green` por exemplo.
- No caso de expressões matemáticas, a mesma recomendação acima continua valendo. Prefira usar `(2 ** 3) * 4` em vez de `2 ** 3 * 4` por exemplo.

## Espaços

- Sempre use espaços entre operadores, após vírgulas e após dois pontos (:) de dicionários. Aecssar elementos de arrays ou dicionário com colchetes [] não deve incluir espaçamentos.

**Bom**

```python
position.x = 5
position.y = target_position.y + 10
dict["key"] = 5
my_array = [4, 5, 6]
my_dictionary = {key: "value" }
print("foo")
```

**Ruim**

```python
position.x=5
position.y = mpos.y+10
dict ["key"] = 5
myarray = [4,5,6]
my_dictionary = {key:"value"}
print ("foo")
```
