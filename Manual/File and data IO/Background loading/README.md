# Background loading

Existem alguns métodos em Godot para carregar cenas, recursos, texturas, entre outros. Vamos mostrar as possibilidade, as diferenças entre elas, e mostraremos como elas são usadas na prática.

## preload

Este foi o primeiro método de carregamento que vimos. Ele foi introduzido no tutorial [Add Child](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Add%20Child) lá atrás. Ela funciona seguindo os passos mostrados abaixo.

1. `minha_cena = preload("res://scenes/minha_cena.tscn")`    # carrega a cena na memória e retorna um objeto do tipo `PackedScene`
2. `cena_instancia = minha_cena.instantiate()`    # cria uma instância da cena (variável do tipo `Node`)
3. `cena_instancia.position = Vector2(x, y)`    # altera atributos da cena
4. `add_child(cena_instancia)`    # adiciona a cena dentro da cena principal, como um filho (entra na árvode de nodes)

O `preload` é executado assim que script é inicializado/compilado, não dá para ficar chamando ele dinamicamente durante a execução várias vezes. É indicado para carregar recursos/cenas que são mais pesados ou que serão utilizados diversas vezes. Para otimizar a velocidade do carregamento, prefira chamar o `preload` antes mesmo da `_ready`, junto da definição das variáveis globais.

> PS: Por causa da sua natureza de não ser um objeto a ser chamado dinamicamente em um script, é necessário que a string de input seja uma constante. O `preload` não funciona com variáveis, mesmo que sejam strings.

## load

Funciona parecido com a `preload`, mas carrega dinamicamente, no momento em que a chamada é feita. Pode usar caminhos variáveis. Ela é boa para carregar cenas/recursos que são pequenos ou só precisam ser carregados em condições específicas. É importante notar que a `load` bloqueia a thread principal do jogo, criando um pequeno engasgo (*stutter*) na execução. Em geral isso será coisa de milisegundos, então não é problema. Só será problema se você quiser carregar um estágio inteiro com `load`. O `preload` seria mais indicado para este caso. O modo de uso é o mesmo do `preload`.

> PS: De fato, o `preload` é mais rápido que o `load`, mas ele tem a limitação de só poder ser chamado na inicialização/compilação do scritp uma vez. 

## preload e load em loops

Se por alguma razão você quer instanciar um objeto várias vezes, o ideal é carregá-lo com `preload` e `load` fora do loop e apenas criar instâncias dele no loop. Caso você (sem querer) coloque o `preload` em um loop, ele mantém o objeto carregado em cache, então não executa o `preload` mais que uma vez. Porém, o mesmo não acontece com o `load`. Colocar o `load` dentro de um loop vai fazer com que ele seja reexecutado diversas vezes. Isso não é indicado pois vai causar problemas de performance no jogo.

## get_tree().change_scene_to_file() e get_tree().change_scene_to_packed()

A chamada `get_tree().change_scene_to_file("res://scenes/minha_cena.tscn")` troca a cena atual por outra, usando o caminho do arquivo. Ela faz o carregamento da cena no momento da chamada, basicamente como se você estivesse fazendo isso:

1. `minha_cena = load("res://scenes/minha_cena.tscn")`
2. `get_tree().change_scene_to_packed(minha_cena)`

A segunda função, `get_tree().change_scene_to_packed()`, também troca a cena atual por outra, mas ela recebe a cena como um objeto `PackedScene` em vez da string do caminho.

Se você tiver uma cena grande e quiser evitar pequenas pausas ao trocar, você pode fazer algo assim:

1. `minha_cena = preload("res://scenes/minha_cena.tscn")`    # carregada antes
2. `get_tree().change_scene_to_packed(minha_cena)`    # troca instantânea

Aqui você pré-carregou a cena, então a troca é quase instantânea, evitando o lag que normalmente aconteceria com `get_tree().change_scene_to_file()` direto.

## ResourceLoader

Como vimos, os dois métodos anteriores carregam cenas mas custam na performance do jogo. A diferença é se você quer que o custo seja pago antes de entrar na cena (`preload`) ou durante a cena (`load`). Este trade-off depende da flexibilidade que você deseja nos carregamentos. 

Existe um método que não traz custo nenhum de performance no jogo, pois o carregamento acontece totalmente em segundo plano. Este método funciona seguindo os passos mostrados abaixo.

1. `ResourceLoader.load_threaded_request("res://scenes/minha_cena.tscn")`    # solicita que o recurso seja carregado em background
2. `status, array = ResourceLoader.load_threaded_get_status("res://scenes/minha_cena.tscn", array)`    # permite checar quanto falta (percentual)
3. `minha_cena = ResourceLoader.load_threaded_get("res://scenes/minha_cena.tscn")`    # carrega a cena na memória e retorna um objeto do tipo `PackedScene`

