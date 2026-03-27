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
| `await`        | Aguarda um sinal ou uma corrotina terminar. Veja Aguardando sinais ou co-rotinas. |
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
| `await x` | Aguarda sinais ou co-rotinas. |
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
 - No operador `/`, se ambos os forem do tipo `int`, então será realizada divisão inteira em vez de fracionária. Por exemplo, `5 / 2 == 2`, e não `2.5`. Se isso não for desejado, use pelo menos um literal `float (x / 2.0)` ou faça um cast `float(x) / y`.
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

O uso de `##` faz com que o comentário tenha caráter de documentação, e vai aparecer como tooltip em outros lugares. Por exemplo, ao colocar este comentário especial sobre uma variável de uma script e depois utilizar esta variável em outro lugar (pode ser no mesmo script ou em outro), você poderá passar o mouse por cima e visualizar a descrição dela.

<p align="center">
 <img width="400" src="https://github.com/user-attachments/assets/c073a701-1344-4a8f-b920-093e8a74ecc9" />
 <img width="580" src="https://github.com/user-attachments/assets/a784a91e-ad9f-4b80-8e33-23e2bee7e1de" />
</p>

Isso também pode ser feito para funções.

<p align="center">
 <img width="200" src="https://github.com/user-attachments/assets/30eff345-cbdb-4721-bc1e-4cb8e651627f" />
 <img width="630" src="https://github.com/user-attachments/assets/d7ee59cd-0098-4531-bbcb-7edc6ef821eb" />
</p>

No caso de fazer isso para uma variável com a anotação `@export`, a descrição também aparece no *Inspector*.

<p align="center">
 <img width="330" src="https://github.com/user-attachments/assets/be2e7a5c-17f8-4b0d-8b7b-c35c935f0f02" />
 <img width="650" src="https://github.com/user-attachments/assets/fb4f2d02-feff-42c5-b208-511176307c7a" />
</p>

## Regiões de código

Uma região de código é um tipo de comentário especial também, mas nesse caso é necessário inserir dois comentários: um para dizer onde começa a região e o outro para dizer onde termina. Você coloca `#region` logo antes do trecho do código de interesse e coloca `#endregion` logo após o trecho. Abaixo temos um exemplo de como isso é feito. O interessante deste método é que você pode colapsar a região inteira ao clicar na setinha ao lado do `#region`. Isso é bastante útil para organizar visualmente código grandes.

<p align="center">
 <img width="200" src="https://github.com/user-attachments/assets/723a6f8f-6cec-4ea5-8774-c818a948999c" />
 <img width="300" src="https://github.com/user-attachments/assets/419f7e84-0125-42cb-b535-4fd96655fc82" />
</p>

Também é possível acrescentar uma descrição na linha do `#region`, muito útil para saber do que trata a região de código sem ter que abrí-la.

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
