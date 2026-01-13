# Using NavigationAgents

Já usamos o node `NavigationAgent2D` no [primeiro tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview#navigationagent2d) de navegação. Podemos considerar que este tutorial de agora é uma continuação do que vimos lá sobre este node. Em particular, vale a pena notar que este node pode acessar todos os parâmetros que vimos anteriormente em [NavigationPathQueryObjects](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationPathQueryObjects).

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/50e4a95a-1366-4ec0-90cf-6ef62c65161d" />
</p>

Se todos os parâmetros podem ser acessados diretamente por este node, então qual o propósito de usar tudo aquilo que vimos com query? Acontece que nem sempre queremos um caminho para usar em agente especificamente, apenas queremos o caminho. O acesso direto ao servidor tem os seus usos. 

## NavigationAgent Avoidance

Quando temos múltiplos agentes percorrendo diversos caminhos ao mesmo tempo, é interessante que eles tenham a capacidade de esbarrar um no outro. Para obter este comportamento, devemos habilitar a *evitação* (*avoidance*) no *Inspector* do `NavigationAgent2D`. Feito isso, agora o agente é capaz de identificar todos os outros agentes que também tem essa propriedade habilitada. 

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/adfe213c-dc09-42e3-9ba6-a0c461384996" />
</p>

Ao habilitar a evitação, o servidor de navegação cria um círculo em torno do agente. Este círculo não interfere no caminho de navegação. Todos os agentes e seus círculos ficam em um espaço próprio, separado dos outros. Quando dois círculos deste espaço se tocam, o agente reconhece que esbarrou em outro agente com evitação, e assim eles evitam se sobrepor. 

Abaixo segue a descrição das propriedade associadas a evitação entre agentes.

  - **Radius:** É o raio do círculo que fica em torno do agente (em pixels). Você pode considerar este círculo como um shape de colisão para agentes de navegação.
  - **Neighbor Distance:** É o raio de busca do agente, em pixels. Para ele saber se há outros agentes com evitação habilitada, ele deve fazer essa busca a cada frame físico. Reduzir este raio melhora a performance, mas pode fazer com que o agente só detecte outros agentes muito em cima da hora.
  - **Max Neighbors:** Ao fazer a busca por outros agentes com evitação, você pode limitar o número de agentes encontrados para decidir que não é necessário mais buscar nada.
  - **Time Horizon Agents:** Para evitar outros agentes, é necessário saber não apenas a posição deles agora, mas a posição futura, pois eles podem estar se movendo também. Essa variável controla quantos segundos à frente o agente projeta o movimento dos outros agentes. Desta maneira, ele vai em uma direção que evita qualquer colisão futura. Valores muitos altos podem deixar o agente lento demais, uma vez que ele será extremamente cauteloso a cada frame.
  - **Time Horizon Obstacles:** Semelhante ao anterior, mas para agentes estáticos, os nodes `NavigationObstacles`. Iremos ver mais sobre este node no próximo tutorial.
  - **Max speed:**
