# Nodes and scene instances

Neste tutorial, veremos como obter nodes, criar nodes, adicioná-los como filhos e instanciar cenas a partir do código. Outros tutoriais relacionados a este aqui são os seguintes: [Add Child](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Add%20Child), [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading) e [GDScript reference](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#classes-sem-nome).

## Obtendo nodes

## Instanciando cenas

Considere as cenas como templates a partir dos quais você pode criar várias cópias independentes no jogo. Cada cópia é chamada de uma "instância" da cena. Esse processo ocorre em dois passos:

1. Carregar a cena do disco local (`.tscn`). A cena será carregada como recurso `PackedScene`.
2. Criar uma instância do recurso carregado.

O passo 1 é feito com o comando `var scene = load("res://my_scene.tscn")` ou `var scene = preload("res://my_scene.tscn")`. A `load` carrega a cena dinamicamente durante a execução do código, enquanto que a `preload` carrega a cena uma única vez durante a compilação do código. Cada um tem suas vantagens e desvantagens. Falamos em detalhe sobre estas chamadas no tutorial [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading).

Após o passo 1, a variável `scene` é um recurso de cena compactado (`PackedScene`), não um node. Para criar o node propriamente dito (na verdade, o node raiz da cena instanciada), você precisa do método `PackedScene.instantiate()`. Ele retorna uma árvore de nodes que você pode usar como filho do node que fez a chamada pelo script. O comando `var instance = scene.instantiate()` cria esta árvore de nodes, e o comando `add_child(instance)` adiciona está árvore como filho do node que fez a chamada.

## Editable Children e Make Local

Esse assunto já foi abordado [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Layers%20e%20Masks#editable-child-e-make-local), bem no início dos tutoriais. Vale a pena comparar o texto anterior com o atual.

Quando você instancia uma cena, por padrão ela fica meio "fechada", você vê o node raiz, mas não pode sair mexendo em tudo dentro dela. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/0c29474d-800f-45ff-b028-829d50948e5b" />
</p>

Ao clicar com o botão direito do mouse na cena instanciada, algumas opções aparecem. Estamos interessados na *Editable Children* e *Make Local*.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/b76a25b1-a56b-4fb3-b8f6-3192c1800790" />
</p>

Ao ativar a opção *Editable Children*, ocorrem algumas mudanças. Vovê passa a poder mexer dentro da cena instanciada, mas ainda é o mesmo template.

- Você pode abrir a cena instanciada no editor.
- Pode editar os nodes internos.
- A cena continua sendo uma instância.
- Ainda depende do arquivo original (`.tscn`).

O opção *Make Local* é mais radical. Ao usar *Make Local*, você está dizendo que não quer mais saber do template, agora a cena é sua e você pode fazer o que quer quiser com ela.

- A instância deixa de depender da cena original.
- Vira uma estrutura totalmente local.
- Você pode modificar qualquer coisa sem afetar nem receber updates.

Abaixo segue uma tabela com as diferenças resumidas.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/216d3732-2b8c-4711-a366-e8177cbbcd6a" />
</p>
