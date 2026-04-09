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

Para explicar essas duas funcionalidades, vamos considerar o exemplo de uma cena onde temos um `StaticBody2D` chamado *Blocks*. A ideia é que isso será inserido em uma cena de jogo depois. O corpo possui um `Sprite2D` e um `CollisionShape2D` retangular, algo comum.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/a1bcbd4f-57db-4379-bec2-8a8060219bfb" />
</p>

Colocamos dois destes objetos na cena, como você pode ver na figura abaixo.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/c227b5bb-3f6e-48ce-bbf5-b2ce61c624da" />
</p>

Se você voltar para a cena *Blocks* e clicar no campo *Shape* do `CollisionShape2D` no *Inspector*, os campos abaixo vão aparecer. O fato de ter um campo *Resource* associado ao `CollisionShape2D` significa que este node possui um recurso, que é o shape de colisão retangular. Você pode até clicar no campo *Resources* para ver algumas propriedades associadas ao recurso.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/cbc33964-7ac3-4ae7-b6ae-07e8a2bcd603" />
</p>

Em geral, vamos evitar alterar o *Path*. A propriedade *Name* é puramente estético, não faz mal alterar mas também não importa muito. A propriedade *Local to Scene* é a única que nos importa de verdade. Como comentamos antes, a engine carrega um recurso uma única vez, não faz duplicatas. Isso significa que os dois *Blocks* instanciados na cena principal estão referenciando o mesmo recurso. Como consequência disso, alterar qualquer um altera todos os outros imediatamente, seja alterar algum instanciado ou alterar o original.

https://github.com/user-attachments/assets/dd43b99a-077a-4d52-8011-1240c90e7c7e



