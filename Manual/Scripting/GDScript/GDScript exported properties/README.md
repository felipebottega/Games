# GDScript exported properties

Já vimos o que faz a anotação `@export`, basicamente ela expota uma propriedade para o *Inspector*. Desta maneira, você pode alterar parâmetros do jogo sem ter que ficar mexendo no código toda hora. Inclusive, as propriedades exportadas para o *Inspector* tem efeito imediato no jogo durante a execução. Ou seja, você pode alterar uma propriedade exportada e ver o efeito dela no jogo, sem precisar executar o jogo novamente, pois ela afeta o jogo no instante em que é alterada. Vale notar que o export também vale para [*Resource*](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#) e nodes.

`@export` não é só deixar uma propriedade aparecer no *Inspector*. Na Godot, exportar um membro faz duas coisas importantes ao mesmo tempo: salva o valor junto com a cena/recurso e cria um campo editável no *Inspector*. Além disso, esses valores também podem ser transferidos via RPCs. Então o tutorial precisa cobrir bastante coisa, porque isso afeta persistência, edição no editor e comunicação em rede.

> PS: *RPC* significa *Remote Procedure Call*. A ideia é que você chama uma função como se fosse local, mas ela executa em outro lugar, normalmente em outro computador pela rede. Na Godot, RPC é usado principalmente em multiplayer.

A ideia deste tutorial é cobrir apenas os pontos que considerei mais interessantes. Para ver uma descrição mais completa, recomendo a leitura da [documentação oficial](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html).

## Caminhos

É totalmente possível usar um `@export` com tipo string para armazenar caminhos para arquivos e pastas. Porém, existem exports específicos para este tipo de coisa.

- **@export_file:** Caminhos para arquivos do projeto.
- **@export_dir:** Caminhos para pastas do projeto.
- **@export_global_file:** Caminhos absolutos para arquivos do projeto.
- **@export_global_dir:** Caminhos absolutos para pastas do projeto.

O interessante de utilizar estes exports é que você pode ir no *Inspector* e licar no ícone de busca (no lado direito) para selecionar o arquivo/pasta desejado. Muito mais prático que ficar escrevendo no código.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/8522d5b0-7976-4a5c-a13d-037a0dd6c1e6" />
  <img width="440" src="https://github.com/user-attachments/assets/a3c3edd5-fdf7-429f-b8cc-3885650fee33" />
</p>

