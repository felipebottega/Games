# Overview of debugging tools

A Godot vem com um debugger e profiler poderosos para rastrear erros, inspecionar seu jogo em tempo de execução, monitorar métricas essenciais e medir o desempenho. Ele também oferece opções para visualizar caixas de colisão e polígonos de navegação no jogo em execução. Abaixo, temos os dois principais painéis responsáveis por esta parte. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/326b1c64-00f0-4872-8f06-58a8dff00064" />
</p>

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/28431ac2-58bc-47ed-be5a-50091275a547" />
</p>

Entraremos mais em detalhes sobre cada painel acima nos tutoriais a seguir.

> PS: Já vimos um pouco do sobre profiles no [tutorial de otimização de CPU](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/CPU/CPU%20optimization).

## Debug menu options

Vamos começar falando sobre as opções de debug do editor. Já explicamos sobre alguns de seus campos em momentos de necessidade, mas agora chegou a hora de abordar isso sistematicamente.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/9fe88d22-f570-48d4-a5da-629a2fe0e3b1" />
</p>

- **Deploy with Remote Debug:** Quando esta opção está habilitada, exportar com *one-click deploy* fará com que o executável tente se conectar ao endereço IP deste computador para que o projeto em execução possa ser debugado. Esta opção destina-se à depuração remota (normalmente com um dispositivo móvel).
- **Small Deploy with Network Filesystem:** Essa opção acelera os testes de jogos grandes em dispositivos remotos. Quando esta opção hailitada, em vez de exportar o jogo completo, gera um executável mínimo. O editor então fornece os arquivos do projeto pela rede.
- **Visible Collision Shapes:** Quando esta opção estiver habilitada, os shapes de colisão e os nodes de raycast (2D e 3D) ficarão visíveis no projeto em execução.
- **Visible Paths:** Quando esta opção estiver habilitada, as curvas usadas ​​pelos nodes de caminho (`Path2D` e `PathFollow2D`, ver [este tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Add%20Child) e [este](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Path2D). ) ficarão visíveis no projeto em execução.
- **Visible Navigation:** Quando esta opção estiver habilitada, as malhas de navegação e os polígonos ficarão visíveis no projeto em execução. Utilizamos esta opção [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview), [neste](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Connecting%20navigation%20meshes) e [neste](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Navigation%20debug%20tools).
- **Visible Avoidance:** Quando esta opção estiver habilitada, os shapes, raios e velocidades dos objetos a serem evitados (no sistema de navegação) ficarão visíveis no projeto em execução.
- **Debug CanvasItem Redraws:** Quando esta opção está habilitada, as solicitações de redraw de objetos 2D ficarão visíveis (como um breve flash) no projeto em execução. Isso é útil para solucionar problemas relacionados ao modo de baixo processamento.
- **Synchronize Scene Changes:** Quando esta opção está habilitada, quaisquer alterações feitas na cena serão replicadas no projeto em execução. Ao usar remotamente em um dispositivo, isso é mais eficiente se a opção de sistema de arquivos de rede estiver ativada.
- **Synchronize Script Changes:** Quando esta opção está habilitada, quaisquer alterações feitas no script serão recarregadas no projeto em execução. Quando usado remotamente em um dispositivo, isso é mais eficiente com o sistema de arquivos de rede.
- **Keep Debug Server Open:** Quando essa opção está habilitada, o servidor de debug do editor permanecerá aberto e ficará à espera de novas sessões iniciadas fora do próprio editor.
- **Customize Run Instances:** Isso abre uma caixa de diálogo que permite instruir a Godot a executar várias instâncias do jogo simultaneamente e especificar os argumentos da linha de comando para cada instância. Isso é especialmente para jogos multiplayer. Como este não é o meu foco no momento, não vou adentrar no assunto. Porém, vale ressaltar que há bastante coisa para se fazer nessa caixa de diálogo.

## Script editor debug tools and options

