# GDScript reference

Todo conteúdo deste tópico já está muito bem documentado no [site oficial](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html), mas mesmo assim vou replicar o conteúdo aqui, no meu estilo.

## Keywords

*Keywords* são palavras reservadas da linguagem. Elas não podem ser declaradas como variáveis (ou funções, classes, etc.) novas. Devem ser utilizadas com o propósito original delas. 

| Keyword     | Descrição |
|------------|------------|
| if         | See if/else/elif. |
| elif       | See if/else/elif. |
| else       | See if/else/elif. |
| for        | See for. |
| while      | See while. |
| match      | See match. |
| when       | Used by pattern guards in match statements. |
| break      | Exits the execution of the current for or while loop. |
| continue   | Immediately skips to the next iteration of the for or while loop. |
| pass       | Used where a statement is required syntactically but execution of code is undesired, e.g. in empty functions. |
| return     | Returns a value from a function. |
| class      | Defines an inner class. See Inner classes. |
| class_name | Defines the script as a globally accessible class with the specified name. See Registering named classes. |
| extends    | Defines what class to extend with the current class. |
| is         | Tests whether a variable extends a given class, or is of a given built-in type. |
| in         | Tests whether a value is within a string, array, range, dictionary, or node. When used with for, it iterates through them instead of testing. |
| as         | Cast the value to a given type if possible. |
| self       | Refers to current class instance. See self. |
| super      | Resolves the scope of the parent method. See Inheritance. |
| signal     | Defines a signal. See Signals. |
| func       | Defines a function. See Functions. |
| static     | Defines a static function or a static member variable. |
| const      | Defines a constant. See Constants. |
| enum       | Defines an enum. See Enums. |
| var        | Defines a variable. See Variables. |
| breakpoint | Editor helper for debugger breakpoints. Unlike breakpoints created by clicking in the gutter, breakpoint is stored in the script itself. This makes it persistent across different machines when using version control. |
| preload    | Preloads a class or variable. See Classes as resources. |
| await      | Waits for a signal or a coroutine to finish. See Awaiting signals or coroutines. |
| yield      | Previously used for coroutines. Kept as keyword for transition. |
| assert     | Asserts a condition, logs error on failure. Ignored in non-debug builds. See Assert keyword. |
| void       | Used to represent that a function does not return any value. |
| PI         | PI constant. |
| TAU        | TAU constant. |
| INF        | Infinity constant. Used for comparisons and as result of calculations. |
| NAN        | NAN (not a number) constant. Used as impossible result from calculations. |
