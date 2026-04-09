# Resources

O conceito de "recurso" ("resource" em inglês) já foi abordado diversas vezes em tutoriais anteriores. Vou deixar abaixo a lista das vezes em que ele foi tratado anteriormente, para termos uma referência geral.

- **Onde entram os recursos na estrutura do projeto:** [Organização de um projeto](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Tools/Using%20TileMaps%20-%20Game#organiza%C3%A7%C3%A3o-de-um-projeto)
- **Recursos aplicados na linguagem do jogo:** [Assets associados a linguagens](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Internationalization/Internationalizing%20games#assets-associados-a-linguagens)
- **Recursos e RIDs:** [RIDs](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/Optimization%20using%20Servers#rids)
- **Recursos e @export:** [Resources](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20exported%20properties#resources)

*Recursos* em Godot são containers de dados. Eles não fazem nada por si só, em vez disso, os nodes usam os dados contidos nos recursos. Tudo o que a Godot salva ou carrega do disco é um recurso. Pode ser uma cena (um arquivo *.tscn* ou *.scn*), uma imagem, um script, etc.

Quando a engine carrega um recurso do disco, ele o carrega apenas uma vez. Se uma cópia desse recurso já estiver na memória, tentar carregá-lo novamente retornará a mesma cópia todas as vezes. Como os recursos contêm apenas dados, não há necessidade de duplicá-los.

Todo objeto em Godot, seja um node ou um recurso, pode exportar propriedades (usar o `@export`). Existem muitos tipos de propriedades, como String, inteiro, Vector2, etc., e qualquer um desses tipos pode se tornar um recurso. Isso significa que tanto nodes quanto recursos podem conter recursos como propriedades. A figura abaixo vem da [documentação oficial](), ela mostra como nodes podem conter recursos e como recursos podem contem outros recursos.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/231f9a0f-ef29-473a-a7fa-0a625788e782" />
</p>

## Carregando recursos

Vamos pegar o exemplo do sprite na figura acima. Ela diz que o node do `Sprite2D` contém um recurso de textura. Ao criar um node `Sprite2D`, podemos ver que a propriedade *Texture* de fato existe no *Inspector*. Geralmente o que fazemos é escolher um arquivo de imagem e inserir neste campo vazio, tudo pelo próprio editor. Em outras palavras, estamos adicionando um recurso de textura ao node `Sprite2D`.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/9d7b3276-7ce8-4871-826f-2f327e12aeee" />
</p>

É completamente possível adicionar recursos ao nodes através de código. Neste caso usaríamos o comando `var my_resource = load("res://my_texture.png")` e depois `$Sprite2D.texture = my_resource` (os nomes de variáveis e arquivos são fictícios). Na maioria dos exemplos, usamos o `load` ou `preload` para importar cenas, mas essas funções podem ser usadas para importar qualquer recurso.

## Make Unique e Local to Scene
