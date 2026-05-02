# GDScript reference

Todo conteúdo deste tópico já está muito bem documentado no [site oficial](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html), mas mesmo assim vou replicar o conteúdo aqui, no meu estilo.

## Keywords

*Keywords* são palavras reservadas da linguagem. Elas não podem ser declaradas como variáveis (ou funções, classes, etc.) novas. Devem ser utilizadas com o propósito original delas. 

| Keyword | Descrição |
|--------------|-----------|
| `if`           | Veja if/else/elif. |
| `elif`         | Veja if/else/elif. |
| `else`         | Veja if/else/elif. |
| `for`          | Veja for. |
| `while`        | Veja while. |
| `match`        | Veja match. |
| `when`         | Usado por pattern guards em instruções match. |
| `break`        | Encerra a execução do loop for ou while atual. |
| `continue`     | Pula imediatamente para a próxima iteração do loop for ou while. |
| `pass`         | Usado quando uma instrução é exigida sintaticamente, mas não se deseja executar código (ex: funções vazias). |
| `return`       | Retorna um valor de uma função. |
| `class`        | Define uma classe interna. Veja Classes internas. |
| `class_name`   | Define o script como uma classe globalmente acessível com o nome especificado. Veja Registro de classes nomeadas. |
| `extends`      | Define qual classe será estendida pela classe atual. |
| `is`           | Testa se uma variável estende uma determinada classe ou é de um tipo embutido específico. |
| `in`           | Testa se um valor está contido em uma string, array, range, dicionário ou nó. Quando usado com for, itera sobre eles em vez de testar. |
| `as`           | Converte o valor para um tipo específico, se possível. |
| `self`         | Refere-se à instância atual da classe. Veja self. |
| `super`        | Resolve o escopo do método da classe pai. Veja Herança. |
| `signal`       | Define um sinal. Veja Sinais. |
| `func`         | Define uma função. Veja Funções. |
| `static`       | Define uma função estática ou uma variável membro estática. |
| `const`        | Define uma constante. Veja Constantes. |
| `enum`         | Define um enum. Veja Enums. |
| `var`          | Define uma variável. Veja Variáveis. |
| `breakpoint`   | Auxiliar do editor para pontos de parada (debug). Diferente dos breakpoints criados clicando na margem, este é armazenado no script, tornando-o persistente entre máquinas com controle de versão. |
| `preload`      | Pré-carrega uma classe ou variável. Veja Classes como recursos. |
| `await`        | Aguarda um sinal ou uma corrotina terminar. Veja Aguardando sinais ou corrotinas. |
| `assert`       | Verifica uma condição e registra erro se falhar. Ignorado em builds não-debug. Veja assert. |
| `void`         | Usado para indicar que uma função não retorna valor. |
| `PI`           | Constante PI. |
| `TAU`          | Constante TAU. |
| `INF`          | Constante de infinito. Usada para comparações e como resultado de cálculos. |
| `NAN`          | Constante NAN (não é um número). Usada como resultado impossível de cálculos. |

## Operadores

| Operador | Descrição |
|----------|-----------|
| `( )` | Parênteses não são exatamente um operador, mas permitem definir explicitamente a precedência de uma operação. |
| `x[index]` | Acesso por índice. |
| `x.attribute` | Referência a atributo. |
| `foo()` | Chamada de função. |
| `await x` | Aguarda sinais ou corrotinas. |
| `x is Node` <br> `x is not Node` | Verificação de tipo. Veja também a função is_instance_of(). |
| `x ** y` | Potência. Multiplica x por ele mesmo y vezes, similar à função pow(). |
| `~x` | NOT bit a bit. |
| `+x` <br> `-x` | Identidade / Negação. |
| `x * y` <br> `x` <br> `y` <br> `x % y` | Multiplicação / Divisão / Resto. O operador % também é usado para formatação de strings. |
| `x + y` <br> `x - y` | Adição (ou concatenação) / Subtração. |
| `x << y` <br> `x >> y` | Deslocamento de bits. |
| `x & y` | AND bit a bit. |
| `x ^ y` | XOR bit a bit. |
| `x \| y` | OR bit a bit. |
| `x == y` <br> `x != y` <br> `x < y` <br> `x > y` <br> `x <= y` <br> `x >= y` | Comparação. |
| `x in y` <br> `x not in y` | Verificação de pertencimento. |
| `not x` <br> `!x` | NOT booleano e seu alias não recomendado. |
| `x and y` <br> `x && y` | AND booleano e seu alias não recomendado. |
| `x or y` <br> `x \|\| y` | OR booleano e seu alias não recomendado. |
| `true_expr if cond else false_expr` | If/else ternário. |
| `x as Node` | Conversão de tipo (cast). |
| `x = y` <br> `x += y` <br> `x -= y` <br> `x *= y` <br> `x /= y` <br> `x **= y` <br> `x %= y` <br> `x &= y` <br> `x \|= y` <br> `x ^= y` <br> `x <<= y` <br> `x >>= y` | Atribuição. Não é possível usar operadores de atribuição dentro de uma expressão. |

O comportamento de alguns operadores pode ser diferente do que você espera:
 - No operador `/`, se ambos os valores forem do tipo `int`, então será realizada a divisão inteira em vez de fracionária. Por exemplo, `5 / 2 == 2`, e não `2.5`. Se isso não for desejado, use pelo menos um float na conta (`x / 2.0`) ou faça um cast (`x / float(y)`).
 - O operador `%` está disponível apenas para `int`. Para float, use a função `fmod()`.
 - Os operadores `==` e `!=` às vezes permitem comparar valores de tipos diferentes (por exemplo, `1 == 1.0` é true), mas em outros casos isso pode causar erro em tempo de execução. Se você não tiver certeza sobre os tipos dos elementos, pode usar a função `is_same()` (mas note que ela é mais rigorosa quanto a tipos e referências). Para comparar float, use as funções `is_equal_approx()` e `is_zero_approx()`.

## Anotações

