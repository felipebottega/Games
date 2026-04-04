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

