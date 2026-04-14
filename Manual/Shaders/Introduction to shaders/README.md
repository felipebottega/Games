# Introduction to shaders

"Shader" é um termo que foi dito algumas vezes em tutoriais passados, mas nunca utilizamos isso de fato. Agora chegou a hora de abordar esse tema de maneira sistemática. Vamos começar com algumas definições retiradas [daqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/GPU/Reducing%20stutter%20from%20shader%20(pipeline)%20compilations).

- **Shader:** Em computação gráfica, shaders são pequenos programas que rodam na GPU e definem como os objetos são desenhados na tela. Cada shader executa uma parte específica do processo de renderização, controlando aspectos como cor, iluminação, sombras e outros efeitos visuais. Um jogo normalmente utiliza muitos shaders diferentes ao mesmo tempo.
- **GLSL:** GLSL (OpenGL Shading Language) é a linguagem usada para escrever shaders. A Godot gera código GLSL automaticamente a partir dos materiais e shaders que você usa.
- **Shader compilation:** Tradução do código GLSL para um formato intermediário portátil. Esse formato serve como uma representação comum entre diferentes sistemas e drivers, mas ainda não pode ser executado diretamente pela GPU.
- **Pipeline compilation:** É o passo seguinte, onde o driver da GPU converte esse formato intermediário em algo que a GPU realmente usa. É mais caro que a etapa anterior e depende do hardware/driver do usuário.

A figura abaixo ilustra o processo inteiro de maneira bem resumida. A CPU faz uma chamada para a GPU desenhar algo e, junto com essa chamada, envia dados associados (texturas, parâmetros, configurações, etc.). Esses dados são armazenados na memória da GPU. Em seguida, os shaders são executados para processar esses dados. Cada etapa do pipeline utiliza um tipo de shader, em que a saída de uma etapa serve como entrada para a próxima. Após todas as etapas serem processadas, o resultado final é então renderizado na tela.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/8db77c56-3881-46f3-851d-19d8341c2dcd" />
</p>

## Processor Functions

Na Godot, cada shader está associado a uma única função, chamada de "função de processamento" (no original, "processor function"). As *funções de processamento* são o ponto de entrada do seu shader no programa. Elas representam etapas específicas do pipeline, cada uma atuando como um "processador" de um tipo de dado. Existem 7 *funções de processamento* diferentes.

1. A função `vertex()` (*vertex shader*) percorre todos os vértices da malha e define suas posições e algumas outras variáveis ​​por vértice. 
2. A função `fragment()` (*fragment shader* ou *pixel shader*) é executada para cada pixel coberto pela malha. Ela usa os valores retornados pela função `vertex()`, interpolados entre os vértices. 
3. A função `light()` é executada para cada pixel e para cada luz. Ela recebe variáveis ​​da função `fragment()` e de suas execuções anteriores. 
4. A função `start()` é executada para cada partícula em um sistema de partículas uma vez, quando a partícula é criada pela primeira vez. 
5. A função `process()` é executada para cada partícula em um sistema de partículas a cada frame. 
6. A função `sky()` é executada para cada pixel no mapa de *radiance cubemap* quando o *radiance cubemap* precisa ser atualizado e para cada pixel na tela atual. 
7. A função `fog()` é executada para cada *froxel* no buffer de névoa volumétrica que intersecta o `FogVolume`.


Geralmente quando nos referimos a um shader, estamos falando de uma *função de processamento*, que pode ser a `vertex()`, a `fragment()`, etc. Cada uma destas é um shader. Na Godot, também é chamado de shader o espaço do editor de código de shader, e este contém todas as *funções de processamento* juntas. Ou seja, o "shader contendo os shaders". No contexto da Godot geralmente o shader será isso, e no contexto mais geral o shader é a *função de processamento*. Você pode ver abaixo como o shader da Godot é inicializado por default, já contendo os shaders mais comuns para edição.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/0adf00e1-43b1-43a9-919c-781fc83641fa" />
</p>


### Vertex, fragment e light

Para shaders 2D, na prática, trabalhamos principalmente com `vertex()` e `fragment()`. Outras funções existem para casos mais específicos, como iluminação (`light()`) ou sistemas mais avançados, e podem ser exploradas conforme a necessidade. Por enquanto vamos focar apenas nestes 3 por serem os mais úteis para o casos 2D.

"Vertex" significa "vértice" em inglês. O shader associado a ele simplesmente percorre os vértices do objeto. Geralmente isso faz mais sentido para objetos 3D. No caso de objetos 2D, os vértices serão os 4 pontos do retângulo que delimita a imagem do sprite. Em algumas situações você terá um sprite com formato diferente, caso tenha ajustado a geometria com base na transparência usando uma [técnica discutida antes](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20Meshes). Nestes casos especiais os vértices do sprite não serão mais as 4 pontas do retângulo.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/c9635077-6d5d-46e1-a730-414d36b97ae6" />
</p>

