# Reducing stutter from shader (pipeline) compilations

Vamos começar com algumas definições preliminares.
- **Shader:** Em computação gráfica, *shaders* são pequenos programas que rodam na GPU e definem como os objetos são desenhados na tela. Cada shader executa uma parte específica do processo de renderização, controlando aspectos como cor, iluminação, sombras e outros efeitos visuais. Um jogo normalmente utiliza muitos shaders diferentes ao mesmo tempo.
- **GLSL:** GLSL (OpenGL Shading Language) é a linguagem usada para escrever shaders. A Godot gera código GLSL automaticamente a partir dos materiais e shaders que você usa.
- **Shader compilation:** Tradução do código GLSL para um formato intermediário portátil. Esse formato serve como uma representação comum entre diferentes sistemas e drivers, mas ainda não pode ser executado diretamente pela GPU.
- **Pipeline compilation:** É o passo seguinte, onde o driver da GPU converte esse formato intermediário em algo que a GPU realmente usa. É mais caro que a etapa anterior e depende do hardware/driver do usuário.

Como mencionado acima, o problema maior é que a pipeline compilation é bastante cara. Como um mesmo shader pode gerar muitas pipelines diferentes, não é viável compilar tudo antecipadamente nem distribuir pipelines prontas. Por isso, a compilação costuma acontecer quando algo aparece pela primeira vez na tela, causando as pequenas travadas conhecidas como "shader stutter". A Godot é capaz de detectar quais pipelines serão necessárias e tenta pré-compilar essas pipelines no carregamento do jogo, reduzindo o stutter (não funciona no modo Compatibility). A [documentação oficial](https://docs.godotengine.org/en/stable/tutorials/performance/pipeline_compilations.html) explica em mais detalhes como isso funciona.

## Monitoramento do pipeline

Apesar da Godot tentar pré-compilar as pipelines, isso não é uma solução definitiva. Então é importante que o desenvolvedor seja capaz de algum tipo de monitoramento sobre elas. Ele pode fazer isso indo em *Debbuger → Monitors*, como mostrado abaixo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/13ca5fe6-a58f-4d11-b566-439eb9372ad2" />
</p>

A Godot oferece um monitoramento que mostra quantas pipelines são compiladas e em que momento isso acontece. Ao observar esses valores durante a execução do jogo, é possível identificar fontes de stutter sem precisar limpar o cache do driver a cada teste. Aumentos repentinos fora das telas de carregamento indicam compilação de pipelines durante a gameplay, o que pode causar stutter na primeira execução do jogo. 

> PS: Os valores mostrados no monitoramento só aumentam ao longo do tempo, pois as pipelines removidas não são contabilizadas e podem ser recriadas durante o jogo.

Abaixo, detalhamos o que cada item do monitoramento significa.

- **Canvas:** Compilação acontece quando um node 2D é desenhado pela primeira vez. A Godot ainda não pré-compila elementos 2D, então isso pode causar stutter na primeira aparição do node.
- **Mesh:** Compilação acontece ao carregar uma malha 3D e identificar pipelines precompiláveis a partir de suas propriedades. Carregar malhas em tempo de jogo pode gerar stutter, mas o impacto pode ser reduzido se o carregamento for feito em uma thread de fundo. Modificadores via overrides de material não são compilados nessa etapa.
- **Surface:** Compilação ocorre quando um frame vai ser desenhado e objetos 3D foram instanciados pela primeira vez na cena (pode incluir nodes não visíveis). O stutter aparece apenas no primeiro frame em que o node é adicionado, e costuma não ser perceptível se acontecer logo após uma tela de carregamento.
- **Draw:** Compilação sob demanda quando um objeto 3D precisa ser desenhado. 
- **Specialization:** Compilação feita em background durante a gameplay para otimizar o frame rate. Não causa stutter, mas muitas especializações por frame podem reduzir o desempenho geral.

O manual oficial ainda possui mais três seções sobre otimização de GPU, mas elas são muito específicas e de uso pontual. Por conta disso, elas ficaram de fora deste tutorial.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/GPU/GPU%20optimization">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Threads/Using%20multiple%20threads">Próximo ➡</a>
</p>
