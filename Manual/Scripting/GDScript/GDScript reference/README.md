# GDScript reference

Todo conteúdo deste tópico já está muito bem documentado no [site oficial](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html), mas mesmo assim vou replicar o conteúdo aqui, no meu estilo.

## Keywords

*Keywords* são palavras reservadas da linguagem. Elas não podem ser declaradas como variáveis (ou funções, classes, etc.) novas. Devem ser utilizadas com o propósito original delas. 

| Keyword | Descrição |
|--------------|-----------|
| if           | Veja if/else/elif. |
| elif         | Veja if/else/elif. |
| else         | Veja if/else/elif. |
| for          | Veja for. |
| while        | Veja while. |
| match        | Veja match. |
| when         | Usado por pattern guards em instruções match. |
| break        | Encerra a execução do loop for ou while atual. |
| continue     | Pula imediatamente para a próxima iteração do loop for ou while. |
| pass         | Usado quando uma instrução é exigida sintaticamente, mas não se deseja executar código (ex: funções vazias). |
| return       | Retorna um valor de uma função. |
| class        | Define uma classe interna. Veja Classes internas. |
| class_name   | Define o script como uma classe globalmente acessível com o nome especificado. Veja Registro de classes nomeadas. |
| extends      | Define qual classe será estendida pela classe atual. |
| is           | Testa se uma variável estende uma determinada classe ou é de um tipo embutido específico. |
| in           | Testa se um valor está contido em uma string, array, range, dicionário ou nó. Quando usado com for, itera sobre eles em vez de testar. |
| as           | Converte o valor para um tipo específico, se possível. |
| self         | Refere-se à instância atual da classe. Veja self. |
| super        | Resolve o escopo do método da classe pai. Veja Herança. |
| signal       | Define um sinal. Veja Sinais. |
| func         | Define uma função. Veja Funções. |
| static       | Define uma função estática ou uma variável membro estática. |
| const        | Define uma constante. Veja Constantes. |
| enum         | Define um enum. Veja Enums. |
| var          | Define uma variável. Veja Variáveis. |
| breakpoint   | Auxiliar do editor para pontos de parada (debug). Diferente dos breakpoints criados clicando na margem, este é armazenado no script, tornando-o persistente entre máquinas com controle de versão. |
| preload      | Pré-carrega uma classe ou variável. Veja Classes como recursos. |
| await        | Aguarda um sinal ou uma corrotina terminar. Veja Aguardando sinais ou co-rotinas. |
| assert       | Verifica uma condição e registra erro se falhar. Ignorado em builds não-debug. Veja assert. |
| void         | Usado para indicar que uma função não retorna valor. |
| PI           | Constante PI. |
| TAU          | Constante TAU. |
| INF          | Constante de infinito. Usada para comparações e como resultado de cálculos. |
| NAN          | Constante NAN (não é um número). Usada como resultado impossível de cálculos. |

## Operadores

| Operador | Descrição |
|----------|-----------|
| ( ) | Parênteses não são exatamente um operador, mas permitem definir explicitamente a precedência de uma operação. |
| x[index] | Acesso por índice. |
| x.attribute | Referência a atributo. |
| foo() | Chamada de função. |
| await x | Aguarda sinais ou co-rotinas. |
| x is Node / x is not Node | Verificação de tipo. Veja também a função is_instance_of(). |
| x ** y | Potência. Multiplica x por ele mesmo y vezes, similar à função pow(). |
| ~x | NOT bit a bit. |
| +x / -x | Identidade / Negação. |
| x * y / x / y / x % y | Multiplicação / Divisão / Resto. O operador % também é usado para formatação de strings. |
| x + y / x - y | Adição (ou concatenação) / Subtração. |
| x << y / x >> y | Deslocamento de bits. |
| x & y | AND bit a bit. |
| x ^ y | XOR bit a bit. |
| x \| y | OR bit a bit. |
| x == y / x != y / x < y / x > y / x <= y / x >= y | Comparação. |
| x in y / x not in y | Verificação de pertencimento. |
| not x / !x | NOT booleano e seu alias não recomendado. |
| x and y / x && y | AND booleano e seu alias não recomendado. |
| x or y / x \|\| y | OR booleano e seu alias não recomendado. |
| true_expr if cond else false_expr | If/else ternário. |
| x as Node | Conversão de tipo (cast). |
| x = y / x += y / x -= y / x *= y / x /= y / x **= y / x %= y / x &= y / x \|= y / x ^= y / x <<= y / x >>= y | Atribuição. Não é possível usar operadores de atribuição dentro de uma expressão. |

O comportamento de alguns operadores pode ser diferente do que você espera:
 - No operador `/`, se ambos os forem do tipo `int`, então será realizada divisão inteira em vez de fracionária. Por exemplo, `5 / 2 == 2`, e não `2.5`. Se isso não for desejado, use pelo menos um literal `float (x / 2.0)` ou faça um cast `float(x) / y`.
 - O operador `%` está disponível apenas para `int`. Para float, use a função `fmod()`.
 - Os operadores `==` e `!=` às vezes permitem comparar valores de tipos diferentes (por exemplo, `1 == 1.0` é true), mas em outros casos isso pode causar erro em tempo de execução. Se você não tiver certeza sobre os tipos dos elementos, pode usar a função `is_same()` (mas note que ela é mais rigorosa quanto a tipos e referências). Para comparar float, use as funções `is_equal_approx()` e `is_zero_approx()`.
