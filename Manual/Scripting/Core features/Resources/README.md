# Resources

O conceito de "recurso" ("resource", em inglês) já foi abordado diversas vezes em tutoriais anteriores. Vou deixar abaixo a lista das vezes em que ele foi tratado anteriormente, para termos uma referência geral.

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

### Local to Scene

Se a opção *Local to Scene* não estiver habilitada, vimos acima como é o comportamento. O compartilhamento dos recursos é absoluto. Agora vamos supor que a opção está habilitada. Você vai notar uma diferença sutil de comportamento no editor: o recurso da cena instanciada não atualiza automaticamente quando o recurso é alterado pelo objeto original, mas assim que você salva a cena do original aí os recursos de todas as instâncias atualizam junto. A princípio, parece que o *Local to Scene* só adiou o inevitável. A diferença real é notada quando você habilita o [*Editable Children*](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Nodes%20and%20scene%20instances#editable-children-e-make-local) nas instâncias.

> PS: Apesar da instância com o *Editable Children* ter recurso independente, ela ainda é filha do objeto original e compartilha algumas propriedades com ele, como transformações, cores, visibilidade, entre outros. Tenha sempre atenção para não fazer confusão com isso.

Abaixo, temos a cena original do bloco à esquerda e os blocos A e B instanciados em outra cena. O original está com *Local to Scene* habilitado e apenas o bloco B está com o *Editable Children* habilitado. Ao alterar a colisão do bloco original e salvar a cena, apenas o bloco A reage à mudança. No entanto, apesar do shape de colisão do bloco B não ter alterado de forma, ele alterou de posição. Isso foi porque o centro do shape de colisão do original mudou de posição, e essa propriedade o bloco B ainda depende do original (como já comentamos em outras ocasiões, para ter total independência (transformações, recursos, tudo), habilite a opção *Make Local*).

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/db0bfd07-acc7-489b-9323-a80e53679f8c" />
</p>

> PS: A observação acima apenas vale quando você não alterou a propriedade do objeto instanciado. Caso esta propriedade tenha sido alterada, aparecerá o símbolo <img width="20" src="https://github.com/user-attachments/assets/1df980bb-e48e-4daf-b6aa-7eba4d4e2e8d" /> ao lado da propriedade
 no *Inspector*, e isso sinaliza que ela foi alterada. Neste caso, a propriedade não responde mais às alterações do original.

A opção *Local to Scene* brilha mesmo quando você cria instâncias por código. Nesse caso, é como se elas fossem *Editable Children* por default, então todas tem recursos independentes. Ocultamos os dois blocos A e B comentados acima e agoras criamos dois por código na Main. O bloco original ainda é o mesmo, com a opção *Local to Scene* habilitada. Apenas manipulamos a posição e escala dos blocos. Note que ambas os shapes de colisão se alteraram como pedimos. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/cf9fdb47-c333-4d7f-a8dc-5c19d226c350" />
</p>

Se tivéssemos executado este mesmo script sem *Local to Scene*, o primeiro comando `a.get_node("CollisionShape2D").shape.size = Vector2(64, 32)` de fato iria funcionar, alterando a shape para todos os blocos, pois o recurso está sendo compartilhado. Logo depois, o comando `b.get_node("CollisionShape2D").shape.size = Vector2(128, 20)` iria sobrescrever o comando anterior, e a shape de colisão de todo mundo seria essa.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/2eaf0a17-2e57-456e-8bea-963973016d20" />
</p>

### Make Unique

A opção *Make Unique* é mais simples, mais pontual e mais "radical". Esta opção você não habilita no node original, mas sim na instância. Ao habilitá-la, a engine cria uma cópia do recurso para a instância. Essa cópia é totalmente independente da original. Note que para acessar essa propriedade, você precisa primeiro ativar a *Editable Children* ou *Make Local*. A mesma observação sobre transformações e outras coisas continuam valendo. O node ainda é filho do original e reage à certas alterações dele.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/f2e365ce-f9fe-419c-9dd0-f5cd71d37b7a" />
</p>

É possível implementar o *Make Unique* por código. Para o caso do `CollisionShape2D` (exemplo), o comando `$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()` relpica o *Make Unique*. De maneira geral, `recurso = recurso.duplicate()` funciona para qualquer recurso, em que `recurso` é o nome do recurso. Se o recurso tiver sub-recursos dentro, use `recurso = recurso.duplicate(true)`. 

## Detectando recursos compartilhados

Se você estiver em dúvida se um recurso de um node está sendo compartilhado com o de um outro node, olhe para a propriedade *Path* do recurso. Se esta propriedade for igual para o recurso em dois nodes diferentes, então é o mesmo recurso, está sendo compartilhado. Caso seja diferente, são recursos independentes.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/d779ee0a-a641-4155-a557-cab6b3fe747b" />
</p>
