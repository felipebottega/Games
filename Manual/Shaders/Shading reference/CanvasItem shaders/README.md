# CanvasItem shaders

Os shaders do tipo `canvas_item` são usados ​​para desenhar todos os elementos 2D no Godot. Isso inclui todos os nodes que herdam de `CanvasItem` e todos os elementos da GUI.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/41e51ddf-ff9d-4207-8d05-e1a3449bf56b" />
</p>

> PS: GUI significa "Graphical User Interface". Esta é a camada da interface visual: botões, menus, painéis, etc. A classe responsável por lidar com isso é a `Control`.

## Modos de renderização

Opcionalmente, também é possível escolher um modo de renderização (*render mode*) para o shader. Você pode especificar na segunda linha do código, logo após a definição do tipo de shader. Os modos de renderização alteram a forma como a Godot aplica o shader. Por exemplo, o modo `unshaded` faz com que a enigne ignore a função de processamento de luz. Cada tipo de shader possui modos de renderização diferentes. 

| Render mode             | Descrição                                                                                   |
|-------------------------|---------------------------------------------------------------------------------------------|
| `blend_mix`             | Modo de mistura padrão (alpha define a transparência).                                      |
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

## Valores nativos 

Os valores marcados como `in` são somente leitura. Os valores marcados como `out` podem opcionalmente ser escritos. Os valores marcados como `inout` fornecem um valor padrão válido e também podem opcionalmente ser escritos. Os samplers não podem ser escritos por padrão, portanto, não são marcados.

