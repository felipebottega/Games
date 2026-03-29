# Complex Numbers

Uma coisa que eu sempre tive vontade de ter foi um aplicativo para visualizar de maneira interativa (e em tempo real) as raízes dos [polinômios de Littlewood](https://en.wikipedia.org/wiki/Littlewood_polynomial). Agora, com o que aprendi de Godot, isso é possível. O intuito deste texto não é detalhar todo o processo, mas apenas os aprendizados novos que adquiri com este projeto.

## Boot Splash 

Boot Splash (ou Boot Splash Screen) é uma tela de carregamento exibida durante a inicialização de um sistema operacional ou de um programa, geralmente antes da interface gráfica principal ser carregada. Na Godot o default é aparecer o logo da Godot e o nome "Godot Engine". É possível customizar isso e colocar o que você quiser, basta ir em *Project → Project Settings → General → Application → Boot Splash*. Ativando as opções avançadas você consegue controlar o tempo mínimo de exibição. Para este projeto, eu gerei um logo baseado no símbolo da integral de uma função, $\int f(x)\ dx$ e deixei para ficar na tela por pelo menos 1 segundo ($1000$ ms).

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/f72916be-d551-401b-8bf7-1ce61501a358" />
  <img width="400" src="https://github.com/user-attachments/assets/44bc8d7c-83ab-4c1c-ad3d-72c1d04f4830" />
</p>

## Script externo

Nem todo script do projeto precisa estar associado a um node para ser executado no jogo. É possível criar scripts que terão um papel análogo a uma biblioteca de Python, você importa aquele script para usar as funcionalidades dele em outros scripts. No caso deste projeto, eu criei o arquivo `complex.gd`, que é basicamente uma biblioteca para trabalhar com números complexos em Godot. 

Sempre que você definir um script para este propósito, a primeira linha dele deve ser da forma `class_name {nome}`, em que *nome* é qualquer nome que você queria dar para o seu script. Esta linha faz com que o script possa ser acessado globalmente através desse nome. Para este projeto eu utilizei `class_name ComplexLib`. Então, por exemplo, o script `littlewood_polynomials.gd` necessita chamar a função `find_roots` do *ComplexLib*. Para isto, faz a chamada `ComplexLib.find_roots`. Não é necessário fazer nenhum tipo de "import", a `ComplexLib` é acessível globalmente.

> PS: Funções soltas no script externo precisam ser declaradas como `static`.

## Botões globais

Uma coisa que eu aprendi neste projeto foi criar um único botão na main e deixar ele acessível a todos os seus filhos em vez de criar repetidos botões iguais em todas as cenas. Pode parecer bobo, mas a mentalidade de ter um conjunto de botões por cena é bem natural e pode te levar a repetir nodes desnecessariamente. Pior, você ainda vai perder tempo ajustando a posição para "encaixar" com a posição do mesmo em outra cena. É bom ter esse pequeno truque em mente.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/c068b381-4dd6-45f0-995e-ca5aab655893" />
</p>

## Desenhando retas e círculos

Do tutorial de desenho, utilizamos as funções de desenhar retas e círculos. Diferentemente do tutorial, aqui a função `queue_draw` foi chamada extensivamente. Para atualizar os desenhos, note que deixamos as variáveis `zeros, pointsize` e `point_scale` externas à função `draw`. Toda a lógica de atualizar os desenhos se baseou em atualizar estas variáveis apenas.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/371db4bd-c395-4e84-8693-0702c451cb88" />
</p>
