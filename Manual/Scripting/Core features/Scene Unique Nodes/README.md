# Scene Unique Nodes

Acessar nodes pelo caminho pode ser um método frágil às vezes. Se você precisar mover um node na árvore e vários códigos referenciavam o caminho até este node, você terá que reescrever o caminho em todos eles. A solução para isso é o *unique node* (ou *unique name*). Chamaremos ele de *node único*.

## Criando nodes únicos

Para fazer um node ser único, basta dar o segundo clique do mouse (clique direito) nele e habilitar a opção *Access as Unique Name*.

<p align="center">
  <img width="330" src="https://github.com/user-attachments/assets/6ca13b2f-04a5-4cfc-a2fc-b56af49f80f1" />
</p>

Ao fazer isso, vai aparecer um símbolo de percentual (%) junto aos ícones do node na árvore da cena. Isso indica que agora ele de fato é um *node único*.

<p align="center">
  <img width="230" src="https://github.com/user-attachments/assets/95887127-2ee7-4304-b854-851575382aba" />
</p>

Outra maneira de fazer o node ser único é simplesmente renomear o nome dele colocando o símbolo de percentual (%) na frente do nome. O editor automaticamente vai convertê-lo para um node único.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/6e8392ed-2086-4fb1-b49d-efbc5b11a33d" />
</p>

## Aplicação

Se a label não for node único, é necessário usar o comando `get_node("Button1/Label")` ou `$Button1/Label` para acessá-la. Como node único, você pode acessá-la diretamente com `get_node("%Label")` ou `%Label`.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/d03ac77f-e4ce-45db-a8a7-5726c8e66662" />
</p>

## Nodes únicos em outras cenas

Continuando no mesmo exemplo, suponha que a cena principal é um `Node2D` contendo um `Sprite2D` de background, e queremos inserir a cena do `CanvasLayer` aí. Clicamos no ícone de cadeado destacado em vermelho e selecionamos a cena para inserir.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/88b71796-fe42-4d52-9287-9f5ab6ae6459" />
</p>

Neste caso não é possível acessar o node único a partir de um script em `Node2D`. Este atalho foi feito para funcionar unicamente entre os nodes da própria cena. Apesar de um comando como `var label = $%Label` não ser possível a partir de `Node2D`, o comando `var label = $CanvasLayer/%Label` é possível. Ou seja, a engine primeiro acessa o node raíz da cena (inserida) que contém o node único e a partir dali pode-se usar o atalho até ele. 

À primeira vista pode parecer uma limitação não poder acessar o node único diretamente quando a cena foi inserida em outra cena. Porém, isso é na verdade uma coisa boa. Se tivéssemos mais de uma instância da cena `CanvasLayer` inserida, não existiria nenhum critério para decidir qual node único deveria ser acessado pelo atalho. Por ser necessário especificar a cena instanciada no caminho, essa ambiguidade desaparece.

## Alternativas

Apesar de nodes únicos serem convenientes, eles não são a única solução para o problema exposto no início deste tutorial. Caso você precise acessar um node e ele muda de caminho durante o desenvolvimento do projeto, existem outras duas maneiras para evitar que isso seja uma dor de cabeça.

1. Coloque este node em um grupo, podendo até ser um grupo que contém apenas este node. Desta maneira, é fácil acessá-lo diretamente sem se importar onde ele se encontra na árvore.
2. Armazene o caminho até o node um uma variável global do autoload. Desta maneira, só precisa atualizar o caminho no autoload caso ele mude de lugar. Todos os scripts do jogo acessam o caminho armazenado na variável global.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Using%20SceneTree">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Logging">Próximo ➡</a>
</p>
