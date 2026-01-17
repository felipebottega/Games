# Using NavigationObstacles

Como o próprio nome indica, o node `NavigationObstacle2D` (e `NavigationObstacle3D`) serve para inserir obstáculos que serão percebidos pelo mapa ou pelos agentes ou ambos. Iremos ver os dois casos separadamente.

## NavigationObstacle percebido pelo mapa

Para criar um `NavigationObstacle2D` que é percebido pelo mapa, você deve criá-lo como filho do `NavigationRegion2D` e ativar a propriedade `Affect Navigation Mesh`. Feito isso, agora há duas possibilidades: você pode deixar o raio dele igual a zero e desenhar um polígono dentro da região, ou você pode fazer o raio positivo, aí o servidor de navegação ignora o polígono e considera apenas o círculo.

Na figura abaixo, é possível ver dois `NavigationObstacle2D` na cena. Note que o raio do node selecionado é positivo. Selecionamos o node que corresponde ao círculo da imagem. Depois de criar estes objetos e fazer o bake da região, eles criam buracos.  

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/5820fc97-be40-465b-878b-d0b117593b23" />
</p>

Vimos [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview#navigationregion2d) e [neste](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/2D%20navigation%20overview#navigationregion2d) que é possível criar buracos na região de navegação de outras maneiras. A vantagem do `NavigationObstacle2D` é que você pode ativar e desativar a propriedade `Affect Navigation Mesh` e refazer o bake da região em tempo de execução, de modo a remover o buraco quando quiser. Enquanto que nos outros métodos o buraco faz parte da região e removê-lo em tempo de execução iria requerer algumas gambiarras. 

## NavigationObstacle percebido pelos agentes

Outro ponto interessante do `NavigationObstacle2D` é que é possível tratar os buracos dele como objetos a serem evitados, não apenas colididos. Ao ativar a propriedade `Avoidance Enabled`, todos os agentes que estejam com a ativação ativada vão começar a tratar os buracos do `NavigationObstacle2D` com os métodos de evitação que usam para outros agentes. 

Se você quiser criar um `NavigationObstacle2D` para ser apenas evitado, e não um buraco, basta criá-lo sem ser filho do `NavigationRegion2D`. Deste modo o servidor o trata como algo a ser evitado, mas sem afetar a região de navegação. Você também pode desativar a opção `Affect Navigation Mesh` antes de fazer o bake, caso ele seja filho do `NavigationRegion2D`. O efeito é o mesmo.

## Raio do NavigationObstacle

Como mencionado antes, se o raio for zero, isso significa que o servidor espera que você desenhe um polígono para dar a shape. Caso contrário, qualquer polígono desenhado é descartado e o servidor só considera o círculo nas contas. A ideia de trabalhar com um círculo é por simplificação e performance. Caso seja um polígono, o servidor o considera como um objeto estático. Por outro lado, se for um círculo, ele pode se mover livremente, tendo pouco impacto de performance. Inclusive ele é considerado nas contas dos agentes com a evitação habilitada. 
