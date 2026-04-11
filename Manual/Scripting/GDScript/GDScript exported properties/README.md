# GDScript exported properties

Já vimos o que faz a anotação `@export`, basicamente ela exporta uma propriedade para o *Inspector*. Desta maneira, você pode alterar parâmetros do jogo sem ter que ficar mexendo no código toda hora. Inclusive, as propriedades exportadas para o *Inspector* tem efeito imediato no jogo durante a execução. Ou seja, você pode alterar uma propriedade exportada e ver o efeito dela no jogo, sem precisar executar o jogo novamente, pois ela afeta o jogo no instante em que é alterada. Vale notar que o export também vale para [*Resource*](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#) e nodes.

`@export` não é só deixar uma propriedade aparecer no *Inspector*. Na Godot, exportar um membro faz duas coisas importantes ao mesmo tempo: salva o valor junto com a cena/recurso e cria um campo editável no *Inspector*. Além disso, esses valores também podem ser transferidos via RPCs. 

> PS: *RPC* significa *Remote Procedure Call*. A ideia é que você chama uma função como se fosse local, mas ela executa em outro lugar, normalmente em outro computador pela rede. Na Godot, RPC é usado principalmente em multiplayer.

A ideia deste tutorial é cobrir apenas os pontos que considerei mais interessantes. Para ver uma descrição mais completa, recomendo a leitura da [documentação oficial](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html).

## Caminhos

É totalmente possível usar um `@export` com tipo string para armazenar caminhos para arquivos e pastas. Porém, existem exports específicos para este tipo de coisa.

- **@export_file:** Caminhos para arquivos do projeto.
- **@export_dir:** Caminhos para pastas do projeto.
- **@export_global_file:** Caminhos absolutos para arquivos do projeto.
- **@export_global_dir:** Caminhos absolutos para pastas do projeto.

O interessante de utilizar estes exports é que você pode ir no *Inspector* e clicar no ícone de busca (no lado direito) para selecionar o arquivo/pasta desejado. Muito mais prático que ficar escrevendo.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/8522d5b0-7976-4a5c-a13d-037a0dd6c1e6" />
  <img width="440" src="https://github.com/user-attachments/assets/a3c3edd5-fdf7-429f-b8cc-3885650fee33" />
</p>

## Ranges

Também possível que os parâmetros do export variem com sliders ou passos incrementais.

- **@export_range(-20, 20) var i:** Gera um slider de inteiros no *Inspector*, indo de $-20$ a $20$.
- **@export_range(-10, 20, 0.2) var j:** Gera um slider de floats, indo de $-20$ a $20$, com incrementos de $0.2$. 
- **@export_range(0, 100000, 0.01, "exp") var exponential:** Gera um slider de floats no *Inspector*, variando em escala exponencial.
- **@export_range(0, 1000, 0.01, "hide_slider") var no_slider:** Omite o slider, de modo que você deve digitar o valor.
- **@export_range(0, 100, 1, "suffix:meters") var m:** Gera um slider com label.
- **@export_range(0, 360, 0.1, "radians_as_degrees") var angle:** Gera um slider com label de grau $^\circ$, específico para ângulos.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/e0f42511-0a05-462b-8839-5e836128e588" />
</p>

> PS: Se você especificar o tipo `int` (ex. `@export_range(-20, 20) var i: int`), o parâmetro passa a usar setinha de incrementos em vez de slider.

## Cores

O export de cores é normal, basta indicar o tipo `Color`. Com isso, a paleta de cores fica disponível no *Inspector*. Caso não queira que o *alpha* seja customizável, você pode usar `@export_color_no_alpha`.

## Nodes

O export de nodes também é normal, basta indicar o tipo de node que quer. Com isso, é possível adicionar nodes da cena no *Inspector* (apenas aceita nodes da cena). Vale notar também que o parâmetro só aceita nodes que sejam do tipo especificado ou filhos deste. Por exemplo, `@export var node: Node` aceita qualquer node da cena, enquanto que `@export var some_button: Button` só vai aceitar node do tipo `Button` ou filhos deste (não é filho na árvore de cena, mas filho como estrutura de classe).

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/e3dcf2d1-99ee-4b69-a298-c6efcca37950" />
</p>

## Resources

Com o export `@export var resource: Resource`, você pode arrastar e soltar um arquivo de recurso do *FileSystem* para o campo correspondente no *Inspector*. No entanto, abrir o menu dropdown desta propriedade do *Inspector* pode resultar em uma lista extremamente longa de classes que podem ser criadas (já que o tipo *Resource* é qualquer recurso). É possível ser mais específico com o tipo de recurso a ser utilizado. Por exemplo você pode usar `@export var resource: AnimationNode` para ser mais específico.

## Enums

Você utiliza a anotação `@export_enum` para exportar um `Enum` para o *Inspector*. Por exemplo, o comando `@export_enum("WARRIOR", "MAGICIAN", "THIEF") var character_class = "THIEF"` cria o respectivo `Enum`, em que `WARRIOR = 0`, `MAGICIAN = 1`, `THIEF = 2`. O parâmetro que receberá estes valores é o `character_class`, que será inicializado como `THIEF`, pois colocamos o igual ao fim do comando do export.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/47a36103-f899-4598-8933-adb5f70c6f30" />
</p>

> PS: Colocar a anotação igual a algum valor na sua declaração (fizemos acima) fará com que aquele seja o valor inicial no *Inspector*. Porém, tem que tomar cuidado pois às vezes ele altera o modo de intratividade no *Inspector*. Só testando para saber.

## Arrays

É possível exportar arrays, mas devem ser valores constantes. Por exemplo `@export var a = [1, 2, 3]` funciona, mas `@export var a = [1, 2, x]` não funciona, mesmo que `x` tenha um valor  definido. Também é possível não inserir nenhum valor. Neste caso ele será inicializado como `null`. Por exemplo, `@export var b: Array` funciona. Você também definir o tipo de array a ser exportado, por exemplo, `@export var c: Array[int] = [1, 2, 3]` e `@export var d: Array[PackedScene]` funcionam. Por fim, você também pode exportar [`PackedArray`](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#tipos-de-containers), mas ele deve ser inicializado vazio, por exemplo, `@export var e = PackedVector3Array()`.

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/e008eb7a-ab10-485e-aefa-6d0ff4200017" />
</p>