Anotações são marcações especiais no GDScript que começam com `@` e servem para modificar o comportamento do código ou dizer algo ao editor/compilador. São instruções extras que dizem à engine como tratar partes do seu script.

### @export

Esta anotação permite que uma variável apareça no *Inspector* da Godot, para você editar sem mexer no código.

### @onready

Inicializa uma variável só depois que o node estiver pronto na cena. Ou seja, caso ela dependa de algo que dependa do corregamento da cena, não vai quebrar a execução.

> PS: Não é obrigatório implementar a função `_ready()` quando se usa a anotação `@onready`.

## Comentários

Comentários normais começam com `#`, que nem em Python. Para a maioria das situações isso é o suficiente, mas a Godot fornece muitos outros tipos de comentários especiais. Veremos todos eles agora.

As palavras da figura abaixo são especiais em comentários. A engine, automaticamente, vai colorir estas palavras para dar destaque.

<p align="center">
 <img width="400" src="https://github.com/user-attachments/assets/c321f511-1e68-44c4-8c51-ef9939b3af7e" />
</p>

O uso de `##` faz com que o comentário tenha caráter de documentação, e vai aparecer como tooltip em outros lugares. Por exemplo, ao colocar este tipo de comentário sobre uma variável de um script e depois utilizar esta variável em outro lugar (pode ser no mesmo script ou em outro), você poderá passar o mouse por cima e visualizar a descrição dela.

<p align="center">
 <img width="420" src="https://github.com/user-attachments/assets/c073a701-1344-4a8f-b920-093e8a74ecc9" />
 <img width="580" src="https://github.com/user-attachments/assets/a784a91e-ad9f-4b80-8e33-23e2bee7e1de" />
</p>

Isso também pode ser feito para funções.

<p align="center">
 <img width="210" src="https://github.com/user-attachments/assets/30eff345-cbdb-4721-bc1e-4cb8e651627f" />
 <img width="650" src="https://github.com/user-attachments/assets/d7ee59cd-0098-4531-bbcb-7edc6ef821eb" />
</p>

No caso de fazer isso para uma variável com a anotação `@export`, a descrição também aparece no *Inspector*.

<p align="center">
 <img width="330" src="https://github.com/user-attachments/assets/be2e7a5c-17f8-4b0d-8b7b-c35c935f0f02" />
 <img width="650" src="https://github.com/user-attachments/assets/7d0e27c4-017d-4c72-bc2d-82ec5c783edd" />
</p>

Se estiver trabalhando com uma classe nomeada, você pode inserir comentários com `##` logo acima da nomeação da classe (`class_name`) ou logo abaixo do `extends`. Isso vai gerar uma dosctring daquela classe, que pode, inclusive, ser acessada pelo help do editor. Depois que definir uma documentação (como mostrado abaixo), veja o resultado indo em *Help → Search Help...* e digitando o nome da classe. O exemplo abaixo mostra o básico para uma boa documentação.

<p align="center">
	<img width="600" src="https://github.com/user-attachments/assets/b961b2bc-c18b-42bf-a4a5-67b5cf9d0a75" />
</p>

<p align="center">
	<img width="600" src="https://github.com/user-attachments/assets/298db084-f650-4d9e-af1f-b9dea13d7828" />
</p>