A chamada `ResourceLoader.load_threaded_get_status` deve ficar rodando dentro do `_process` ou `_physics_process` até o status ser igual a $3$ (você pode ver sobre os tipos de status [aqui](https://docs.godotengine.org/en/stable/classes/class_resourceloader.html#enum-resourceloader-threadloadstatus)). Quando isso acontece, significa que a cena terminou de ser carregada. O array é opcional, caso você queira uma barra de progresso ou algo do tipo. Depois do passo 3, a continuação é só repetir o passo 2 do `preload` em diante ou fazer o `get_tree().change_scene_to_packed()` se for uma mudança de cena. 

> PS: Existe também o método `ResourceLoader.load`, mas ele é basicamente o `load` com algumas opções extras que não importam muito. 

> ⚠️: Não chame a `ResourceLoader.load_threaded_get` sem ter certeza que o carregamento finalizou, senão você vai travar o jogo.

## Tabela comparativa dos tipos de carregamento

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/24717e94-9d90-410d-95df-8fa750271ef7" />
</p>

## Testes

Vamos comparar os métodos vistos para o caso de se querer carregar um estágio novo de um jogo. Já sabemos que nem todo método é ideal para isso, mas vamos testar para ter uma noção de como os métodos se comparam. 

Criamos um jogo onde a tela inicial não tem nada, mas possui um `Timer` de $3$ segundos. Assim que acaba esse tempo, o jogo muda para a cena do estágio. Este é um estágio pesado, feito para ser lento no carregamento. Ele possui 3 sistemas de partículas, sendo um com física de turbulência, 2 sprites de background, com um deles gigantesco, e pouco mais de $600$ `RigidBody2D` de bolas com textura, colisão e luz própria (`PointLight2D`). 

Em todos os casos, estaremos chamando `get_tree().change_scene_to_file()` ou `get_tree().change_scene_to()` para fazer a mudança de cena. Vale ressaltar que `add_child` é usado para adicionar um elemento à sua árvore de nodes, e isso é diferente de mudança de cena, por isso este último não é indicado para este caso. Os métodos que iremos testar são os seguintes:

1. **Preload1:** Carrega a cena com o `preload` antes do `_ ready` e chama o `get_tree().change_scene_to_packed()` quando passam os $3$ segundos.
2. **Preload2:** Carrega a cena com o `preload` no `_ ready` e chama o `get_tree().change_scene_to_packed()` quando passam os $3$ segundos.
3. **Preload3:** Faz tudo só quando passam os $3$ segundos.
4. **Load1:** Carrega a cena com o `load` antes do `_ ready` e chama o `get_tree().change_scene_to_packed()` quando passam os $3$ segundos.
5. **Load2:** Carrega a cena com o `load` no `_ ready` e chama o `get_tree().change_scene_to_packed()` quando passam os $3$ segundos.
6. **Load3:** Faz tudo só quando passam os $3$ segundos.
7. **get_tree().change_scene_to_file():** Chama o `get_tree().change_scene_to_file()` quando passam os $3$ segundos.
8. **ResourceLoader1:** Faz o request da cena antes do `_ ready` e a carrega quando passam os $3$ segundos.
9. **ResourceLoader2:** Faz o request da cena no `_ ready` e a carrega quando passam os $3$ segundos.

Abaixo temos o tempos em segundos de cada método. O primeiro é o tempo que levou para entrar no `_ready`, o segundo é o tempo que levou para passar os $3$ segundos do `Timer`, e o último é o tempo que levou para a primeira bola aparecer na tela. O primeiro bloco de tempos acima é o caso default, em que não há nada na primeira cena para atrapalhar o `Timer`. No segundo bloco de tempos, há um sistema de partículas com turbulência na primeira cena.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/c7cf4f0b-fda3-4782-8be2-46e6e8f13f53" />
</p>

Podemos notar que a posição do `preload` não fez diferença. Isso já era esperado, uma vez que ele é chamado em tempo de compilação do script. O `load` teve tempo parecido com o `preload` apenas quando ele foi chamado antes mesmo da `_ready`. Nos outros casos podemos notar que o tempo para o carregamento ficou postergado para depois. O `get_tree().change_scene_to_file()` e `ResourceLoader` foram semelhantes ao `load` que entrou mais tarde. Vale notar que, no segundo bloco de tempos, o atraso do `Timer` se deu por conta das partículas. O carregamento delas se dá na GPU e paralisa o jogo todo mesmo, incluindo carregamentos de segundo plano, por isso o `ResourceLoader` não teve benefícios no segundo bloco.