Nem todos os valores nativos estão disponíveis em todas as *funções de processamento*. Para acessar um valor nativo do `vertex()` a partir do `fragment()`, por exemplo, você pode usar uma [variável interpolada](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/Shading%20language#vari%C3%A1veis-interpoladas-varyings). O mesmo se aplica ao acesso a valores nativos do `fragment()` a partir do `light()`.

### Valores nativos globais

São valores nativos disponíveis para todas as funções, incluindo as customizadas.

| Variável&nbsp;Nativa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Descrição |
|--------------|-----------|
| `in float TIME` | Tempo global desde que a engine foi iniciada, em segundos. Ele reinicia a cada 3600 segundos (isso pode ser alterado em *Project → Project Settings → General → Rendering → Limits → Time → Time Rollover Secs*, com a opção avançada ativada). É afetado por `time_scale`, mas não é afetado por pausa. Se você precisar de uma variável de tempo que não seja afetada por `time_scale`, crie seu próprio uniform global de shader e o atualize a cada frame. |
| `in float PI` | Constante PI (3.141592). |
| `in float TAU` | Constante TAU (6.283185). Equivalente a `PI * 2` e representa o número de radianos em uma volta completa. |
| `in float E` | Constante E (2.718281). Número de Euler, base do logaritmo natural. |

### Variáveis nativos do vertex

| Built-in | Descrição |
|----------|-----------|
| `in mat4 MODEL_MATRIX` | Transformação do espaço local para o espaço global (world). O espaço global corresponde às coordenadas que você normalmente usa no editor. |
| `in mat4 CANVAS_MATRIX` | Transformação do espaço global para o espaço de canvas. Nesse espaço, a origem fica no canto superior esquerdo da tela e as coordenadas vão de `(0.0, 0.0)` até o tamanho do viewport. |
| `in mat4 SCREEN_MATRIX` | Transformação do espaço de canvas para o espaço de recorte (clip space). Nesse espaço, as coordenadas variam de `(-1.0, -1.0)` até `(1.0, 1.0)`. |
| `in int INSTANCE_ID` | ID da instância usada para instancing. |
| `in vec4 INSTANCE_CUSTOM` | Dados personalizados da instância. |
| `in bool AT_LIGHT_PASS` | Sempre falso. |
| `in vec2 TEXTURE_PIXEL_SIZE` | Tamanho de pixel normalizado da textura 2D padrão. Para um `Sprite2D` com textura de 64x32 px, `TEXTURE_PIXEL_SIZE = vec2(1.0/64.0, 1.0/32.0)`. |
| `inout vec2 VERTEX` | Posição do vértice no espaço local. |
| `in int VERTEX_ID` | Índice do vértice atual no buffer de vértices. |
| `inout vec2 UV` | Coordenadas de textura normalizadas. Variam de `0.0` a `1.0`. |
| `inout vec4 COLOR` | Cor proveniente do vértice, multiplicada por `modulate` do `CanvasItem` e por `self_modulate`. |
| `inout float POINT_SIZE` | Tamanho do ponto para renderização de pontos. |
| `in vec4 CUSTOM0` | Valor personalizado vindo do vértice. |
| `in vec4 CUSTOM1` | Valor personalizado vindo do vértice. |

Os dados de vértice (VERTEX) são apresentados no espaço local (coordenadas de pixel, relativas à origem do Node2D). Se não forem alterados, esses valores permanecerão inalterados e serão transmitidos como foram recebidos. É possível pode desativar a transformação embutida de modelo para mundo (a conversão de mundo para tela e a projeção ainda ocorrerão mais adiante) e fazer isso manualmente com o seguinte código:

```c#
shader_type canvas_item;
render_mode skip_vertex_transform;

void vertex() {

    VERTEX = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}
```

Outras variáveis nativas, como UV e COLOR, também são repassados para a função `fragment()` se não forem modificados. Para instanciar, a variável `INSTANCE_CUSTOM` contém os dados personalizados da instância. Ao usar partículas, essas informações normalmente são:

- **x:** ângulo de rotação em radianos.
- **y:** fase durante a vida útil (0.0 a 1.0).
- **z:** frame da animação.

### Variáveis nativas do fragment

| Built-in | Descrição |
|----------|-----------|
| `in vec4 FRAGCOORD` | Coordenada do centro do pixel, em espaço de tela. O componente `xy` define a posição dentro do viewport. A origem `(0.0, 0.0)` fica no canto superior esquerdo. |
| `in vec2 SCREEN_PIXEL_SIZE` | Tamanho de um pixel individual. Equivale ao inverso da resolução da tela. |
| `in vec4 REGION_RECT` | Área visível da região do sprite no formato `(x, y, largura, altura)`. Varia de acordo com a propriedade `region_enabled` do `Sprite2D`. |
| `in vec2 POINT_COORD` | Coordenada usada para renderização de pontos. |
| `sampler2D TEXTURE` | Textura 2D padrão. |
| `in vec2 TEXTURE_PIXEL_SIZE` | Tamanho de pixel normalizado da textura 2D padrão. Para um `Sprite2D` com textura de 64x32 px, `TEXTURE_PIXEL_SIZE = vec2(1/64, 1/32)`. |
| `in bool AT_LIGHT_PASS` | Sempre falso. |
| `sampler2D SPECULAR_SHININESS_TEXTURE` | Textura de brilho especular deste objeto. |
| `in vec4 SPECULAR_SHININESS` | Cor de brilho especular, obtida a partir da textura. |
| `in vec2 UV` | Coordenadas UV vindas da função `vertex()`. Em um `Sprite2D` com `region` ativado, cobre a textura inteira. Para usar apenas a região definida, utilize `REGION_RECT`. |
| `in vec2 SCREEN_UV` | Coordenadas UV da tela para o pixel atual. |
| `sampler2D SCREEN_TEXTURE` | Removido no Godot 4. Use um `sampler2D` com `hint_screen_texture`. |
| `inout vec3 NORMAL` | Normal lida de `NORMAL_TEXTURE`. Pode ser modificada. |
| `sampler2D NORMAL_TEXTURE` | Textura de normais 2D padrão. |
| `out vec3 NORMAL_MAP` | Permite usar normal maps pensados para 3D em 2D. Se usado, sobrescreve `NORMAL`. |
| `out float NORMAL_MAP_DEPTH` | Profundidade do normal map, usada para ajuste de escala. |
| `inout vec2 VERTEX` | Posição do pixel em espaço de tela. |
| `inout vec2 SHADOW_VERTEX` | Igual a `VERTEX`, mas pode ser modificado para alterar sombras. |
| `inout vec3 LIGHT_VERTEX` | Igual a `VERTEX`, mas pode ser modificado para alterar iluminação. O componente `z` representa altura. |
| `inout vec4 COLOR` | `COLOR` vindo da função `vertex()` multiplicado pela cor da `TEXTURE`. Também representa a cor final de saída. |