Em programação, um "breakpoint" é um ponto do código que você determina para pausar a execução. A partir daquele ponto, é possível executar as tarefas seguintes uma por vez, para entender exatamente o que está acontecendo. Esta funcionalidade permite detectar bugs e erros mais facilmente. A Godot possui duas maneiras de se inserir breakpoints no código: clicando no lado esquerdo do código para criar uma "bolinha vermelha" ou inserindo a keyword `breakpoint` no código.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/935b787c-19b7-4902-a424-ae95ba602728" />
</p>

A bolinha é mais rápida de criar e desfazer, mas ela pode sumir entre versões diferentes da engine ou mesmo em máquinas diferentes. A keyword é garantida de sempre estar lá, já que é inserida diretamente no código. Só é chato ter que ficar colocando mais linhas de código que serão removidas posteriormente.

Uma vez que você criou o breakpoint e executou o jogo, ele vai parar exatamente na linha em que está o breakpoint. Inicialmente você verá algo como a tela abaixo. Terá uma setinha amarela à esquerda do script apontando para a linha do breakpoint e também no painel você poderá inspecionar o estado de algumas variáveis em *Debbuger → Stack Trace*.

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/d5a774aa-944f-4379-adfe-3c48de743fd8" />
</p>

Para prosseguir, você pode clicar na aba *Debug* logo acima do script e selecionar *Step Into* ou *Step Over*. A primeira prossegue para a próxima linha da execução e entra nas linhas das funções, enquanto que a segunda não entra nas funções (considera a função como uma única linha e faz a execução toda em uma passo). A opção *Continue* sai do modo de pausa e continua a execução do jogo normalmente. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/cef6a2d0-66ee-4cdd-b2c8-1c3be0213cf2" />
</p>

## Debug project settings

No *Project Settings* há diversas configurações de Debug que podem ser interessantes de alterar dependo do projeto e do desenvolvedor. Para acessar, vá em *Project → Project Settings → General → Debug* (é necessário ativar as opções avançadas). Segue abaixo uma breve descrição de cada campo. 

- **Settings:** Estas são algumas configurações gerais, como imprimir o FPS atual no painel de output, a quantidade máxima de funções durante a criação de perfil e outras.
- **File Logging:** Estas configurações permitem registrar os logs do console e mensagens de erro em arquivos.
- **GDScript:** Estas configurações permitem ativar/desativar avisos específicos do GDScript. Você também pode desativar os avisos completamente. Consulte o tutorial [GDScript warning system](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20warning%20system) para obter mais informações.
- **Shader Language:** Estas configurações permitem ativar/desativar avisos específicos do shaders. Você também pode desativar os avisos completamente.
- **Canvas Items:** Estas configurações são para debug de redraw de itens da tela.
- **Shapes:** Você pode ajustar a cor de formas que aparecem apenas para fins de debug, como formas de colisão e navegação.

### Opções avançadas do Project Settings

Em várias partes do tutorial foi dito que era necessário ativar as opções avançadas, como feito logo acima. Para esclarecer, esta opção está à direita na janela do *Project → Project Settings → General*, como indicado na imagem abaixo.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/b99a332b-6d9a-4eb7-aeca-94f0334c071c" />
</p>

Vou deixar aqui como referência as abas que tem diferente entre o modo normal de avançado.

<p align="center">
  <img width="150" src="https://github.com/user-attachments/assets/baf62b32-3618-495a-89ab-f847b4ca451a" />
  <img width="160" src="https://github.com/user-attachments/assets/59aa7c8b-b179-4e47-a4f5-3e44e523dec4" />
</p>

## Remote in scene dock

Ao executar um jogo no editor, duas opções aparecem na parte superior do painel *Scene*: *Remote* e *Local*. Ao usar a opção *Remote*, você pode inspecionar ou alterar os parâmetros dos nodes do projeto em execução. A opção *Local* é o conjunto comum dos nodes que você manipula durante o desenvolvimento.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/7f1136a7-ec41-4fb6-a97b-edeb4bd1f2a4" />
</p>

Eu já usei bastante a aba *Remote* em projetos anteriores para saber se certas instâncias estavam sendo criadas ou não na cena durante a execução.
