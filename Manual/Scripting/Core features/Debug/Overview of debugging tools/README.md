# Overview of debugging tools

A Godot vem com um debugger e profiler poderosos para rastrear erros, inspecionar seu jogo em tempo de execução, monitorar métricas essenciais e medir o desempenho. Ele também oferece opções para visualizar caixas de colisão e polígonos de navegação no jogo em execução. Abaixo, temos os dois principais painéis responsáveis por esta parte. 

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/326b1c64-00f0-4872-8f06-58a8dff00064" />
  <img width="1100" src="https://github.com/user-attachments/assets/28431ac2-58bc-47ed-be5a-50091275a547" />
</p>

Entraremos mais em detalhes sobre cada painél acima nos tutoriais a seguir.

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


