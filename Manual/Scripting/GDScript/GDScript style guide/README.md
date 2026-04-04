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

Se for uma variável com muitos elementos, você pode aproveitar cada linha para inserir múltiplos elementos apenas quando há uma organização clara (cada linha representa algo diferente das outras).

```python
var character_dict = {
    "HeroName": "Bob", "HeroAge": 27, "HeroJob": "Mechanic",
    "NPCName": "Liz", "NPCAge": 25, "NPCJob": "Singer",
    "VillanName": "Tom", "VillanAge": 32, "VillanJob": "Investor",
}
```

Note que esse exemplo dado é bastante artificial. Seria totalmente factível usar um dicionário com as chaves "Hero", "NPC", "Villan" e cada chave corresponder a um outro dicionário com os três campos descritos. Não acho que este tipo de formatação será usada muitas vezes, mas impossível não é.

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

## Comentários

Já falamos bastante sobre comentários no [tutorial de referência](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#coment%C3%A1rios). Porém, naquele tutorial apenas falamos sobre as funcionalidades e comentário que o editor oferece, mas não sobre convenções de como fazer comentários. Vamos listar o nosso estilo aqui.

- Comentários sempre são uma frase, começando com letra maiúscula e terminando com ponto final. Isso vale mesmo para o caso em que o comentário é uma única palavra.

```python
## Esta função faz algumas contas.
func f(x, y, z):
    # Incrementamos cada variável em uma unidade.
    x += 1
    y += 1
    z += 1

    # Somatório.
    var u = x + y + z

    return u
```

- Não use mais que dois `#` para iniciar um comentário. Se quiser dar destaque, use as palavras especiais de comentário (ALERT, CRITICAL, TODO, etc.) ou use letras maiúsculas ou faça uma região de código. Criar linhas com separadores visuais como `---` ou `===` também está valendo.
- Comentários também respeitam o limite de caracteres. Se chegar ao limite, continue o comentário na próxima linha normalmente.
- Comentários mais curtos e de menor importância podem vir logo após a linha do comando feito, com um espaço entre o comando e o comentário.

```python
# O comando abaixo é importante e merece um comentário longo numa linha separada.
var x = f(x, y, z)  + g(x, y, z) + e(t)

var w = x + w # Comentário curto pois o comando é muito simples e direto de entender.
```

## Espaços

- Sempre use espaços entre operadores, após vírgulas e após dois pontos (:) de dicionários. Acesso a elementos de arrays ou dicionário com colchetes [] não deve incluir espaçamentos.

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
position.y = target_position.y+10
dict ["key"] = 5
my_array = [4,5,6]
my_dictionary = {key:"value"}
print ("foo")
```

- Não use espaçamentos para alinhar valores verticalmente.

**Bom**

```python
x = 100
y = 100
velocity = 500
```

**Ruim**

```python
x        = 100
y        = 100
velocity = 500
```

## Aspas

Prefira sempre usar aspas duplas para strings, a menos que tenha alguma citação na string que requer aspas duplas, aí você usa aspas simples para encapsular a string. Há dois motivos principais para seguir essa convenção:
1. É o que a maioria usa, então terá menos atrito com a comunidade.
2. Evitar ter que usar barras invertidas dentro da string por causa de apóstrofos. Por exemplo, é preferível descrever `"Caixa d'água"` a `'Caixa d\'água'`.

## Números

- Não omita zeros à esquerda da casa decimal. Por exemplo, $0.41$ em vez de $.41$.
- Use underline em números para ajudar na leitura de números com muitos caracteres. Mas evite fazer isso para números pequenos.

**Bom** 

```python
var large_number = 1_234_567_890
var large_hex_number = 0xffff_f8f8_0000
var large_bin_number = 0b1101_0010_1010
var small_number = 12345
```

**Ruim**

```python
var large_number = 1234567890
var large_hex_number = 0xfffff8f80000
var large_bin_number = 0b110100101010
var small_number = 12_345
```

## Convenção de nomes

Siga a convenção de nomes dada pela tabela abaixo (está em total concordância com a convenção da Godot):

| Type         | Convention    | Example                   |
| ------------ | ------------- | ------------------------- |
| File names   | snake_case    | `yaml_parser.gd`            |
| Class names  | PascalCase    | `class_name YAMLParser`     |
| Node names   | PascalCase    | `Camera3D, Player`          |
| Functions    | snake_case    | `func load_level():`        |
| Variables    | snake_case    | `var particle_effect`       |
| Signals      | snake_case    | `signal door_opened`        |
| Constants    | CONSTANT_CASE | `const MAX_SPEED = 200`     |
| Enum names   | PascalCase    | `enum Element`              |
| Enum members | CONSTANT_CASE | `{EARTH, WATER, AIR, FIRE}` |

## Tipagem estática 

Já falamos sobre tipagem na parte de variáveis tipadas em [outro tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#vari%C3%A1veis-tipadas). Considere esta seção como uma continuação daquela.

- Ao definir uma variável tipada, use a sintaxe `var my_variable: my_type` ou `var my_variable: my_type = my_initial_value`, com estes exatos espaçamentos mostrados.
- Ao definir funções tipadas, use a sintaxe func my_function(my_arg1: my_type1, my_arg2: my_type2) -> my_output_type:`, com estes exatos espaçamentos mostrados.
- Evite explicitar o tipo da variável quando ele já é explícito pela própria definição.

**Bom**

```python
var direction := Vector3(1, 2, 3)
```

**Ruim**
```python
var direction: Vector3 = Vector3(1, 2, 3)
```

> PS: No caso de ser uma função sua, em teoria não seria necessária explicitar o tipo pois a engine consegue inferir, mas para a leitura de código isso fica ruim. Qualquer pessoa que for leu o seu código terá que navegar até a função para saber qual o tipo da saída dela.

- Ao usar `get_node`, prefira explicitar o tipo de node em vez de deixar para a engine inferir.

**Bom**

```python
@onready var health_bar: ProgressBar = get_node("UI/LifeBar")
```

**Ruim**

```python
@onready var health_bar = get_node("UI/LifeBar")
@onready var health_bar := get_node("UI/LifeBar")
```

## Estrutura do código 

A estrutura do código é a ordem que os blocos de código seguir no script. A sugestão oficial é a que eu vou seguir aqui, mas com as devidas simplificações e ajustes. A numeração abaixo se refere ao número do item, não a linha de fato. Também incluir as quebras de linhas entre cada bloco, de acordo com a minha convenção.

```python
01. @tool, @icon
02. class_name
03. extends
04. ## documentation

05. signals

06. enums

07. constants

08. static variables

09. remaining regular variables

10. @export variables

11. @onready variables


13. static methods/functions


14. overridden built-in virtual methods/functions:
	1. _init()
	2. _enter_tree()
	3. _ready()
	4. _process()
	5. _physics_process()
	6. remaining virtual methods/functions

15. overridden custom methods/functions

16. remaining methods/functions


17. inner classes
```

Vamos falar um pouco sobre cada um dos itens acima.

- **@tool, @icon:** Estas duas anotações já foram discutidas anteriormente. Nenhuma das duas é obrigatória para o projeto. Caso você pretenda usar o script no editor, a anotação `@tool` deve vir na primeira linha, e na segunda linha que vem o `@icon`.
- **class_name:** Nome da classe, caso tenha um nome.
- **extends:** Classe pai do qual a classe do script irá herdar. Esta linha é obrigatória.
- **## documentation:** Documentação do script/classe.
- **signals:** Variáveis de sinal. 
- **enums:** Enumeração de constantes. 
- **constants:** Valores de constantes. 
- **static variables:** Variáveis estáticas da classe.
- **remaining regular variables:** Outras variáveis da classe. Na maioria dos exemplos mostrados, foram estas as variáveis globais que declaramos.
- **@export variables:** Variáveis que irão aparecer no *Inspector*.
- **@onready variables:** Variáveis que serão carregadas assim que a cena for carregada.
- **static methods/functions:** 