"Fragment" pode ser entendido como "fragmento", que representa um pixel na tela. O shader associado a essa etapa processa esses fragmentos, determinando a cor final que será exibida. Diferente do estágio de vértices, que lida com a geometria do objeto, o *fragment shader* atua na sua aparência visual (cores, texturas, transparência e efeitos de iluminação). No caso de sprites 2D, o *fragment shader* é executado para cada pixel da área ocupada pelo objeto na tela. Isso inclui regiões transparentes da textura, que ainda podem ser processadas antes de serem descartadas. 

O shader `light()` associado a essa etapa processa a influência das luzes sobre os pixels do objeto. Essa função é executada para cada fragmento e para cada luz que o afeta. Ou seja, se um mesmo pixel estiver sob a influência de várias luzes, o `light()` será chamado múltiplas vezes para esse mesmo ponto. No contexto 2D, isso é usado principalmente com nodes de iluminação, como luzes que simulam lanternas, lâmpadas ou efeitos de brilho. Caso não haja luzes na cena, essa etapa simplesmente não é utilizada.

> PS: A função `light()` não será executada se o modo de renderização *vertex_lighting* estiver ativado ou se a opção *Rendering → Quality → Shading → Force Vertex Shading* estiver ativada no *Project Settings*. Essa opção está ativada por padrão para dispositivos móveis.

## Tipos de shaders

Em vez de fornecer uma configuração de uso geral para todas as aplicações (2D, 3D, sky, fog, etc.), você deve especificar o tipo de shader que está escrevendo. Diferentes tipos suportam diferentes modos de renderização, variáveis ​​internas e funções de processamento. Os tipos disponíveis seguem abaixo.

- **spatial:** Usado para renderização 3D.
- **canvas_item:** Usado para renderização for 2D.
- **particles:** Usado para sistemas de partículas.
- **sky:** Usado para renderizar céus.
- **fog:** Usado para renderizar névoas volumétricas.

Ao escrever um shader em Godot, a primeira coisa a se fazer é definir o tipo de shader. Isso se faz com o comando `shader_type {my_type};` em que *my_type* é um dos tipos mostrados acima.

## Modos de renderização

Opcionalmente, também é possível escolher um modo de renderização (*render mode*) para o shader. Você pode especificar na segunda linha do código, logo após a definição do tipo de shader. Os modos de renderização alteram a forma como a Godot aplica o shader. Por exemplo, o modo `unshaded` faz com que a enigne ignore a função de processamento de luz. Cada tipo de shader possui modos de renderização diferentes. 

Apesar de não ser muito útil agora, vou deixar abaixo a lista dos modos de renderização do shader do tipo `canvas_item`. Como este é o shader para renderizar 2D, é um dos que mais nos interessa no momento. 

| Render mode             | Descrição                                                                                   |
|-------------------------|---------------------------------------------------------------------------------------------|
| `blend_mix`             | Se nenhum modo for especificado, este é usado por default, que é o modo de transparência normal baseado no alpha. |
| `blend_add`             | Modo de mistura aditivo.                                                                    |
| `blend_sub`             | Modo de mistura subtrativo.                                                                 |
| `blend_mul`             | Modo de mistura multiplicativo.                                                             |
| `blend_premul_alpha`    | Modo de mistura com alpha pré-multiplicado, evitando artefatos em bordas de transparência.  |
| `blend_disabled`        | Desativa a mistura. O pixel é desenhado diretamente, ignorando transparência.               |
| `unshaded`              | Ignora completamente a iluminação. Mostra apenas a cor base (ALBEDO/COLOR).                       |
| `light_only`            | O objeto só aparece quando afetado por luz (não aparece na renderização base).              |
| `skip_vertex_transform` | Desativa a transformação automática de VERTEX. Você deve aplicar manualmente no `vertex()`.   |
| `world_vertex_coords`   | VERTEX passa a ser manipulado em coordenadas globais (mundo), em vez de locais ao objeto.   |

- **VERTEX:** É a posição de cada vértice que o shader processa. No `canvas_item` (2D), ele vem em espaço local, ou seja, em coordenadas relativas ao node, e você pode modificá-lo na função `vertex()` para mover ou deformar a geometria.
- **ALBEDO:** É a cor base do material/objeto. Ele é definido como um vetor de 3 dimensões que contém a cor do objeto. Na prática, `ALBEDO` é a cor do objeto por si só, antes da iluminação afetar. `ALBEDO` é usado apenas em shader 3D, o equivalente para shader 2D é o `COLOR`.

Para definir um modo de renderização, se usa o comando `render_mode {my_render_mode_1}, {my_render_mode_2};`, em que *my_render_mode_1* e *my_render_mode_2* são dois possívels modos de renderização. Pode-se usar quantos quiser.