> PS: A sintaxe usada para a estilização se chama [BBCode](https://www.bbcode.org/reference.php).

## Regiões de código

Uma região de código é um tipo de comentário especial também, mas nesse caso é necessário inserir dois comentários: um para dizer onde começa a região e o outro para dizer onde termina. Você coloca `#region` logo antes do trecho do código de interesse e coloca `#endregion` logo após o trecho. Abaixo temos um exemplo de como isso é feito. O interessante deste método é que você pode colapsar a região inteira ao clicar na setinha ao lado do `#region`. Isso é bastante útil para organizar visualmente código grandes.

<p align="center">
 <img width="200" src="https://github.com/user-attachments/assets/723a6f8f-6cec-4ea5-8774-c818a948999c" />
 <img width="300" src="https://github.com/user-attachments/assets/419f7e84-0125-42cb-b535-4fd96655fc82" />
</p>

Também é possível acrescentar uma descrição na linha do `#region`, muito útil para saber do que trata a região de código sem ter que abri-la.

<p align="center">
 <img width="450" src="https://github.com/user-attachments/assets/7de42708-9685-45eb-adb8-f073a11c3cc9" />
 <img width="500" src="https://github.com/user-attachments/assets/54459858-71d1-4d58-b8a1-228be851165e" />
</p>

## Continuação de linhas

Quando uma linha de código é muito extensa, pode ser interessante introduzir uma quebra de linha. A Godot usa a barra backslash `\` para este fim. Os exemplos abaixo são válidos e devem ser o suficiente para demonstrar como isso funciona.

```python
var a = 1 + \
2

var b = 1 + \
4 + \
10 + \
4
```

## Tipos

### Básicos

| Tipo        | Descrição |
|-------------|----------|
| `null`      | Tipo vazio que não contém informação e não pode receber outro valor. Apenas tipos que herdam de `Object` podem ser nulos ("nullable"). Tipos `Variant` devem sempre ter um valor válido. |
| `bool`      | Tipo booleano que armazena apenas `true` ou `false`. |
| `int`       | Número inteiro (positivo ou negativo). Armazenado como 64 bits. |
| `float`     | Número real com casas decimais. Armazenado como 64 bits. Algumas estruturas reduzem a precisão para 32 bits (ex: `Vector2`, `Vector3`). |
| `String`    | Sequência de caracteres em formato Unicode. |
| `StringName`| String imutável com instância única por nome. Mais lenta para criar, mas muito rápida para comparação (ideal para chaves de dicionário). |
| `NodePath`  | Caminho pré-processado para um node ou propriedade. Pode ser convertido de/para `String` e facilita interações com a árvore de cenas. |

> PS: `Variant` basicamente quer dizer que a variável é de tipagem dinâmica.

### Vetores

| Tipo           | Descrição |
|----------------|----------|
| `Vector2`      | Vetor 2D com campos `x` e `y`. Também pode ser acessado como array. |
| `Vector2i`     | Igual ao `Vector2`, mas com componentes inteiros. Útil para grids 2D. |
| `Rect2`        | Retângulo 2D com `position` e `size`. Possui também `end` (`position + size`). |
| `Vector3`      | Vetor 3D com campos `x`, `y` e `z`. Também pode ser acessado como array. |
| `Vector3i`     | Igual ao `Vector3`, mas com componentes inteiros. Útil para grids 3D. |
| `Transform2D`  | Matriz 3×2 usada para transformações em 2D. |
| `Plane`        | Plano 3D normalizado com vetor normal e distância escalar. |
| `Quaternion`   | Tipo usado para representar rotação 3D. Ideal para interpolação de rotações. |
| `AABB`         | Caixa 3D alinhada aos eixos, com `position` e `size`. Possui `end` (`position + size`). |
| `Basis`        | Matriz 3×3 usada para rotação e escala em 3D. Contém vetores `x`, `y` e `z`. |
| `Transform3D`  | Transformação 3D com `basis` (`Basis`) e `origin` (`Vector3`). |

### Tipos próprios da engine

| Tipo     | Descrição |
|----------|----------|
| `Color`  | Tipo de cor com campos `r`, `g`, `b` e `a`. Também pode ser acessado como `h`, `s` e `v` (matiz, saturação e valor). |
| `RID`    | Resource ID. Usado pelos servidores da engine para referenciar dados internos. |
| `Object` | Classe base para tudo que não é um tipo embutido (built-in). |

### Tipos de containers

| Tipo                  | Descrição |
|-----------------------|----------|
| `Array`               | Lista dinâmica de elementos de qualquer tipo (inclusive outros arrays/dictionaries). Indexado a partir de `0` e aceita índices negativos (`-1` = último). Passado por referência. <br><br>**Exemplo:**<br>`var arr = [1, 2, 3]`<br>`arr[-1] # 3`<br>`arr.append(4)` |
| `Array[Type]`         | Array tipado que garante o tipo dos elementos em tempo de execução e análise estática. Mais seguro e geralmente mais performático que `Array` puro. Não suporta tipos aninhados (`Array[Array[int]]`). <br><br>**Exemplo:**<br>`var a: Array[int]`<br>`var b: Array[Node]`<br><br>**Importante:** não é possível atribuir diretamente arrays de tipos diferentes (mesmo com herança). Use `assign()` para copiar:<br>`b.assign(a)` |
| `PackedArray`         | Arrays otimizados para performance e uso de memória. Mais rápidos para iterar/modificar e mais compactos, mas com menos métodos (ex: não tem `map`). Ideais para grandes volumes de dados. |
| `PackedByteArray`     | Array de bytes (`0–255`). |
| `PackedInt32Array`    | Array de inteiros de 32 bits. |
| `PackedInt64Array`    | Array de inteiros de 64 bits. |
| `PackedFloat32Array`  | Array de floats de 32 bits. |
| `PackedFloat64Array`  | Array de floats de 64 bits. |
| `PackedStringArray`   | Array de `String`. |
| `PackedVector2Array`  | Array de `Vector2`. |
| `PackedVector3Array`  | Array de `Vector3`. |
| `PackedVector4Array`  | Array de `Vector4`. |
| `PackedColorArray`    | Array de `Color`. |
| `Dictionary`          | Estrutura chave → valor com chaves únicas. Suporta múltiplos tipos como chave. Pode usar sintaxe estilo JSON ou estilo Lua. <br><br>**Exemplo:**<br>`var d = {"key": 1, 2: "value"}`<br>`d["new"] = 10`<br>`d.key = 5` |
| `Dictionary[Key, Value]` | Dicionário tipado que valida tipos de chave e valor. Mais seguro e com suporte do analisador estático. <br><br>**Exemplo:**<br>`var d: Dictionary[String, int]`<br><br>**Limitação:** não suporta tipos aninhados (`Dictionary[String, Dictionary[...]]`). |

**Observações:**
  - `Array` e `Dictionary` são **passados por referência**.
  - Prefira `Array[Type]` e `Dictionary[Key, Value]` para mais segurança e clareza.
  - `PackedArray` vale a pena quando há **muitos elementos** (performance/memória).
  - Arrays não tipados (`Array`) são mais flexíveis, mas menos seguros.
  - `assign()` copia o conteúdo (não a referência).
  - Acesso com `[]` funciona também para propriedades de `Object`, mas pode gerar erro se não existir (`get()`/`set()` são mais seguros).
  - Métodos como `front()` e `back()` ainda retornam `Variant`, mesmo em arrays tipados.

### Sinais

Um sinal é uma mensagem que pode ser emitida por um objeto para aqueles que desejam ouvi-la. O tipo `signal` também pode ser usado para passar o emissor adiante. Isso significa que um signal não é só algo que você declara e conecta. Ele também é um tipo de valor, assim como `int`, `String`, etc. Ou seja, você pode guardar um sinal em uma variável.

### Callable

Obter um método/função como variável retorna um `callable`. Por exemplo, `var x = $Sprite2D.rotate` definirá o valor de `x` como um `callable`. Mais tarde, você pode chamá-la usando o comando `x.call(PI)`, por exemplo.

## Variáveis

Variáveis ​​podem existir como membros de classe ou locais de funções. Elas são criadas com a palavra-chave `var` e podem, opcionalmente, receber um valor na inicialização.

```python
var a    # sem especificar nada, o tipo da variável será 'null' por default
var b = 5
var c = 3.8
var d = b + c
```

### Variáveis tipadas

Variáveis ​​podem, opcionalmente, ter uma especificação de tipo. Quando um tipo é especificado, a variável será forçada a ter sempre esse mesmo tipo, e tentar atribuir um valor incompatível resultará em um erro. Os tipos são especificados na declaração da variável usando um símbolo de dois pontos (:) após o nome da variável, seguido pelo tipo.

```python
var a: int
var b: int = 5
```

Definir os tipos das variáveis deixa o teu código mais robusto e ajuda a própria engine a detectar erros mais facilmente. Outra vantagem de variáveis tipadas é que o editor é capaz de usar o autocomplete nelas. 

<p align="center">
	<img width="150" src="https://github.com/user-attachments/assets/47b2e766-c5f4-4902-9603-59449669bbab" />
	<img width="210" src="https://github.com/user-attachments/assets/f6e4419b-e2d6-4bd3-baa0-ea66d8fa1f85" />
</p>

Para descobrir/checar o tipo de uma variável, você pode usar a função `typeof()`. O retorno desta função será uma constante inteira. Cada valor corresponde a um tipo internamente. Caso você queira o nome do tipo em vez de um número, pode usar o comando `type_string(typeof())`.  Segue abaixo a tabela geral de conversões.

| Constante                      | Tipo                 |
| ------------------------------ | -------------------- |
| TYPE_NIL = 0                   | `null`               |
| TYPE_BOOL = 1                  | `bool`               |
| TYPE_INT = 2                   | `int`                |
| TYPE_FLOAT = 3                 | `float`              |
| TYPE_STRING = 4                | `String`             |
| TYPE_VECTOR2 = 5               | `Vector2`            |
| TYPE_VECTOR2I = 6              | `Vector2i`           |
| TYPE_RECT2 = 7                 | `Rect2`              |
| TYPE_RECT2I = 8                | `Rect2i`             |
| TYPE_VECTOR3 = 9               | `Vector3`            |
| TYPE_VECTOR3I = 10             | `Vector3i`           |
| TYPE_TRANSFORM2D = 11          | `Transform2D`        |
| TYPE_VECTOR4 = 12              | `Vector4`            |
| TYPE_VECTOR4I = 13             | `Vector4i`           |
| TYPE_PLANE = 14                | `Plane`              |
| TYPE_QUATERNION = 15           | `Quaternion`         |
| TYPE_AABB = 16                 | `AABB`               |
| TYPE_BASIS = 17                | `Basis`              |
| TYPE_TRANSFORM3D = 18          | `Transform3D`        |
| TYPE_PROJECTION = 19           | `Projection`         |
| TYPE_COLOR = 20                | `Color`              |
| TYPE_STRING_NAME = 21          | `StringName`         |
| TYPE_NODE_PATH = 22            | `NodePath`           |
| TYPE_RID = 23                  | `RID`                |
| TYPE_OBJECT = 24               | `Object`             |
| TYPE_CALLABLE = 25             | `Callable`           |
| TYPE_SIGNAL = 26               | `Signal`             |
| TYPE_DICTIONARY = 27           | `Dictionary`         |
| TYPE_ARRAY = 28                | `Array`              |
| TYPE_PACKED_BYTE_ARRAY = 29    | `PackedByteArray`    |
| TYPE_PACKED_INT32_ARRAY = 30   | `PackedInt32Array`   |
| TYPE_PACKED_INT64_ARRAY = 31   | `PackedInt64Array`   |
| TYPE_PACKED_FLOAT32_ARRAY = 32 | `PackedFloat32Array` |
| TYPE_PACKED_FLOAT64_ARRAY = 33 | `PackedFloat64Array` |
| TYPE_PACKED_STRING_ARRAY = 34  | `PackedStringArray`  |
| TYPE_PACKED_VECTOR2_ARRAY = 35 | `PackedVector2Array` |
| TYPE_PACKED_VECTOR3_ARRAY = 36 | `PackedVector3Array` |
| TYPE_PACKED_COLOR_ARRAY = 37   | `PackedColorArray`   |
| TYPE_PACKED_VECTOR4_ARRAY = 38 | `PackedVector4Array` |
| TYPE_MAX = 39                  | —                    |

Você pode deixar a engine inferir o tipo com `:=`. Deste modo, você evita ter que explicitar o tipo da variável a todo instante e delega isso para a engine. Recomendo só fazer isso quando explicitar o tipo é redundante. Por exemplo, você pode definir `var direction: Vector3 = Vector3(1, 2, 3)`, mas isso é redundante pois o tipo do vetor definido é óbvio e a engine consegue inferir facilmente. Neste caso vale a pena utilizar `var direction := Vector3(1, 2, 3)`.

No exemplo anterior, se você definir `var direction = Vector3(1, 2, 3)`, sem explicitar o tipo nem pedir para a engine inferir, a variável será do tipo `Variant`. Isso basicamente significa que ela é flexível e pode ser de qualquer tipo a qualquer instante. Você ganha mais dinâmica, mas perde performance. O exemplo abaixo deixa isso claro. Sem definir um tipo para a variável, ela pode ser alterada à vontade. Porém, assim que ela possui um tipo, a engine acusa erro ao tentar atribuir um valor de outro tipo para a variável.

<p align="center">
	<img width="450" src="https://github.com/user-attachments/assets/811a6da0-c9a4-45d4-b3a6-aa79b91092c2" />
</p>

### Variáveis estáticas

Variáveis de uma classe podem ser declaradas como *estáticas*. Isso é simples, como mostra o exemplo abaixo.

```python
# person.gd
class_name Person

static var max_id = 0

var id
var name

func _init(p_name):
	   max_id += 1
	   id = max_id
	   name = p_name
```

Neste exemplo, a variável `max_id` é uma variável estática da classe. Isso significa que ela pertence à classe e não à instâncias da classe. Ou seja, esta mesma variável é compartilhada entre todas as instâncias da classe. Se ela for alterada, todas as instâncias "saberão" disso.

### Casting

*Casting* é o ato de trocar o tipo de uma variável no código. Se for necessário forçar um valor a ser de um determinado tipo, você pode usar o operador de conversão `as`. A conversão entre tipos para um objeto resultará no mesmo objeto se o valor for do mesmo tipo ou um subtipo do tipo de conversão. Por exemplo, suponha que você declarou uma variável desta maneira: `var my_node2D: Node2D`. Depois disso, o comando `my_node2D = $Sprite2D as Node2D` funciona porque `$Sprite2D` é um subtipo do tipo `Node2D`. 

No caso de tipo básicos, a engine sempre vai tentar converter mesmo que não seja subtipo. Por exemplo, declarar `var my_int: int` e depois fazer `my_int = "123" as int`. Porém, algo como `my_int = Vector2() as int` não tem como funcionar.

## Constantes

Constantes são valores declarados que não podem ser alterados depois. Os exemplos abaixo mostram como declarar constantes.

```python
const A = 5
const AA: int = 5
const B = Vector2(20, 20)
const C = 10 + 20 
const D = Vector2(20, 30).x 
const E = [1, 2, 3, 4][0]
const F = sin(20) 
```

> PS: Declarações como `const G = x + 20` são inválidas, a menos que `x` também seja uma constante.

## Enum

Enums são basicamente uma abreviação para constantes e são bastante úteis se você quiser constantes que sejam números inteiros consecutivos. Por exemplo, `enum {TILE_BRICK, TILE_FLOOR, TILE_SPIKE, TILE_TELEPORT}` define um `enum`, em que cada variável é um `int`, começando em $0$ e seguindo sequencialmente. Essa definição é equivalente à mostrada abaixo.

```python
const TILE_BRICK = 0
const TILE_FLOOR = 1
const TILE_SPIKE = 2
const TILE_TELEPORT = 3
```

Se você nomear um `enum`, ele será considerado um dicionário constante, em que as chaves são os nomes que você definiu. Por exemplo, você pode definir `enum Tiles {TILE_BRICK, TILE_FLOOR, TILE_SPIKE, TILE_TELEPORT}`. As chaves não são armazenadas como constantes e o acesso aos valores deve ser feita com a sintaxe `Tiles.TILE_BRICK`, por exemplo.

## Funções

A definição de funções é bastante semelhante a Python. A maior diferença é o uso de `func` em vez de `def` para inicializar a função. Assim como em Python, o `return` não é obrigatório (ma caso não tenha, fica implícito que a função retorna `null`). 

### Parâmetros opcionais

Você pode incluir parâmetros opcionais na função, basta que eles sejam atribuídos a algum valor logo na definição da função. O exemplo abaixo ilustra isso. O parâmetro `a_required` é obrigatório passar para a função, mas `b_optional` e `c_optional` são opcionais.

```python
func my_function(a_required, b_optional=10, c_optional=42):
	pass
```

### Definindo os tipos das entradas e saídas

Você também pode definir o tipo da entrada que a função espera.

```python
func my_function(a: int, b: String):
	pass
```

É possível definir o tipo da saída, para isso deve-se utilizar a seta `->`, apontando para o tipo de variável da saída. Caso o tipo seja diferente de `void`, é obrigatório usar o `return` com a saída sempre do tipo esperado.

```python
func my_int_function() -> int:
	return 0
```

### Declarando um callable a partir de uma função

Se você referenciar uma função sem as entradas, isso automaticamente gera um `callable`. O exemplo abaixo deve printar a sequência 1, 2, 3, 4 assim que o jogo é executado.

```python
func _ready() -> void:
	var my_array = [0, 1, 2, 3]

	for i in my_array:
		print(map(i, add1))
		
func add1(value: int) -> int:
	return value + 1;

func map(item: int, function: Callable) -> int:
	var result = function.call(item)
	return result
```

### Funções estáticas

Assim como temos variáveis estáticas em classes, também existem as *funções estáticas*. Estas funções não devem estar dentro de classes internas a uma classe, pois elas servem para referenciar apenas à classe geral e suas variáveis estáticas. Deste modo, estas funções não são acessíveis por instâncias, e elas mesmas não são capazes de acessar variáveis de instâncias. Para definir uma variável estática, basta utilizar a sintaxe `static func` na declaração dela. 

Se você quiser acessar métodos da classe diretamente, sem criar instâncias, faça isso com funções estáticas. 

### Funções variádicas

Funções também podem ter um número arbitrário de elementos (neste caso ela é chamada de "variadic function", ou "função variádica"). Coloque `...args` (em geral, `...{qualquer_nome}` funciona, em que *qualquer_nome* pode ser o nome que você quiser) como último elemento da sua função. Desta maneira, ela vai ler os parâmetros comuns de entrada e colocar todo o restante no array `args`. O exemplo abaixo deixa claro como isso funciona.

```python
func my_func(a, b = 0, ...args):
	prints(a, b, args)

func _ready():
	my_func(1)             # 1 0 []
	my_func(1, 2)          # 1 2 []
	my_func(1, 2, 3)       # 1 2 [3]
	my_func(1, 2, 3, 4)    # 1 2 [3, 4]
	my_func(1, 2, 3, 4, 5) # 1 2 [3, 4, 5]
```

## self

O `self` serve para referenciar a instância atual que está sendo usada no script. Existem algumas aplicações para isso, vou citar uma aqui.

Suponha que você definiu uma variável da instância no seu script e depois usou o mesmo nome de variável para uma variável local dentro de uma função. Isso por si só não é recomendado e a engine vai dar alerta de *shadowing*. No entanto, não vai dar erro e a função funcionará normalmente. Esse aviso é para o próprio desenvolvedor não se enrolar com nome repetido sendo usado para coisas distintas no mesmo script. Você pode chamar a função `update` quando quiser, com os valores que quiser, e isso não vai afetar a variável da instância `x`, que é igual a 1.

```python
var x = 1

func update(x):
    x = x + 5
    return x
```

Caso você queira que a variável da instância seja usada dentro da função, deve usar o `self`. Neste caso, a nova função abaixo sempre irá alterar a variável da instância.

```python
var x = 1

func update(x):
    self.x = x + 5
    return self.x
```

## Controle de fluxo

### if/else/elif

Estes três são bastante conhecidos em linguagem de programação, não acho que é necessário explicar nada neste caso. Menos comum é o if ternário, esse merece alguma explicação. Você pode definir uma variável a parte de um if-else comum como o mostrado abaixo.

```python
if x > 10:
    var y = true
else:
    var y = false
```

Com o if ternário você consegue o mesmo resultado em uma única linha.

```python
var y = true if x > 10 else false
```

O if ternário também permite lidar com múltiplas condicionais.

```python
var fruit = "apple" if x == 2 else "pear" if x == 1	else "banana" if x == 0	else "orange"
```

Se preferir, você pode quebrar cada condição em uma linha, usando parênteses ou o `\`. Os dois modos abaixo são equivalentes ao que acabamos de ver.

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

### while e for

O `while` também é simples e bastante conhecido, então não vou falar nada a respeito. O `for` possui algumas particularidades, acredito que o resumo abaixo seja o suficiente para mostrar como ele funciona na maioria dos casos.

```python
for x in [5, 7, 11]:
	statement # Loop executa 3 vezes com 'x' sendo 5, depois 7 e por fim 11.

var names = ["John", "Marta", "Samantha", "Jimmy"]
for name: String in names: # Variável do loop tipada.
	print(name) # Imprime o conteúdo de 'name'.

var dict = {"a": 0, "b": 1, "c": 2}
for i in dict:
	print(dict[i]) # Imprime 0, depois 1 e depois 2.

for i in range(3):
	statement # Similar a [0, 1, 2], mas sem alocar um array.

for i in range(1, 3):
	statement # Similar a [1, 2], mas sem alocar um array.

for i in range(2, 8, 2):
	statement # Similar a [2, 4, 6], mas sem alocar um array.

for i in range(8, 2, -2):
	statement # Similar a [8, 6, 4], mas sem alocar um array.

for c in "Hello":
	print(c) # Itera por todos os caracteres de uma string, imprime cada letra em uma nova linha.

for i in 3:
	statement # Similar a range(3).

for i in 2.2:
	statement # Similar a range(ceil(2.2)).
```

### match

O `match` é como se fosse uma sequência de if-else a partir do valor de uma variável/expressão, mas com uma sintaxe adequada para esta situação e com muito mais potencial para lidar com casos complexos. Abaixo segue um exemplo básico de aplicação.

```python
match x:
	1:
		print("We are number one!")
	2:
		print("Two are better than one!")
	"test":
		print("Oh snap! It's a string!")
```

O código acima é equivalente a esse:

```python
if x == 1:
	print("We are number one!")
elif x == 2:
    print("Two are better than one!")
elif x == "test":
	print("Oh snap! It's a string!")
```

> PS: O operador `match` é mais rigoroso em relação aos tipos do que o operador `==`. Por exemplo, $1$ não corresponderá a $1.0$. Tenha atenção com isso.

Não é necessário usar uma variável no `match`, você pode usar uma expressão que resulte em algum valor.

```python
match typeof(x):
	TYPE_FLOAT:
		print("float")
	TYPE_STRING:
		print("text")
	TYPE_ARRAY:
		print("array")
```

Você pode usar o underline como "coringa" ("wildcard" em inglês). Esse símbolo significa que qualquer coisa vai dar match se chegar ali.

```python
match x:
	1:
		print("It's one!")
	2:
		print("It's one times two!")
	_:
		print("It's not 1 or 2. I don't care to be honest.")
```

Você pode trocar o underline pela introdução de uma variável nova. Nesse caso, qualquer coisa var dar match também e vai atribuir o valor a essa variável. Se `x` for igual a 3 no exemplo abaixo, o match será na última condição, e a variável `new_var` será igual a 3 após a execução.

```python
match x:
	1:
		print("It's one!")
	2:
		print("It's one times two!")
	var new_var:
		print("It's not 1 or 2, it's ", new_var)
```

Também é possível usar arrays no `match`. Cada elemento do array é um padrão em si que precisa dar match individualmente. O comprimento do array é verificado primeiro, ele precisa ser do mesmo tamanho que o padrão, caso contrário, o padrão não corresponde. 

```python
match x:
	[]:
		print("Empty array")
	[1, 3, "test", null]:
		print("Very specific array")
	[var start, _, "test"]:
		print("First element is ", start, ", and the last is \"test\"")
	[42, ..]:
		print("Open ended array")
```

A lógica do `match` com dicionários é semelhante à dos arrays.

```python
match x:
	{}:
		print("Empty dict")
	{"name": "Dennis"}:
		print("The name is Dennis")
	{"name": "Dennis", "age": var age}:
		print("Dennis is ", age, " years old.")
	{"name", "age"}:
		print("Has a name and an age, but it's not Dennis :(")
	{"key": "godotisawesome", ..}:
		print("I only checked for one entry and ignored the rest")
```

Você também pode especificar vários padrões separados por vírgula. 

```python
match x:
	1, 2, 3:
		print("It's 1 - 3")
	"Sword", "Splash potion", "Fist":
		print("Yep, you've taken damage")
```

Uma "guarda de padrão" ("pattern guard" em inglês) é uma condição opcional que vem após a lista de padrões e permite fazer verificações adicionais antes de escolher um ramo do `match`. 

```python
match point:
	[0, 0]:
		print("Origin")
	[_, 0]:
		print("Point on X-axis")
	[0, _]:
		print("Point on Y-axis")
	[var x, var y] when y == x:
		print("Point on line y = x")
	[var x, var y] when y == -x:
		print("Point on line y = -x")
	[var x, var y]:
		print("Point (%s, %s)" % [x, y])
```

## Classes

### Classes sem nome

Todo script de Godot é considerado como uma classe. Se nenhum nome for dado à classe representando o script, ela será uma classe sem nome. Neste caso, você deve referenciar esta classe em outros scripts usando o caminho absoluto até ela. Considere a classe abaixo de exemplo.

<p align="center">
	<img width="400" src="https://github.com/user-attachments/assets/cb2ad07d-f5fa-4070-bad3-1da533a425ed" />
</p>

Agora considere um outro script em uma cena qualquer. O script desta cena pode herdar de `my_class.gd` usando a sintaxe conhecida `extends "res://my_class.gd"`. A partir daí, todos os métodos e atributos da classe herdada estarão disponíveis no script.

<p align="center">
	<img width="700" src="https://github.com/user-attachments/assets/966ec944-7f54-456e-bcb6-b2f44155d5b3" />
</p>

Também é possível obter o mesmo resultado utilizando as chamadas `load` e `new` da Godot.

<p align="center">
	<img width="750" src="https://github.com/user-attachments/assets/a9dda508-eb09-4485-82c7-4a9f1edeb4d9" />
</p>

> PS: Para criar uma instância de uma classe, usamos o método `new`. Para criar uma instância de uma cena, usamos o método `instantiate`. Para carregar uma classe (de um script) ou uma cena, ambas as funções `load` e `preload` podem ser usadas.

### Classes nomeadas

Se quiser que a sua classe tenha um nome, basta usar o comando `class_name {nome}` no topo do arquivo, substituindo *nome* pelo nome que quiser. Nesse último exemplo, vamos chamar a nossa classe de "amazing". Como classes nomeadas automaticamente se tornam globais no projeto, não é mais necessário usar nem `extends` nem `load`. Também é importante lembrar que classes nomeadas automaticamente podem ser encontradas pelo help do editor e passam a possuir a sua própria documentação. Isso foi explicado na seção de comentários.

<p align="center">
	<img width="400" src="https://github.com/user-attachments/assets/00305d8a-f652-4227-bfa3-ff670d83668c" />
	<img width="850" src="https://github.com/user-attachments/assets/73db02ee-8d38-464e-a958-9fd5c80fe3df" />
</p>

> PS: Este assunto foi brevemente abordado no projeto de [números complexos](https://github.com/felipebottega/Games/edit/gh-pages/Manual/2D/Rendering/Custom%20drawing%20in%202D%20-%20Complex%20Numbers/README.md#script-externo).

### Ícone

Além de poder nomear classes, também é possível associa-la a um ícone, que ficará visível no *FileSystem*. Para isso, basta inserir a anotação `@icon` no topo do script, com o caminho até o arquivo do ícone como argumento.

<p align="center">
	<img width="300" src="https://github.com/user-attachments/assets/174a07f4-d052-43b9-a79e-70f1f38edfe2" />
	<img width="210" src="https://github.com/user-attachments/assets/61f1b11e-eb69-4e8f-a568-0f5a48639c8d" />
</p>

### Herança de classes

Existem três maneiras de se herdar de uma classe.

```python
# Inherit/extend a globally available class.
extends SomeClass

# Inherit/extend a named class file.
extends "somefile.gd"

# Inherit/extend an inner class in another file.
extends "somefile.gd".SomeInnerClass
```

Para checar se um objeto herda de uma certa classe, você pode usar a sintaxe `is` para isso. Por exemplo, se uma instância se chama `my_instance` e você quer verificar se ele herda da classe `MyClass`, o comando `my_instance is MyClass` retorna um booleano indicando se ele herda ou não desta classe. 

### Construtor

O construtor de classe é a função nativa `_init`, que já foi abordada [bem no início](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Using%20signals/Signals%202#_init-vs-_ready) desta série de tutoriais. Naquela época, apenas o descrevemos como uma função que inicializa variáveis básicas de scripts antes de qualquer node entrar em cena. Esta inicialização de variáveis serve para criar instâncias com parâmetros, assim como é o `__init__` de Python. 

Abaixo, segue um exemplo em que definimos uma nova classe nomeada, `amazing2`. Neste caso ela possui um construtor para inicializar instâncias. Neste exemplo, o construtor exige uma variável inteira de entrada, é o parâmetro para inicializar uma instância. Quando a instância é inicializada com o comando `var my_class_instance = amazing2.new(100)`, a função `_init` é executada com este parâmetro. Isto ocorre antes de qualquer `_ready` na cena, a não ser que a instância seja criada explicitamente após o `_ready`.

<p align="center">
	<img width="300" src="https://github.com/user-attachments/assets/a7b67bc0-d234-4596-a60a-cc261d3a595b" />
	<img width="700" src="https://github.com/user-attachments/assets/985073eb-0376-4003-b1ba-43bd6558a393" />
</p>

### Classes internas

Todo arquivo de classe pode conter outras classes internas. Para criar uma, basta usar o comando `class {nome}`, em que *nome* é qualquer nome que você queira dar para a sua classe interna. No projeto de [números complexos](https://github.com/felipebottega/Games/edit/gh-pages/Manual/2D/Rendering/Custom%20drawing%20in%202D%20-%20Complex%20Numbers/README.md#script-externo) foi utilizada uma classe interna no arquivo. Abaixo, temos o trecho inicial do arquivo para relembrar.

```python
class_name ComplexLib  

class Complex:
	var re: float
	var im: float

	func _init(r: float, i: float):
		re = r
		im = i

	func add(other: Complex) -> Complex:
		return Complex.new(re + other.re, im + other.im)

	func sub(other: Complex) -> Complex:
		return Complex.new(re - other.re, im - other.im)

	func mul(other: Complex) -> Complex:
		return Complex.new(re * other.re - im * other.im, re * other.im + im * other.re)
```

Uma instância pode ser definida com o comando `var z = ComplexLib.Complex.new(1.0, 2.0)` por exemplo. Essa instância está associada ao número complexo $z = 1 + 2 \cdot i$. Dada uma outra instância deste classe interna, associada a outro número complexo $w = u + v \cdot i$, podemos obter a multiplicação $z \cdot w$ com o comando `z.mul(w)`, em que `var w = ComplexLib.Complex.new(u, v)`.

## setters e getters

As keywords `set` e `get` servem para fazer algo quando a variável é acessada ou alterar algo quando o valor da variável é alterado, respectivamente. Só é possível usar estas keywords em variáveis da instância, não serve para variáveis dentro de funções. 

No exemplo abaixo, o `get` diz que a variável `seconds` deve ser igual a `milliseconds / 1000` sempre que `seconds` for acessada. Se alguma computação intermediária a alterou, ela voltará "ao normal" assim que tentarem acessá-la (pode-se dizer que ela tem um vínculo com `milliseconds`). O `set` diz que `milliseconds` deve ser alterado para `milliseconds = value * 1000` sempre que o valor de `seconds` for alterado (alterado do valor anterior para o novo valor `value`).

```python
var milliseconds: int = 15000

var seconds: int:
	get:
		return milliseconds / 1000
	set(value):
		milliseconds = value * 1000
```

<p align="center">
	<img width="1100" src="https://github.com/user-attachments/assets/eac94ae4-190f-479b-b9b3-1d8ac1d54195" />
</p>

Um exemplo prático de aplicação foi visto [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Plugins/Running%20code%20in%20the%20editor#setter).

## Gerenciamento de memória 

No Godot, existem dois tipos principais de objetos na memória.

1) Objetos que a Godot limpa sozinho

São os objetos que herdam de `RefCounted`, como *resources*. Cada vez que alguém está usando o objeto, ele ganha um contador. Quando ninguém mais o está usando, esse contador vai para zero e a engine apaga o objeto automaticamente.

2) Objetos que você precisa apagar manualmente

São os objetos que não herdam de `RefCounted`, como `Node` e `Object` (e todos os filhos destes). Esses não somem sozinhos. Você precisa mandar apagar com `free` (apaga na hora) ou com o `queue_free` (apaga no final do frame). Sempre que você apagar um node, os filhos dele também são apagados junto automaticamente.

> PS: Alguns filhos do `Object` também são filhos do `RefCounted`, nestes caso é a Godot que limpa sozinha.

## Sinais

Os sinais são uma ferramenta para emitir mensagens de um objeto às quais outros objetos podem reagir. Para criar sinais personalizados via código, use a keyword `signal`. Toda a parte prática de sinais já foi vista na série de tutoriais [daqui](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Step%20by%20step/Using%20signals). Vale a pena dar uma revisitada.

### Exemplo prático de sinais

Digamos que queremos uma barra de vida na tela que reaja às mudanças com uma animação, mas queremos manter a interface do usuário separada do jogador em nossa árvore da cena. No script `character.gd` do personagem, definimos um sinal `health_changed` e o emitimos com `health_changed.emit()`, e de um node *Game* mais acima em nossa árvore da cena, o conectamos à barra de vida usando o método `health_changed.connect()`. 

```python
# character.gd

signal health_changed

func take_damage(amount):
	var old_health = health
	health -= amount

	health_changed.emit(old_health, health)
```

```python
# lifebar.gd

func _on_Character_health_changed(old_value, new_value):
	if old_value > new_value:
		progress_bar.modulate = Color.RED
	else:
		progress_bar.modulate = Color.GREEN

	progress_bar.animate(old_value, new_value)
```

No node *Game*, obtemos os nodes *Character* e *Lifebar*, e então conectamos o personagem, que emite o sinal, ao receptor, que neste caso é o node *Lifebar*. Isso permite que *Lifebar* reaja às mudanças sem precisar estar vinculada ao node *Character*.

```python
# game.gd

func _ready():
	var character_node = get_node('Character')
	var lifebar_node = get_node('UserInterface/Lifebar')

	character_node.health_changed.connect(lifebar_node._on_Character_health_changed)
```

> PS: A estrutura da criação de um sinal por código é sempre essa: `Node.metodo_do_sinal.connect(funcao_que_vai reagir_ao_sinal)`.  

É possível escrever os nomes dos argumentos opcionais entre parênteses após a definição do sinal. Esses argumentos aparecem *Inspector*. No entanto, você ainda pode emitir qualquer número de argumentos ao emitir sinais, cabe a você emitir os valores corretos.

```python
# Defining a signal that forwards two arguments.
signal health_changed(old_value, new_value)
```

<p align="center">
	<img width="350" src="https://github.com/user-attachments/assets/0ab07cca-830a-4353-a1dd-993a1b77c475" />
</p>

### Aguardando sinais ou corrotinas

Uma *corrotina* é basicamente uma rotina do programa que permite que a execução seja suspensa e retomada depois. A keyword `await` pode ser usada para criar corrotinas que aguardam a emissão de um sinal antes de continuar a execução.

Por exemplo, para interromper a execução até que o usuário pressione um botão, você pode fazer algo como o exemplo abaixo.

```python
func wait_confirmation():
	print("Prompting user")
	await $Button.button_up    # Waits for the button_up signal from Button node.
	print("User confirmed")
	return true
```

Nesse caso, o `wait_confirmation` se torna uma corrotina, o que significa que quem a chamou também precisa aguardar. 

```python
func request_confirmation():
	print("Will ask the user")
	var confirmed = await wait_confirmation()
	if confirmed:
		print("User confirmed")
	else:
		print("User cancelled")
```

Se você usar o comando `var confirmed = wait_confirmation()`, vai dar em erro. Chamar corrotinas sempre exige o uso do `await`. No entanto, o código abaixo funciona, pois ele não tenta receber a saída da corrotina. Caso a corrotina ainda esteja executando, o código abaixo simplesmente vai continuar sem esperar.

```python
func okay():
	wait_confirmation()
	print("This will be printed immediately, before the user press the button.")
```

Se você usar o `await` em uma função que não é uma corrotina, ele vai executar a função normalmente, como se não tivesse o `await`.

```python
func no_wait():
	var x = await get_five()
	print("This doesn't make this function a coroutine.")

func get_five():
	return 5
```

## Assert

A keyword `assert` pode ser usada para verificar condições em build debug. Os asserts são ignorados em builds que não sejam de debig. Isso significa que a expressão passada como argumento não será avaliada em um projeto exportado para produção. Devido a isso, os asserts não devem conter expressões que tenham efeitos colaterais. 

Como exemplo, o comando `assert(i == 0)` verifica se `i` é igual a 0. Se `i` não for igual a 0, ocorrerá um erro de assert. Opcionalmente, você passar uma mensagem de erro personalizada para ser exibida, como `assert(enemy_power < 256, "Enemy is too powerful!")`.
