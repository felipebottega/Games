# Nodes and scene instances

Neste tutorial, veremos como obter nodes, criar nodes, adicioná-los como filhos e instanciar cenas a partir do código. Outros tutoriais relacionados a este aqui são os seguintes: [Add Child](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Add%20Child), [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading) e [GDScript reference](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#classes-sem-nome).

## Obtendo nodes

Você pode obter uma referência a um node chamando o método nativo `get_node()` (como já foi explicado [antes](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Idle%20and%20Physics%20Processing#idle-and-physics-processing), estamos chamando de "nativos" os métodos da classe `Node`). Para que a chamada funcione, o node deve estar presente na árvore de cenas. Portanto, este método deve ser chamado no `_ready()` ou depois. 

Suponha que a sua cena está como mostrado abaixo. Se tiver um script anexado ao node `Node2D` e for necessário acessar o node `Blue` neste script, deve-se usar o comando `get_node("Blue")`. Por default, o `get_node()` sempre busca os filhos do node que executou o script. Uma maneira alternativa de fazer essa chamada é com o comando `$Blue`. 

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/d72b1b85-1fef-4870-bbea-8fe787a4f378" />
</p>

Agora suponha que a cena está como mostrado abaixo. Para acessar o node `Sprite2D` a partir do `Node2D`, você pode usar o comando `get_node("Blue/Sprite2D")` ou `$Blue/Sprite2D`. Isto é, você pode utilizar caminhos relativos na árvore para acessar os nodes.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/9032a982-d04f-44fa-a675-d9a370c8574a" />
</p>

Acabamos de ver como obter nodes para baixo na hierarquia de nodes. Também é possível obter nodes na hierarquia acima. Para explicar como funciona, considere a árvore de cenas abaixo. 

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/c8f958d8-c243-4cb7-a542-9ac9bfd29127" />
</p>

Se você usar `get_node(".")`, estará se referindo ao mesmo node que chamou o método. Isso é equivalente a `$"."`. Note que, no caso de caminhos relativos que usam pontos, a sintaxe com `$` precisa recorrer ao uso de aspas. Para acessar o node pai, é possível usar `get_node("..")` ou `$".."` ou ainda o método nativo `get_parent()`. Para obter o pai do pai, é necessário usar o caminho relativo `../..`, e assim sucessivamente. 

Colocamos abaixo um script associado ao node `Script2D`, filho do node `Blue`. Os comandos e seus respectivos outputs devem deixar evidente como funciona essa dinâmica. A partir desse conhecimento, você pode fazer coisas mais elaboradas, como acessar o `Sprite2D`, filho do node `Red`, a partir do comando `get_node("../../Red/Sprite2D")` ou `$"../../Red/Sprite2D"`. 

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/dd00549b-3e1d-478f-b8f5-3be834819392" />
</p> 

> PS: Note que o nível mais alto é um node oculto chamado *root*. Ele é um `Viewport` global, tudo no jogo fica abaixo dele, incluindo outras cenas e autoload. Você pode acessá-lo diretamente com `get_node("/root")` ou `get_tree().root`. Evitaremos acessá-lo neste tutorial.

⚠️ **Atenção:** É importante lembrar que o design/filosofia da Godot é que as cenas sejam templates independentes e reutilizáveis. A partir do momento que você começa a utilizar caminhos relativos que acessam elementos fora da cena, ela passa a ser menos flexível/reutilizável. 

## Criando nodes

Para criar um node a partir do código, deve-se utilizar o método `new()`. Primeiro escolhemos qual node queremos criar. O nome para referenciar ao node é o nome usual dele quando adicionamos nodes pelo editor. Por exemplo, ao escrever `Sprite2D` no código, estamos chamando a classe deste node (lembrando que todos os nodes nativos da engine são classes). Se quisermos uma instância desta classe na nossa cena, utilizamos o comando `Sprite2D.new()` e em seguida o `add_child()`. Por default, o novo node criado ficará no final da árvore. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/63305c5f-56da-4c90-9bd3-4c100a6a2640" />
</p>

> PS: Um ponto de atenção aqui é o fato de estarmos chamando o `Sprite2D` e suas instâncias de "node". Porém o primeiro é uma classe e o segundo é um objeto, uma instância da classe. Colocamos ambos no mesmo pacote chamado "node" mas é bom ter em mente que não são o mesmo tipo de estrutura.

Colocamos abaixo também os prints da classe e da instância, apenas para ficar clara a diferença.

<p align="center">
  <img width="320" src="https://github.com/user-attachments/assets/d97f7166-dfbc-470f-a33a-980900e21b93" />
  <img width="350" src="https://github.com/user-attachments/assets/47899a0d-81ad-44da-b8ec-1f9168ce476e" />
</p>

Por fim, é bom lembrar que você pode usar `sprite2d.free()` ou `sprite2d.queue_free()` para remover o node da cena. Estes métodos foram discutido [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/CPU/CPU%20optimization#cpu-optimization) e [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#gerenciamento-de-mem%C3%B3ria).

## Instanciando cenas

Considere as cenas como templates a partir dos quais você pode criar várias cópias independentes no jogo. Cada cópia é chamada de uma "instância" da cena. Esse processo ocorre em dois passos:

1. Carregar a cena do disco local (`.tscn`). A cena será carregada como recurso `PackedScene`.
2. Criar uma instância do recurso carregado.

O passo 1 é feito com o comando `var scene = load("res://my_scene.tscn")` ou `var scene = preload("res://my_scene.tscn")`. A `load` carrega a cena dinamicamente durante a execução do código, enquanto que a `preload` carrega a cena uma única vez durante a compilação do código. Cada um tem suas vantagens e desvantagens. Falamos em detalhe sobre estas chamadas no tutorial [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading).

Após o passo 1, a variável `scene` é um recurso de cena compactado (classe [`PackedScene`](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Add%20Child#packedscene) que representa um recurso), não um node. Para criar o node propriamente dito, você precisa do método `PackedScene.instantiate()`. Ele retorna uma árvore de nodes que você pode usar como filho do node que fez a chamada pelo script. O comando `var instance = scene.instantiate()` cria esta árvore de nodes, e o comando `add_child(instance)` adiciona esta árvore como filho do node que fez a chamada. 

## Editable Children e Make Local

Esse assunto já foi abordado [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Layers%20e%20Masks#editable-child-e-make-local), bem no início dos tutoriais. Vale a pena comparar o texto anterior com este.

Quando você instancia uma cena pelo editor, por padrão ela fica "encapsulada", isto é, você vê o node raiz, mas não vê os nodes dentro dela. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/0c29474d-800f-45ff-b028-829d50948e5b" />
</p>

Ao clicar com o botão direito do mouse na cena instanciada, algumas opções aparecem. Estamos interessados na *Editable Children* e *Make Local*.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/b76a25b1-a56b-4fb3-b8f6-3192c1800790" />
</p>

Ao ativar a opção *Editable Children*, ocorrem algumas mudanças. Você passa a poder mexer dentro da cena instanciada, mas ainda é o mesmo template:

- Você pode abrir a cena instanciada no editor.
- Pode editar os nodes internos.
- A cena continua sendo uma instância.
- Ainda depende do arquivo original (`.tscn`).

O opção *Make Local* é mais radical. Ao usar *Make Local*, você está dizendo que não quer mais saber do template, agora a cena é sua e você pode fazer o que quer quiser com ela:

- A instância deixa de depender da cena original.
- Vira uma estrutura totalmente local.
- Você pode modificar qualquer coisa sem afetar nem receber updates.

Abaixo segue uma tabela com as diferenças resumidas.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/216d3732-2b8c-4711-a366-e8177cbbcd6a" />
</p>
