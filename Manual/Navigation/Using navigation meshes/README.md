# Using navigation meshes

Uma *navigation mesh* (malha de navegação) é a região por onde o agente pode navegar. Isso é diferente da `NavigationRegion` que é o node representando esta região. Podemos dizer que a malha de navegação é o objeto abstrato/teórico. As versões 2D e 3D da malha de navegação estão disponíveis como `NavigationPolygon` e `NavigationMesh`, respectivamente.

PS: Para fazer o desenho da região do `NavigationRegion`, nós utilizamos o `NavigationPolygon`.

## Colisão e navigation mesh

Uma malha de navegação descreve apenas a área transitável a partir do centro do agente. Se você deseja que o algoritmo de busca de caminho leve em consideração o tamanho (de colisão) do agente, você precisa reduzir a malha de navegação de acordo. Além disso, a navegação não leva em consideração a renderização ou física. As malhas de navegação são os únicos elementos considerados no cálculo de caminhos. Elementos visuais e shapes de colisão são completamente ignorados pelo sistema de navegação. Se você precisar levar em conta outros dados no cálculo de caminhos, precisará adaptar suas malhas de navegação de acordo.

## Baking

O *baking* pode ser visto como uma compilação dos parâmetros da malha de navegação. Uma vez que essa compilação foi feita, o servidor passa a atualizar a região sempre a partir dos mesmos parâmetros. Vamos mostrar na prática como funciona. Primeiro crie um `NavigationRegion2D` e dentro do *Inspector* dele habilite o `NavigationPolygon` para poder começar a desenhar a região no editor.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/359340b7-7fe9-4b03-892e-a90d22a795e1" />
</p>

Clique novamente na aba do `NavigationPolygon` e as opções deste recurso vão aparecer no *Inspector*. Ao alterar estes parâmetros, as mudanças só terão efeito após você fazer um *baking* (botão *Bake NavigationPolygon*, acima da área de desenho) no objeto. Depois disso, você pode alterar o desenho da região à vontade, ela sempre vai respeitar os novos parâmetros definidos.

<p align="center">
  <img width="400" alt="image" src="https://github.com/user-attachments/assets/ab5da789-1c93-40fe-a9cc-90c562bdd4f8" />
  <img width="400" alt="image" src="https://github.com/user-attachments/assets/110b372e-9078-467b-91aa-c12b47fa2988" />
</p>

- **Sampling/Partition Type:** Define o algoritmo para o particionamento da malha. Mostramos lado a lado os dois tipos principais da Godot.

<p align="center">
  <img width="500" alt="image" src="https://github.com/user-attachments/assets/fab3a431-09fd-46e8-a82d-569ef9aa1d09" />
  <img width="500" alt="image" src="https://github.com/user-attachments/assets/22e9c862-3670-4bff-b8a2-4e684167b70f" />  
</p>

- **Geometry/Parsed Geometry Type:** Antes mesmo de fazer o baking, a engine analisa todas as geometrias que são filhas do node da região de navegação. A que você desenha com o `NavigationPolygon` é a única encontrada caso nada mais seja feito. Caso tenha alguma outra geometria, ela também entra na conta. Os tipos de geometria para serem considerados são:
    - *Meshes Instances*: Apenas objetos de desenho, como `Polygon2D`.
    - *Static Colliders*: Apenas objetos físicos estáticos, como `StaticBody2D`.
    - *Meshes and Static Colliders*: Ambos acima.
  Abaixo, temos um exemplo de um `Polygon2D` desenhado dentro de uma região de navegação. Note que ele cria um "buraco" na região.

<p align="center">
  <img width="200" alt="image" src="https://github.com/user-attachments/assets/f1b30559-94e9-47e3-bbb7-44f9c4674f4b" />
  <img width="600" alt="image" src="https://github.com/user-attachments/assets/c636cca1-dd48-41e6-b486-847385993604" />
</p>

> PS: Caso seja escolhida a opção *Static Colliders* ou *Meshes and Static Colliders*, vai aparecer no *Inspector* uma seleção de camadas de colisão. Apenas os objetos nas camadas selecionadas são considerados.

- **Geometry/Source Geometry Mode:** Não é obrigatório que os nodes a serem incluídos no cálculo da geometria sejam filhos do node de navegação. Caso você queira incluir nodes de fora, basta criar um grupo para eles. As opções são:
    - *Root Node Children:* É a opção default. Apenas os nodes filhos são considerados no cálculo da geometria.
    - *Group With Children:* Inclui todos os nodes que estão no grupo, assim como os filhos dos nodes no grupo, e os filhos dos filhos, (faz-se uma busca recursiva).
    - *Group Explicit:* Inclui todos os nodes que estão no grupo.
- **Geometry/Source Geometry Group Name:** É o nome do grupo a ser considerado, caso alguma escolha de grupo seja feita em *Source Geometry Mode*.
  Abaixo, a condinuação do exemplo anterior, mas agora incluindo na geometria um `StaticBody2D` que não é filho do `NavigationRegion2D`.

<p align="center">
  <img width="180" alt="image" src="https://github.com/user-attachments/assets/1fdabf69-cfbb-4137-9571-31171b1c1156" />
  <img width="600" alt="image" src="https://github.com/user-attachments/assets/d1b2a3d4-15fe-4364-8f3a-6343c745630a" />
</p>

- **Cells/Cell Size:** Este parâmetro define o tamanho da grade de rasterização e deve corresponder ao tamanho do mapa de navegação. Até o momento eu não vi ele fazer nenhuma diferença. Recomendar deixar no default e não tocar mais.
- **Cells/Border Size, Filters:** Para falar do *Border Size* temos que falar das propriedades do *Filters* também. Por default, a engine sempre determina um retângulo oculto que fica envolta da região de navegação. Esse retângulo sempre é calculado automaticamente quando os atributos de *Filters/Baking Rect* estão zerados. A coordenada $(x, y)$ determina o vértice superior esquerda do retângulo, enquanto que os parâmetros *w, h* determinam a largura e a altura, respectivamente. Na figura abaixo, alteramos um pouco estes valores, daí o retângulo fica visível. Note que nem toda a região de navegação foi calculado após o baking por causa do retângulo definido.

<p align="center">
  <img width="700" alt="image" src="https://github.com/user-attachments/assets/69e73db4-8cbe-4723-8298-e93e65d95f10" />
</p>

  O parâmetro *Border Size* determina uma margem a partir do retângulo principal. Isto afeta o baking, podendo gerar regiões de navegações mais limitadas. Veremos mais adiante como isso pode ser útil.

<p align="center">
  <img width="700" alt="image" src="https://github.com/user-attachments/assets/ea90a88c-0f1f-4465-9d40-16693ccd3db0" />
</p>

- **Agents/Radius:** É a borda que existe para cada objeto de geometria inserido na região de navegação. A figura abaixo deixa claro como funciona.

<p align="center">
  <img width="314" alt="image" src="https://github.com/user-attachments/assets/81d78d82-636a-4eab-8914-e8de34227ad7" />
  <img width="335" alt="image" src="https://github.com/user-attachments/assets/81e9b1d2-19ae-4933-80a9-4c8e597c94b6" />
  <img width="344" alt="image" src="https://github.com/user-attachments/assets/82ea49e0-3cfd-4586-8a05-1de590d83c0a" />
</p>
