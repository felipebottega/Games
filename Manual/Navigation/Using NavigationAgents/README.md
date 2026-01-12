# Using NavigationAgents

Já usamos o node `NavigationAgent2D` no [primeiro tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview#navigationagent2d) de navegação. Podemos considerar que este tutorial de agora é uma continuação do que vimos lá sobre este node. Em particular, vale a pena notar que este node pode acessar todos os parâmetros que vimos anteriormente em [NavigationPathQueryObjects](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationPathQueryObjects).

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/50e4a95a-1366-4ec0-90cf-6ef62c65161d" />
</p>

Se todos os parâmetros podem ser acessados diretamente por este node, então qual o propósito de usar tudo aquilo que vimos com query? Acontece que nem sempre queremos um caminho para usar em agente especificamente, apenas queremos o caminho. O acesso direto ao servidor tem os seus usos. 

## NavigationAgent Avoidance

Avoidance (evitação) 
