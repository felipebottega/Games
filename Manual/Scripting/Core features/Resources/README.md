# Resources

O conceito de "recurso" ("resource" em inglês) já foi abordado diversas vezes em tutoriais anteriores. Vou deixar abaixo a lista das vezes em que ele foi tratado anteriormente, para termos uma referência geral.

- **Onde entram os recursos na estrutura do projeto:** [Organização de um projeto](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Tools/Using%20TileMaps%20-%20Game#organiza%C3%A7%C3%A3o-de-um-projeto)
- **Recursos aplicados na linguagem do jogo:** [Assets associados a linguagens](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Internationalization/Internationalizing%20games#assets-associados-a-linguagens)
- **Recursos e RIDs:** [RIDs](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/Optimization%20using%20Servers#rids)
- **Recursos e @export:** [Resources](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20exported%20properties#resources)

*Recursos* em Godot são containers de dados. Eles não fazem nada por si só, em vez disso, os nodes usam os dados contidos nos recursos. Tudo o que a Godot salva ou carrega do disco é um recurso. Pode ser uma cena (um arquivo .tscn ou .scn), uma imagem, um script, etc.

Quando a engine carrega um recurso do disco, ele o carrega apenas uma vez. Se uma cópia desse recurso já estiver na memória, tentar carregá-lo novamente retornará a mesma cópia todas as vezes. Como os recursos contêm apenas dados, não há necessidade de duplicá-los.

Todo objeto em Godot, seja um node ou um recurso, pode exportar propriedades (usar o `@export`). Existem muitos tipos de propriedades, como String, inteiro, Vector2, etc., e qualquer um desses tipos pode se tornar um recurso. Isso significa que tanto nodes quanto recursos podem conter recursos como propriedades. 

> PS: Recursos usados como propriedade de outros recursos costumam ser chamados de "sub-recursos".

