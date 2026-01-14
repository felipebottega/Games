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
  - **Max speed:** Velocidade máxima permitida para o agente se mover enquanto a evitação está habilitada.
  - **Avoidance Layers/Mask:** Funciona demaneira análoga às camadas físicas de colisão, só que restrito aos agentes com evitação. Se quiser dar uma relembrada no assunto, consulte [este tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Creating%20the%20enemy/Layers%20e%20Masks).
  - **Avoidance Priority:** Valor entre $0$ e $1$ que diz ao servidor o quanto aquele agente é prioritário na evitação. Em outras palavras, quanto maior o valor, mais os outros agentes vão priorizar evitar este agente. Valores baixos significam que este agente não precisa ser tão evitado assim, é menos relevante.

## velocity $\neq$ speed

No uso cotidiano do português, a palavra "velocidade" costuma ser empregada para indicar apenas a rapidez de um movimento, ou seja, um valor escalar. Caso seja o vetor de velocidade, é comum usar o termo "velocidade vetorial". No inglês, e na Godot, o termo "velocity" é usado para o vetor de velocidade. Para a "velocidade escalar" eles usam a palavra "speed". Apesar de ser detalhe, é bom deixar isso explícito uma vez que o uso da palavra na língua Portuguesa difere do uso na Godot. Eu já usei "velocidade" muitas vezes para me referir a rapidez, não ao vetor. Provavelmente ainda farei mais vezes, então espero que o contexto deixe claro o que quero dizer.

## Script para evitação/avoidance

Quando a evitação é ativada, o agente verifica a cada frame físico se deve desviar um pouco do caminho para evitar colisões com outros agentes. Esse desvio é um vetor em alguma direção, e o cálculo deste vetor depende dos parâmetros escolhidos acima. 

Para usar a evitação, é necessário criar o sinal de `velocity_computed`, como mostrado abaixo. Este sinal é ativado sempre que o vetor velocidade do agente é modificado. A função computa um vetor novo para o agente, que é mais seguro no sentido de evitar colisões com outros agentes (por isso se chama *safe_velocity*). 

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/ffd13854-3f36-4cbd-bcd6-d1d5107e675c" />
</p>

Colocamos abaixo o script normal à esquerda, onde o agente se move normalmente pelo caminho. Na direta, temos o caminho com a evitação implementada. No script normal, a nova direção calculada é passada diretamente para o vetor `velocity` do `CharacterBody2D`. No outro script, esse script é passado para o `$NavigationAgent2D.velocity`, Isso não altera em nada o `CharacterBody2D`, serve apenas para ativar o sinal e fazer o servidor calcular um novo vetor com as evitações. Aí sim, dentro da função do sinal, o vetor seguro é passado para o `CharacterBody2D`.

<table align="center">
  <tr>
    <td valign="top">
      <img width="475" src="https://github.com/user-attachments/assets/125a37f0-c4e0-4978-af12-7f983927d00a" />
    </td>
    <td valign="top">
      <img width="525" src="https://github.com/user-attachments/assets/3e0f2e4a-ea48-40d1-a803-58c91cf880f7" />
    </td>
  </tr>
</table>


