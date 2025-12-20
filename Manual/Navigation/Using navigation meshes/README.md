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


