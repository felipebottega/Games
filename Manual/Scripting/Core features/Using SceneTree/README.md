# Using SceneTree

O funcionamento interno da Godot é o seguinte: existe a classe [`OS`](https://docs.godotengine.org/en/stable/classes/class_os.html#class-os), que é a única instância executada no início. Em seguida, todos os drivers, servidores, linguagens de script, sistema de cenas, etc., são carregados. A Godot funciona como uma enine de jogo de alto nível sobre uma camada intermediária de baixo nível. O sistema de cenas é o alto nível, enquanto o `OS` e os servidores são a API de baixo nível.

Quando a inicialização está concluída, o `OS` precisa receber um *MainLoop* para ser executado. Por default, a Godot fornece a classe [`SceneTree`](https://docs.godotengine.org/en/stable/classes/class_scenetree.html#class-scenetree). Esta é instanciada e configurada automaticamente ao executar uma cena, sem necessidade de qualquer trabalho adicional.

Alguns tutoriais anteriores que passaram por este tema: [Change scenes manually](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Change%20scenes%20manually) e [Overridable functions](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Overridable%20functions).

É importante saber sobre a classe `SceneTree` pois ela tem alguns usos importantes:
- Ela contém a Viewport raiz (*root*).
- Ela contém informações sobre os grupos e permite acessar todos os nodes de um grupo ou obter uma lista deles.
- Ela contém algumas funcionalidades de estado global, como definir o modo de pausa ou encerrar o processo.

> PS: Quando um node faz parte da árvore de cena, o `SceneTree` pode ser obtido chamando o comando `get_tree()`.

> PS: Vimos anteriormente que é possível acessar o *root* com o comando `get_node("/root")`. Como o `SceneTree` contém o *root*, ele também possui um método para acessá-lo diretamente: `get_tree().root`.

## Entrando e saindo da árvore de cena

Quando um node é conectado ao *root*, ele passa a fazer parte da árvore de cena. Isso significa que ele receberá as funções nativas `_enter_tree()`, `_ready()` e `_exit_tree()` automaticamente. Além disso, ele obtêm acesso a tudo o que precisa para processar dados, receber inputs, exibir visuais 2D e 3D, receber e enviar notificações, reproduzir sons, etc. Quando é removido da árvore de cena, ele perde essas capacidades. A ordem dos eventos desde a entrada até a saída da árvore de cena está resumida abaixo.

1. Uma cena é carregada do disco ou criada por script.
2. O node raiz dessa cena é adicionado como filho do *root* ou a qualquer um de seus descendentes.
3. Cada node da cena recém adicionada receberá a notificação `_enter_tree` de cima para baixo.
4. Cada node receberá a notificação `_ready` assim que todos os seus filhos tiverem recebido a notificação `_ready` (de baixo para cima).
5. Quando uma cena (ou parte dela) é removida, ela recebe a notificação `_exit_tree` de baixo para cima.

A maioria das operações de nodes, como desenhar em 2D, processar dados ou receber notificações, são feitas na ordem da árvore, de cima para baixo. Uma exceção importante é a função `_ready()`. A função `_ready()` de cada node pai é chamada somente depois que todas as funções `_ready()` de todos os seus nodes filhos forem chamadas, para que o node pai saiba que seus filhos estão completamente prontos para serem acessados.

## Propriedades

- **get_tree().root:** Retorna o *root* da árvore de cena,
- **get_tree().paused:** Se for true, a árvore de cena é considerada pausada. A física 2D e 3D será interrompida, assim como a detecção de colisões e os sinais relacionados. Dependendo do *modo de processamento* de cada node, seus métodos `_process()`, `_physics_process()` e `_input()` podem não ser mais chamados. Vimos em detalhes como isso funciona [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Pausing%20games%20and%20process%20mode).
- **get_tree().current_scene:** Retorna o node raiz da cena principal atualmente carregada, geralmente como um filho direto do *root*.
- **get_tree().physics_interpolation:** Se for true, vai ativar a interpolação física. Vimos em detalhes como isso funciona [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20Interpolation).

## Métodos:

Todos os métodos relativos a grupos foram vistos no [tutorial de grupos](https://github.com/felipebottega/Games/blob/gh-pages/Manual/Scripting/Core%20features/Groups/README.md), mas vamos repetir aqui para manter os métodos do `SceneTree` no mesmo local. Fora esses, alguns outros também já foram usados ao longo dos tutoriais.

- **get_tree().call_group(group_name, method_name, ...):** Chama o método `method_name` em cada node pertencente ao grupo `group_name`. Você pode passar argumentos para o método especificando-os ao final da chamada. Nodes que não podem chamar o método (seja porque o método não existe ou porque os argumentos não correspondem) são ignorados.
- **get_tree().get_nodes_in_group(group_name):** Retorna um array contendo todos os nodes pertencentes ao grupo `group_name`, na ordem da hierarquia da cena.
- **get_tree().get_node_count_in_group(group_name):** Retorna o número de nodes pertencentes ao grupo `group_name`. É equivalente ao comando `get_tree().get_nodes_in_group(group_name).size()`, mas esse último é menos eficiente pois cria uma array e depois faz a contagem.
- **get_tree().has_group(group_name):** Retorna *true* se existe pelo menos um node pertencente ao grupo `group_name` na árvore.
- **get_tree().notify_group(group_name, notification):** Envia uma notificação para todos os nodes que estão no grupo `group_name`. A notificação `notification` deve ser um inteiro.
- **get_tree().set_group(group_name, property, value):** Altera o valor da propriedade `property` para `value` em todos os nodes pertencentes ao grupo `group_name`. Os nodes que não possuem a propriedade são ignorados.
- **get_tree().change_scene_to_file(path):** Altera a cena em execução para aquela no caminho especificado, após carregá-la em um `PackedScene` e criar uma nova instância.
- **get_tree().change_scene_to_node(node):** Altera a cena em execução para o node fornecido. Útil quando você deseja configurar a nova cena antes de mudar.
- **get_tree().change_scene_to_packed(packed_scene):** Altera a cena em execução para uma nova instância do `PackedScene` fornecido.
- **get_tree().create_timer(time_sec):** Retorna um `SceneTreeTimer`. Após passar o tempo definido em `time_sec` (em segundos), o timer emitirá `SceneTreeTimer.timeout` e será liberado automaticamente.
- **get_tree().get_frame():** Retorna quantos frames físicos foram processados desde o início.
- **get_tree().get_node_count():** Retorna o número de nodes na árvore de cena. O *root* não é contabilizado.
- **get_tree().queue_delete(object):** Coloca o objeto fornecido em fila para ser deletado, chamando seu método `Object.free()` ao final do frame atual. Este método é similar `queue_free()`.
- **get_tree().quit():** Sai do jogo quando acabar a iteração atual.
- **get_tree().reload_current_scene():** Recarrega a cena atualmente ativa, substituindo `current_scene` por uma nova instância de sua `PackedScene` original.

## SceneTree e root

Como podemos notar, a classe `SceneTree` e o node *root* são dois objetos que sempre são chamados quando um jogo é executado, mas ambos operam por trás dos bastidores. Apesar da mesma natureza "oculta", é importante notar que é o `SceneTree` que engloba tudo. O *root* é apenas um viewport geral, ele representa a tela do jogador de fato. Por outro lado, o `SceneTree` é o coordenador geral, é ele quem conversa com o sistema operacional, quem executa o loop principal do jogo, quem coordena todas as cenas e nodes, etc. 
