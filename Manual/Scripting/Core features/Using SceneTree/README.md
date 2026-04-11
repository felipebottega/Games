# Using SceneTree

O funcionamento interno da Godot é o seguinte: existe a classe [`OS`](https://docs.godotengine.org/en/stable/classes/class_os.html#class-os), que é a única instância executada no início. Em seguida, todos os drivers, servidores, linguagens de script, sistema de cenas, etc., são carregados. A Godot funciona como uma enine de jogo de alto nível sobre uma camada intermediária de baixo nível. O sistema de cenas é o alto nível, enquanto o `OS` e os servidores são a API de baixo nível.

Quando a inicialização está concluída, o `OS` precisa receber um *MainLoop* para ser executado. Por default, a Godot fornece a classe [`SceneTree`](https://docs.godotengine.org/en/stable/classes/class_scenetree.html#class-scenetree). Esta é instanciada e configurada automaticamente ao executar uma cena, sem necessidade de qualquer trabalho adicional.

Alguns tutoriais anteriores que passaram por este tema: [Change scenes manually](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Change%20scenes%20manually) e [Overridable functions](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Overridable%20functions).

É importante saber que essa classe existe pois ela tem alguns usos importantes:
- Ela contém a `Viewport` raiz (*root*).
- Ela contém informações sobre os grupos e permite acessar todos os nodes de um grupo ou obter uma lista deles.
- Ela contém algumas funcionalidades de estado global, como definir o modo de pausa ou encerrar o processo.

> PS: Quando um nó faz parte da árvore de cena, o `SceneTree` pode ser obtido chamando o comando `get_tree()`.

> PS: Vimos anteriormente que é possível acessar o *root* com o comando `get_node("/root")`. Como o `SceneTree` contém o *root*, ele também possui um método para acessá-lo diretamente: `get_tree().root`.

## Entrando e saindo da árvore de cena

Quando um node é conectado ao *root* ele passa a fazer parte da árvore de cena. Isso significa que ele receberá as funções nativas `_enter_tree()`, `_ready()` e `_exit_tree()` automaticamente. Além disso, ele obtêm acesso a tudo o que precisa para processar dados, receber inputs, exibir visuais 2D e 3D, receber e enviar notificações, reproduzir sons, etc. Quando são removidos da árvore de cena, eles perdem essas capacidades.
