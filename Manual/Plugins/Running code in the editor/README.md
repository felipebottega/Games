# Running code in the editor

Você já deve ter notado que algumas coisas rodam automaticamente no editor, como animações e partículas. Porém, nem tudo é assim. Se uma animação for realizada via código, por exemplo, você só verá esta animação ao rodar o jogo. 

Como veremos aqui, existem duas maneiras principais de conseguir fazer scripts rodarem no editor, sem precisar rodar o jogo para ver o que vai acontecer. Isto pode ser útil em inúmeras ocasiões.

## @tool

Este é um comando poderoso que faz o seu script ser automaticamente executado no editor. Para isso, basta colocar o comando `@tool` na primeira linha do script que deseja executar. Por ser um comando que faz o script ser executado sem ter um jogo rodando de verdade, é necessário tomar cuidado com o tipo de coisa que você vai executar. Em geral, você vai querer usar o `@tool` para visualizar certas dinâmicas visuais sem precisar abrir o jogo toda vez que quiser testar algo. Se o script faz coisas mais complexas, como adicionar e liberar nodes na cena, pode dar crash no programa. 

> PS: Se o seu script com `@tool` chama outro script, este outro script também precisa do `@tool` na primeira linha.

> PS: Ao adicionar ou remover o `@tool` do script, pode ser necessário reiniciar o editor para a mudança ter efeito.

### Engine.is_editor_hint()

Ao usar o `@tool`, você pode querer que certo trecho de código seja apenas executado no editor e outro trecho seja executado no jogo. Você pode usar a variável booleana `Engine.is_editor_hint()` para isso. Quando ela é true, o trecho é executado no editor, caso contrário o trecho é executado no jogo.

<p align="center">
  <img width="370" src="https://github.com/user-attachments/assets/c67a1642-d62c-487e-8412-e037d3fd14ec" />
</p>

### setter

Quando você cria uma variável com o `@export`, sabemos que ela pode ser editada pelo *Inspector*. É possível fazer com que o node do script se comporte de alguma maneira sempre que esta variável for modificado no *Inspector*. Para isso, isso um *setter*. O exemplo abaixo mostra como funciona.

<p align="center">
  <img width="240" src="https://github.com/user-attachments/assets/457c40f7-f166-4380-b8a5-7904e8e82e07" />
</p>

Sempre que o valor da variável for modificado no *Inspector*, o node (que é um `Sprite2D`) vai atualizar na hora para aquela nova velocidade e vai zerar a rotação (voltar para a rotação original). Note que isso só faz sentido no contexto do `@tool`, já que alterar o valor da variável no *Inspector* durante a execução do jogo não faz nenhuma diferença. 

Abaixo segue o código completo deste exemplo.

<p align="center">
  <img width="370" src="https://github.com/user-attachments/assets/709e4c70-4c3f-4842-9262-c0bf5658972a" />
</p>

## EditorScript

Como vimos, o comando `@tool` é adicionado a um node que esteja no jogo. Porém, e se você quiser executar (no editor) um script independente de qualquer node? A solução para isso é o *EditorScript*. 

Vá no *FileSystem* e dê o segundo clique do mouse para criar um script novo. Clique no ícone de estrutura destacado em azul na imagem abaixo. Isso irá abrir uma janela com opções, escolha a opção para herdar de *EditorScript* e crie o arquivo.

<p align="center">
  <img width="340" src="https://github.com/user-attachments/assets/be125437-a5ad-4c62-9359-3167921ca043" />
  <img width="600" src="https://github.com/user-attachments/assets/bf6cf034-5042-48a3-9dd2-3f6d0779a636" />
</p>

Feito isso, o script já terá um template apropriado para rodar no editor. Neste exemplo, o script foi editado para aumentar em 2x a escala do sprite.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/b54e812c-12b0-4beb-b9a1-48c6503004da" />
</p>

Para executar o script, basta clicar nele pelo *FileSystem* e selecionar *Run*. Isso vai executá-lo na hora dentro do próprio editor. 

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/531ca998-2d8b-4278-b65e-224295d429a2" />
</p>

⚠️ **Atenção:** As mudanças efetuadas pelo `@tool` não podem ser desfeitas. No exemplo acima, o script aplica uma rotação no sprite. Quando você fecha o editor, ele vai memorizar a rotação que o sprite tinha antes de fechar, ele não volta para a origem. É necessário ter cuidado com isso.
