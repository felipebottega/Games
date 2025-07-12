# Custom drawing in 2D

As ferramentas de desenho customizado em Godot são bastante genéricas. Alguns exemplos de aplicação são: 

- Desenhar formas ou lógica que os nodes existentes não conseguem fazer, como um polígono animado especial.
- Desenhar um grande número de objetos simples, como uma grid ou um tabuleiro para um jogo 2D. O desenho personalizado evita a sobrecarga de usar um grande número de nodes, possivelmente reduzindo o uso de memória e melhorando o desempenho.
- Criar um controle de interface de usuário (UI) personalizado. Há muitos controles disponíveis, mas quando você tem necessidades incomuns, provavelmente precisará de um controle personalizado.

Os desenhos ficam no espaço de coordenadas do *Canvas Item* (https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Viewport%20and%20canvas%20transforms#atributo-transform), ou seja, as coordenadas do node pai. É importante ter isso em mente para não achar que está usando coordenadas da tela, pois algumas vezes pode não ser este o caso.

## _draw vs _queue_draw

Para desenhar na tela, existem duas chamadas de função básicas. A primeira função é a `_draw`. Ela é chamada apenas uma vez no script e é responsável por determinar o que será desenhado, as instruções. Quando a cena inicia, ela é chamada automaticamente e executa os desenhos na tela. A função `_queue_draw` pode ser chamada diversas vezes, ela é responsável por forçar a `_draw` a ser executada novamente caso seja necessário. 

Todas as instruções de desenho estão na `_draw`, as instruções não mudam. Existem várias maneiras de atualizar o desenho chamando a `_queue_draw` e tendo a mesma `_draw` de base. Uma ideia, por exmeplo, é que se desenhe um conjunto de pontos na tela a partir de uma lista. Nesse caso basta alterar a lista e chamar a `queue_draw` para alterar o desenho. 

## draw_polygon

Iremos aprender algumas ferramentas de desenho através de um exemplo. Vamos desenhar o logo da Godot! O primeiro passo é desenhar o formato de polígono do logo. Isso é feito com o script abaixo. Na função `draw_polygon`, os polígonos sempre conectarão seu último ponto definido ao primeiro para ter uma forma fechada.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/fd6de834-1061-438e-a72c-731e15e84806" />
  <img width="300" src="https://github.com/user-attachments/assets/9012efc9-e9ae-4f19-baa3-8eea4ded1350" />
</p>

> PS: Note que passamos uma lista com uma única cor para a função `draw_polygon`. Nesse caso ele é preenchido com essa única cor. A outra opção é passar uma cor por vértice, daí ele vai interpolar as cores de seu interior. Não há opção intermediária para o número de cores.

## draw_polyline

A função `draw_polyline` desenha segmentos de reta interconetados a partir de um conjunto de pontos dado. No script abaixo, passamos uma lista de pontos, uma cor para a boca e a largura da linha. Além destes parâmetros a função também possui o parâmetro *antialiased*, que por default é falso. Na imagem mais à direita mostramos como seria com o antialiased ativado.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/807e22e6-50b8-493f-988a-f58f37d5c649" />
  <img width="300" src="https://github.com/user-attachments/assets/81eaed36-2f3f-494d-84fa-33ae053daab1" />
  <img width="300" src="https://github.com/user-attachments/assets/efdcda21-87ad-44b3-9d59-74198165cf64" />
</p>

> PS: Diferentemente de `draw_polygon`, a função `draw_polyline` só trabalha com uma única cor.

## draw_circle

Desenhar os olhos é fácil, basta desenhar círculos. Na função `draw_circle` os parâmetros abaixo são: *centro do círculo, raio do círculo, cor do círculo*. Há ainda os seguintes parâmetros:
 - **filled:** Para preencher ou não o interior do círculo.
 - **width:** Espessura do círculo.
 - **antialised:** Se aplica ou não o antialised.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/385cb908-1cb2-4a67-8678-6f9d4569f853" />
  <img width="300" src="https://github.com/user-attachments/assets/a7a0c842-902c-43e5-aa14-6235346b6370" />
</p>

## draw_line

A função `draw_line` é bastante simples, você dá o ponto final e inicial e a função conecta estes pontos por uma linha. O último parâmetro após a cor é a espessura da linha. Esta função também permite o uso do parâmetro *antialised*.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/152e8f74-61de-4715-b345-e91cb234d35e" />
  <img width="300" src="https://github.com/user-attachments/assets/76d19fca-7173-496e-afad-386fab41bbd0" />
</p>

## draw_string

O node `Label` é o método mais comum de inserir textos na tela, mas também é possível fazer isso com a função `draw_string`. Os parâmetros passados para a função foram:  fonte, posição, texto, alinhamento, espessura e tamanho da fonte. Esta função possui diversos parâmetros, vale a pena olhar mais em detalhe caso queira utilizá-la.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/db0d4393-1669-4fe7-a9ef-efcd242cc50d" />
  <img width="300" src="https://github.com/user-attachments/assets/05f6911e-09da-4a7b-b1de-6778d760274d" />
</p>

## Mostrar o desenho no editor

O default do editor da Godot é só mostrar o seu desenho quando você roda a cena. Se quiser que ele apareça no editor, coloque o comando `@tool` no topo do script e vá em *Scenes → Reload Saved Scene*. É necessário fazer isso toda vez que a cena é atualizada.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/6056e4ba-cdc0-4ba3-9f9e-61c1064c5f82" />
</p>

## Animação

É possível obter alguns tipos de animação aplicando transformações lineares comuns da Godot. Por exemplo, adicionar um `_process` com `rotation += delta` rotaciona o desenho ao longo do centro do node pai (uma aplicação deste comportamento está implementado [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Movements%203)). Para rotacionar o desenho em torno do seu próprio centro, devemos deixar o centro do node pai e filho na mesma posição da tela. Para o node pai, basta utilizar o comando `position = Vector2(x, y)`. Para o filho, utilizamos a função `draw_set_transform`, que foi feita especificamente para ser a `Transform2D` dos desenhos.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7f247dff-7966-4f0f-a7a5-e4ef0b33a62b" />
</p>

Chamar a `queue_draw` para redesenhar a rotação a cada frame é bastante caro, mas aplicar a rotação da maneira acima é bem barata, pois apenas usamos transformações lineares sobre o objeto, nada foi redesenhado. Porém, existem casos em que redesenhar é inevitável. Vamos considerar a situação em que queremos que o comprimento da boca mude de tamanho. O código abaixo mostra a primeira vez que precisamos usar a `queue_draw`, pois agora o desenho muda a cada frame e precisa ser refeito.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/177400bb-17a3-47a0-adb6-7cc2ea8aaad1" />
</p>
