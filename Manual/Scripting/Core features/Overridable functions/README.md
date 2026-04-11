# Overridable functions

Vimos uma descrição breve sobre o que são essas funções no [tutorial de estrutura do código](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20style%20guide#estrutura-do-c%C3%B3digo). Segue a exata mesma decrição abaixo.

***overridden built-in virtual methods/functions:** São funções nativas da própria Godot que você sobrescreve. A ordem sugerida acompanha o ciclo de vida do node: criação, entrada na árvore, prontidão, processamento por frame e processamento físico.*

Estamos falando funções/métodos da classe `Node`, que vem vazios e prontos para serem sobrescritos. Cada um tem uma finalidade própria definida pela engine. Vamos falar dos mais gerais aqui, mas existem vários outros. Consulte a documentação oficial da [classe Node](https://docs.godotengine.org/en/stable/classes/class_node.html) para conhecer.

## Overridable functions da classe Node

- **_init:** O `_init` é chamado imediatamente quando a instância do script é criada. Esta inicialização de variáveis serve para criar instâncias com parâmetros, assim como é o `__init__` de Python. Veja mais sobre ela [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#construtor).
- **_enter_tree:** O `_enter_tree` é chamado quando node acabou de entrar na árvore. Use quando você precisa reagir imediatamente à entrada do node. 
- **_ready:** Filhos ainda podem não estar prontos na cena quando o `_init_` e `_enter_tree` são executados. Por outro lado, o `_ready` só é chamado quando todos os filhos já foram inicializados, então já é seguro acessar os nodes da cena. Acessar objetos externos ainda pode dar erro, como adicionar cenas externas, recursos externos, etc. Prefira usar a chamada `call_deferred` para objetos fora da cena.
- **_process:** Função que executa processos a cada frame.
- **_physics_process:** Função que executa processos a cada frame físico.
- **_input:** Primeira função que recebe inputs.
- **_unhandled_input:** Última função que recebe inputs. Se o input não for consumido aqui, ele será ignorado completamente pelo jogo.
- **_exit_tree:** Chamado quando o node está prestes a sair da árvore de cena (por exemplo, ao ser liberado, ao trocar de cena ou após chamar `remove_child()`). Se o node tiver filhos, o seu `_exit_tree()` será chamado por último, depois que todos os seus filhos tiverem saído da árvore.
