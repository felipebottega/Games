# Nodes and scene instances

Neste tutorial, veremos como obter nodes, criar nodes, adicioná-los como filhos e instanciar cenas a partir do código. Outros tutoriais relacionados a este aqui são os seguintes: [Add Child](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Add%20Child), [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading) e [GDScript reference](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#classes-sem-nome).

## Obtendo nodes

## Instanciando cenas

Considere as cenas como templates a partir dos quais você pode criar quantas cópias desejar. Cada cópia é chamada de uma "instância" da cena. Esse processo ocorre em dois passos:

1. Carregar a cena do disco local.
2. Criar uma instância do recurso `PackedScene` carregado (toda cena carregada é do tipo `PackedScene`).

O passo 1 é feito com o comand `var scene = load("res://my_scene.tscn")` ou `var scene = preload("res://my_scene.tscn")`. A `load` carrega a cena dinamicamente durante a execução do código, enquanto que a `preload` carrega a cena uma única vez durante a compilação do código. Cada um tem suas vantagens e desvantagens. Falamos em detalhe sobre estas chamadas no tutorial [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading).

Após o passo 1, a variável `scene` é um recurso de cena compactado, não um node. Para criar o node propriamente dito, você precisa do método `PackedScene.instantiate()`. Ele retorna uma árvore de nodes que você pode usar como filho do node que fez a chamada pelo script. O comando `var instance = scene.instantiate()` cria esta árvore de nodes, e o comando `add_child(instance)` adiciona está árvore como filho do node que fez a chamada.

## Editable Children e Make Local
