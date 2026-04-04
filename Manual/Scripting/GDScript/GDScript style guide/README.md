# GDScript style guide

Este tópico tem como propósito ser um conjunto de estilos de escrita de código para mim mesmo. Não espero que isso seja usado por terceiros, é algo pessoal. Inclusive, algumas convenções da documentação oficial eu vou ignorar e usar o meu estilo no lugar. Dito isso, vamos começar!

## Indentação

- Use Tabs em vez de espaços para indentação.
- Cada nível é um Tab a mais que o nível anterior.
- Para variáveis com diversos elementos, usar um Tab para quebra de linhas entre os elementos. Os símbolos limitadores (parênteses, chaves, etc) ficam separados dos elementos, sendo que o primeiro fica na mesma linha da variável e o segundo uma linha após os elementos, e alinhado com a variável.

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

Se for uma função, sempre preferir usar uma única linha, tanto para a definição quanto a chamada.

```python
func change_color(node, red, green, blue):
    node.modulate = Color(r, g, b)

change_color($Sprite2D, 0.4, 0.5, 0.8)
```

Caso a linha fique muito longa, aí sim é necessário usar indentação. Nesse caso, use a mesma regra definida acima.

```python
func change_color(
    node,
    red,
    green,
    blue,
    alpha
):
    node.modulate = Color(r, g, b)

change_color(
    $Sprite2D,
    0.4,
    0.5,
    0.8,
    0.3
)
```

> PS: Em geral, indentação de funções vai ocorrer mais nas chamadas do que nas definições, pois as chamadas tem inputs que geralmente vão ocupar mais espaço de linha.
> PS: Sempre coloque uma vírgula no último elemento da variável. Você pode ver que fizemos isso nos exemplos acima (a função não entra nessa regra). É interessante fazer isso pois, caso você queira adicionar mais elementos futuramente, o diff não vai acusar o último elemento que estava antes.
