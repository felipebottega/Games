# Reducing stutter from shader (pipeline) compilations

Vamos começar com algumas definições preliminares.
  - **Shader:** Em computação gráfica, *shaders* são pequenos programas que rodam na GPU e definem como os objetos são desenhados na tela. Cada shader executa uma parte específica do processo de renderização, controlando aspectos como cor, iluminação, sombras e outros efeitos visuais. Um jogo normalmente utiliza muitos shaders diferentes ao mesmo tempo.
  - **GLSL:** GLSL (OpenGL Shading Language) é a linguagem usada para escrever shaders. A Godot gera código GLSL automaticamente a partir dos materiais e shaders que você usa.
  - **Shader compilation:** Tradução do código GLSL para um formato intermediário portátil. Esse formato serve como uma representação comum entre diferentes sistemas e drivers, mas ainda não pode ser executado diretamente pela GPU.
  - **Pipeline compilation:** É o passo seguinte, onde o driver da GPU converte esse formato intermediário em algo que a GPU realmente usa. É mais caro que a etapa anterior e depende do hardware/driver do usuário.

O problema é que a pipeline compilation é cara e depende do hardware e do driver do usuário. Como um mesmo shader pode gerar muitas pipelines diferentes, não é viável compilar tudo antecipadamente nem distribuir pipelines prontas. Por isso, a compilação costuma acontecer quando algo aparece pela primeira vez na tela, causando as pequenas travadas conhecidas como shader stutter. A Godot é capaz de detectar quais pipelines serão necessárias e tenta pré-compilá-las no carregamento do jogo, reduzindo o stutter.

## Monitoramento do pipeline

Apesar da Godot tentar pré-compilar os pipelines, isso não é uma solução definitiva. Então é importante que o desenvolvedor seja capaz de algum tipo de monitoramento sobre os pipelines. Ele pode fazer isso indo em *Debbuger → Monitors*, como mostrado abaixo.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/13ca5fe6-a58f-4d11-b566-439eb9372ad2" />
</p>

A Godot oferece um monitoramento que mostra quantas pipelines são compiladas e em que momento isso acontece. Ao observar esses valores durante a execução do jogo, é possível identificar fontes de stutter sem precisar limpar o cache do driver a cada teste. Aumentos repentinos fora das telas de carregamento indicam compilação de pipelines durante o gameplay, o que pode causar stutter na primeira execução do jogo no sistema do jogador. 

> PS: Os valores mostrados no monitoramento só aumentam ao longo do tempo, pois pipelines removidas não são contabilizadas e podem ser recriadas durante o jogo.

Abaixo, detalhamos o que cada item do monitoramento significa.

  - **Canvas:** Compilação acontece quando um nó 2D é desenhado pela primeira vez. A Godot ainda não pré-compila elementos 2D, então isso pode causar stutter na primeira aparição do nó.
  - **Mesh:** Compilação acontece ao carregar uma malha 3D e identificar pipelines precompiláveis a partir de suas propriedades. Carregar malhas em tempo de jogo pode gerar stutter, mas o impacto pode ser reduzido se o carregamento for feito em uma thread de fundo. Modificadores via overrides de material não são compilados nessa etapa.
  - **Surface:** Compilação ocorre quando um frame vai ser desenhado e objetos 3D foram instanciados pela primeira vez na cena — pode incluir nós não visíveis. O stutter aparece apenas no primeiro frame em que o nó é adicionado, e costuma não ser perceptível se acontecer logo após uma tela de carregamento.
  - **Draw:** Compilação sob demanda quando um objeto 3D precisa ser desenhado e o ubershader não foi pré-compilado. Isso causa stutter durante o gameplay e é equivalente ao comportamento anterior ao Godot 4.4. Se você observar compilações aqui, reporte no repositório da Godot com um projeto mínimo que reproduza o problema, pois isso não deveria ocorrer com o sistema de Ubershader.
  - **Specialization:** Compilação feita em background durante o gameplay para otimizar o frame rate. Não causa stutter, mas muitas especializações por frame podem reduzir o desempenho geral.
